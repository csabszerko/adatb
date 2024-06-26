import mysql from 'mysql2';

import dotenv from 'dotenv';

import moment from 'moment-timezone';

const timezone = 'Europe/Budapest';

dotenv.config()

const pool = mysql.createPool({
    host: process.env.SQLHOST,
    user: process.env.SQLUSER,
    password: process.env.SQLPW,
    database: process.env.SQLDB,
    connectionLimit: 10
}).promise();

//USER

export async function getUsers(){
    const [result] = await pool.query("SELECT * FROM Users");
    return result;
}

export async function getUserById(id)
{
    const [result] = await pool.query("SELECT * FROM Users WHERE user_id=?",[id]);
    return result[0];
}

export async function getUserByUsername(username)
{
    const [result] = await pool.query("SELECT * FROM Users WHERE username=?",[username]);
    return result[0];
}

export async function createUser(username, name, pw, role){
    const [result] = await pool.query(`
    INSERT INTO Users(username, name, password, role)
    VALUES (?, ?, ?, ?)
    `,[username, name, pw, role]);
    console.log("user created with id: " + result.insertId);
    return getUserById(result.insertId);
}

//TESTS

export async function getTests(){
    const [result] = await pool.query("SELECT * FROM Tests");
    return result;
}

export async function getTestById(id)
{
    const [result] = await pool.query("SELECT * FROM Tests WHERE test_id=?",[id]);
    return result[0];
}

export async function createTest(name, min_score, userid, questionIds){
    const date = moment().tz(timezone).toISOString().split('T')[0];
    const [result] = await pool.query(`
    INSERT INTO Tests(test_name, creation_date, created_by, min_score)
    VALUES (?, ?, ?, ?)
    `,[name, date, userid, min_score]);
    await linkQuestionToTest(result.insertId, questionIds);
    console.log("test created with id: " + result.insertId);
    return getTestById(result.insertId);
}

export async function linkQuestionToTest(testId, questionIds){
    if(questionIds){
        for await (const questionId of questionIds){
            await pool.query(`
            INSERT INTO Question_in_Test(question_id, test_id)
            VALUES (?, ?)
            `,[+questionId,testId]);
        }
    }
}

export async function deleteLinkedQuestions(id){
    const [result] = await pool.query(`
    DELETE FROM Question_in_Test
    WHERE test_id = ?
    `,[id]);
}

export async function getQuestionsInTest(id){
    const [result] = await pool.query(
    `SELECT Questions.question_id, Questions.question_text, Questions.correct_answer_index, 
    Questions.answer1, Questions.answer2, Questions.answer3, Questions.answer4, Questions.answer5, Questions.max_score
    FROM Tests
    JOIN Question_in_Test ON Tests.test_id = Question_in_Test.test_id
    JOIN Questions ON Question_in_Test.question_id = Questions.question_id
    WHERE Tests.test_id =?`,[id]
    );
    return result;
}

export async function updateLinkedQuestions(testId, questionIds){
    if(questionIds === undefined){
        deleteLinkedQuestions(testId);
    }else{
        await deleteLinkedQuestions(testId);
        await linkQuestionToTest(testId, questionIds);
    }
}

export async function deleteTest(id){
    await pool.query(`
    DELETE FROM Question_in_Test
    WHERE test_id = ?
    `,[id]);

    await deleteUserAnswers(id);

    await pool.query(`
    DELETE FROM Submissions
    WHERE test_id = ?
    `,[id]);

    const [result] = await pool.query(`
    DELETE FROM Tests
    WHERE test_id = ?
    `,[id]);
}

export async function editTest(id, name, min_score, questionIds){
    const [result] = await pool.query(`
    UPDATE Tests
    SET test_name = ?, min_score = ?
    WHERE test_id = ? 
    `,[name, min_score, id]);
    updateLinkedQuestions(id, questionIds);
}

export async function deleteUserAnswers(id)
{
    const [result] = await pool.query("SELECT * FROM Submissions WHERE test_id=?",[id]);

    for await (const submission of result){
        await pool.query(`
        DELETE FROM UserAnswers
        WHERE submission_id = ?
        `,[submission.submission_id]);
    }
    
}


//QUESTIONS

export async function getQuestions(){
    const [result] = await pool.query("SELECT * FROM Questions");
    return result;
}

export async function getQuestionById(id)
{
    const [result] = await pool.query("SELECT * FROM Questions WHERE question_id=?",[id]);
    return result[0];
}

export async function getQuestionAnswers(id)
{
    const [result] = await pool.query("SELECT answer1, answer2, answer3, answer4, answer5 FROM Questions WHERE question_id=?",[id]);
    return [result[0].answer1, result[0].answer2, result[0].answer3, result[0].answer4, result[0].answer5];
}

export async function editQuestion(question_text, ans1, ans2, ans3, ans4, ans5, correct_index, max_score, id){
    const [result] = await pool.query(`
    UPDATE Questions
    SET question_text=?, answer1=?, answer2=?, answer3=?, answer4=?, answer5=?, correct_answer_index=?, max_score=?
    WHERE question_id = ?
    `,[question_text, ans1, ans2, ans3, ans4, ans5, correct_index, max_score, id]);
    console.log("question edited with id: " + result.insertId);
    return getQuestionById(result.insertId);
}

export async function createQuestion(question_text, ans1, ans2, ans3, ans4, ans5, correct_index, max_score){
    const [result] = await pool.query(`
    INSERT INTO Questions(question_text, answer1, answer2, answer3, answer4, answer5, correct_answer_index, max_score)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `,[question_text, ans1, ans2, ans3, ans4, ans5, correct_index, max_score]);
    console.log("question created with id: " + result.insertId);
    return getQuestionById(result.insertId);
}

export async function deleteQuestion(id){
    await pool.query(`
    DELETE FROM Question_in_Test
    WHERE question_id = ?
    `,[id]);

    await pool.query(`
        DELETE FROM UserAnswers
        WHERE question_id = ?
        `,[id]);

    const [result] = await pool.query(`
    DELETE FROM Questions
    WHERE question_id = ?
    `,[id]);
}

//SUBMISSIONS

export async function createSubmission(user_id, test_id, time){
    const [result] = await pool.query(`
    INSERT INTO Submissions(user_id, test_id, submission_time)
    VALUES (?, ?, ?)
    `,[user_id, test_id, time]);
    console.log("submission logged with id: " + result.insertId);
}

export async function logSubmissionResults(results, submission_id){
    const [result] = await pool.query(`
    UPDATE Submissions
    SET results=?
    WHERE submission_id = ?
    `,[results, submission_id]);
    console.log("submission updated with id: " + result.insertId);
}

export async function getSubmission(id)
{
    const [result] = await pool.query("SELECT * FROM Submissions WHERE submission_id=?",[id]);
    return result[0];
}

export async function getUserSubmissions(id)
{
    const [result] = await pool.query("SELECT * FROM Submissions WHERE user_id=?",[id]);
    return result;
}

export async function getLatestSubmission(user_id, test_id)
{
    const [result] = await pool.query(`
    SELECT *
    FROM Submissions
    WHERE user_id = ? AND test_id = ?
    ORDER BY submission_id DESC
    LIMIT 1;
    `,[user_id, test_id]);
    return result[0];
}

export async function getSubmissionCountForTest(user_id, test_id)
{
    const [result] = await pool.query(`
    SELECT
        Tests.test_id,
        Tests.test_name,
        COUNT(Submissions.submission_id) AS submission_count
    FROM Tests
    LEFT JOIN Submissions ON Tests.test_id = Submissions.test_id
    WHERE Submissions.user_id = ? AND Tests.test_id = ?
    GROUP BY Tests.test_id, Tests.test_name;
    `,[user_id, test_id]);
    // console.log(result);
    return result[0];
}

export async function getAvgScoreForTest(user_id, test_id)
{
    const [result] = await pool.query(`
    SELECT
        Users.user_id,
        Users.username,
        AVG(Submissions.results) AS average_score,
        COUNT(Submissions.submission_id) AS submission_count
    FROM Users
    LEFT JOIN Submissions ON Users.user_id = Submissions.user_id
    WHERE Users.user_id = ? AND Submissions.test_id = ?
    GROUP BY Users.user_id, Users.username;
    `,[user_id, test_id]);
    return result[0];
}


export async function getSubmissionsForTest(id)
{
    const [result] = await pool.query(`
    SELECT Users.username, Users.name, Submissions.submission_time, Submissions.results
    FROM Users
    JOIN Submissions ON Users.user_id = Submissions.user_id
    WHERE Submissions.test_id = ?
    ORDER BY Users.name ASC;
    `,[id]);
    return result;
}

export async function getBestResults(id){
    const [result] = await pool.query(`
    SELECT
    username,
    name,
    highest_result,
    submission_time
    FROM (
        SELECT
            Users.username,
            Users.name,
            Submissions.results AS highest_result,
            Submissions.submission_time,
            ROW_NUMBER() OVER (PARTITION BY Submissions.user_id ORDER BY Submissions.results DESC, Submissions.submission_time) AS row_num
        FROM Submissions
        JOIN Users ON  Submissions.user_id = Users.user_id
        WHERE Submissions.test_id = ?
    ) AS RankedSubmissions
    WHERE row_num = 1 ORDER BY name;
    `,[id]);
    return result;
}

//ANSWERS

export async function storeSubmissionAnswers(submission_id, question_id, chosen_answer_index){
    const [result] = await pool.query(`
    INSERT INTO UserAnswers(submission_id, question_id, chosen_answer_index)
    VALUES (?, ?, ?)
    `,[submission_id, question_id, chosen_answer_index]);
    console.log("answers logged with id: " + result.insertId);
}

//COOKIES

export async function updateCookie(username, cookie){
    const [result] = await pool.query(`
    UPDATE Users
    SET cookie = ?
    WHERE username = ? 
    `,[cookie, username]);
    console.log("user cookie updated with user id:" + result.insertId);
}

export async function checkCookie(cookie){
    const [result] = await pool.query(`
    SELECT * FROM Users WHERE cookie = ?
    `,[cookie]);
    return result[0];
}

export async function deleteCookie(cookie){
    const [result] = await pool.query(`
    UPDATE Users
    SET cookie = NULL
    WHERE cookie = ? 
    `,[cookie]);
}