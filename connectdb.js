import mysql from 'mysql2';

import dotenv from 'dotenv';

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
    const date = new Date();
    const [result] = await pool.query(`
    INSERT INTO Tests(test_name, creation_date, created_by, min_score)
    VALUES (?, ?, ?, ?)
    `,[name, String(date.toISOString().split('T')[0]), userid, min_score]);
    await linkQuestionToTest(result.insertId, questionIds);
    console.log("test created with id: " + result.insertId);
    return getTestById(result.insertId);
}

export async function linkQuestionToTest(testId, questionIds){
    for await (const questionId of questionIds){
        await pool.query(`
        INSERT INTO Question_in_Test(question_id, test_id)
        VALUES (?, ?)
        `,[+questionId,testId]);
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
    const [result] = await pool.query(`
    DELETE FROM Questions
    WHERE question_id = ?
    `,[id]);
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