import express from 'express';

import * as db from './connectdb.js';
import * as hashMan from './hashmanager.js';

import cookieParser from 'cookie-parser';
import e from 'express';

const app = express();

app.use(cookieParser());
app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use(express.static("public"));
app.set("view engine", "ejs");

function generateCookie(length) {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let cookie = '';
  
    for (let i = 0; i < length; i++) {
      const randomIndex = Math.floor(Math.random() * characters.length);
      cookie += characters.charAt(randomIndex);
    }
    return cookie;
  }

async function getCurrUser(req){
    return await db.checkCookie(req.cookies.token);
}

function checkPerms(user){
    const perms = ["admin", 'teacher'];
    if(perms.includes(user.role)) return true;
    else return false;
}

//GET: MAIN PAGES

app.get("/", (req, res)=>{
    res.render("login.ejs");
});

app.get("/login", async (req, res)=>{
    if(await getCurrUser(req)){
        res.redirect("/tests");
    }else{
        res.render("login.ejs");
    }
});

app.get("/register", (req, res)=>{
    res.render("register.ejs");
})

app.get("/logout", async (req, res) => {
    await db.deleteCookie(req.cookies.token);
    res.clearCookie("token");
    res.redirect("/login");
  });

//POST: MAIN FEATURES

app.post("/login", async (req, res)=>{
    const {username, password} = req.body;
    const foundUser = await db.getUserByUsername(username);
    if(foundUser){
        const match = await hashMan.comparePassword(password, foundUser.password);
        if(match){
            const cookie = generateCookie(32);
            res.cookie("token", cookie);
            await db.updateCookie(foundUser.username, cookie);
            console.log("successful login");
            res.redirect("/tests");
        }
        else{
            res.send("wrong password!");
        }
    }else{
        res.send("No such user!");
    }
});

app.post("/register", async (req, res)=>{
    const {username, name, password, confirmPassword, role} = req.body;
    if(password == confirmPassword){
        try {
            const newUser = await db.createUser(username, name, await hashMan.hashPassword(password), role);
            res.redirect("/login")
        }
        catch (err) {
            res.send("duplicate usernames");
        }
        
    }else{
        res.send("Passwords don't match!");
    }
});

//GET: QUESTIONS

app.get("/questions", async (req, res)=>{
    const user = await getCurrUser(req);
    if(user && checkPerms(user)){
        const questions = await db.getQuestions();
        res.render("questions.ejs", {
            questions,
            user});
    } else{
        res.redirect("/login");
    }
});

app.get("/questions/create", async (req, res)=>{
    const user = await getCurrUser(req);
    if(user && checkPerms(user)){
        res.render("createQuestion.ejs", {user});
    } else{
        res.redirect("/login");
    }
});

app.get("/questions/:id", async (req, res) => {
    const user = await getCurrUser(req);
    if(user && checkPerms(user)){
        const id = +req.params.id;
        const question = await db.getQuestionById(id);
        const answers = await db.getQuestionAnswers(id);
        res.render("singleQuestion.ejs", {question, user, answers});
    } else {
        res.redirect("/login");
    }
});

app.get("/questions/edit/:id", async (req, res) => {
    const user = await getCurrUser(req);
    const id = +req.params.id;

    const question = await db.getQuestionById(id);
    const answers = await db.getQuestionAnswers(id);

    if(user && checkPerms(user)){
        res.render("editQuestion.ejs", {user, id, question, answers})
    }else res.redirect("/login");
});

app.get("/questions/delete/:id", async (req, res) => {
    const user = await getCurrUser(req);
    const id = +req.params.id;
    if(user && checkPerms(user)){
        // try {
            await db.deleteQuestion(id);
            res.redirect("/questions");
        // }
        // catch (err) {if(err){res.send("can not delete questions that are in tests!")}};
    }else res.redirect("/login");
});

//POST: QUESTIONS

app.post("/questions/create", async (req, res)=>{
    const user = await getCurrUser(req);
    if(user && checkPerms(user)){
        const {question_text, max_score, correct_answer_index, answer1, answer2, answer3, answer4, answer5} = req.body;
        const newQuestion = await db.createQuestion(question_text, answer1,answer2,answer3,answer4,answer5,correct_answer_index,max_score)
        res.redirect("/questions")
    }
    else res.send("invalid user");
});

app.post("/questions/edit/:id", async (req, res)=>{
    const user = await getCurrUser(req);
    const id = +req.params.id;
    if(user && checkPerms(user)){
        const {question_text, max_score, correct_answer_index, answer1, answer2, answer3, answer4, answer5} = req.body;
        await db.editQuestion(question_text, answer1,answer2,answer3,answer4,answer5,correct_answer_index,max_score, id);
        res.redirect("/questions/"+id)
    }
    else res.send("invalid user");
});

//GET: TESTS

app.get("/tests", async (req, res)=>{
    const user = await getCurrUser(req);
    if(user){ 
        const tests = await db.getTests();
        const userSubmissions = await db.getUserSubmissions(user.user_id);
        res.render("tests.ejs", {tests,user,userSubmissions});
    }else{
        res.redirect("/login");
    }
});

app.get("/tests/create", async (req, res)=>{
    const user = await getCurrUser(req);
    if(user && checkPerms(user)){
        const questions = await db.getQuestions();
        res.render("createTest.ejs", {user, questions});
    }else {
        res.redirect("/login");
    }
});

app.get("/tests/:id", async (req, res) => {
    const user = await getCurrUser(req);
    if(user){
        const id = +req.params.id;
        // console.log(id);
        const test = await db.getTestById(id);
        const creator = await db.getUserById(test.created_by);
        res.render("singleTest.ejs", {test, user, creator});
    } else res.redirect("/login");
});

app.get("/tests/edit/:id", async (req, res) => {
    const user = await getCurrUser(req);
    const id = +req.params.id;

    if(user && checkPerms(user)){
        const test = await db.getTestById(id);
        const questionsInTest = await db.getQuestionsInTest(id);
        // res.send(questionsInTest);
        const questions = await db.getQuestions();
        // console.log(questionsInTest, "INNNENTOL", questions);
        res.render("editTest.ejs", {user, id, test, questions, questionsInTest})
    }else res.redirect("/login");
});

app.get("/tests/fillout/:id", async (req, res) => {
    const user = await getCurrUser(req);
    const id = +req.params.id;

    if(user){
        const test = await db.getTestById(id);
        const questionsInTest = await db.getQuestionsInTest(id);
        const datetime = new Date().toISOString().slice(0, 19).replace('T', ' ');

        await db.createSubmission(user.user_id, test.test_id, datetime);
        // res.send(questionsInTest);
        res.render("fillOutTest.ejs", {user, id, test, questionsInTest})
    }else res.redirect("/login");
});

app.get("/tests/delete/:id", async (req, res) => {
    const user = await getCurrUser(req);
    const id = +req.params.id;

    if(user && checkPerms(user)){
        await db.deleteTest(id);
        res.redirect("/tests");
    }else res.redirect("/login");
});

//POST: TESTS

app.post("/tests/fillout/:id", async (req, res) => {
    const user = await getCurrUser(req);
    const id = +req.params.id;

    if(user){
        const answers = Object.values(req.body);
        // res.send(answers);
        const currentSubmission = await db.getLatestSubmission(user.user_id, id);
        const questionsInTest = await db.getQuestionsInTest(id);
        // res.send(questionsInTest[0]);
        // res.send(answers[0]);
        var score=0;
        for (var index = 0; index < questionsInTest.length; index++) {
            console.log("correct answer index: " + questionsInTest[index].correct_answer_index);
            console.log("user answer index: " + answers[index]);
            if(questionsInTest[index].correct_answer_index == answers[index]) score+=questionsInTest[index].max_score;
            // console.log(currentSubmission.submission_id, questionsInTest[index].question_id, answers[index]);
            await db.storeSubmissionAnswers(currentSubmission.submission_id, questionsInTest[index].question_id, answers[index]);
        }
        // res.send(String(score));
        await db.logSubmissionResults(score,currentSubmission.submission_id);
        res.redirect("/tests/"+id);
        // res.send(data);
    }else res.redirect("/login");
});

app.post("/tests/create", async (req, res)=>{
    const user = await getCurrUser(req);

    if(user && checkPerms(user)){
        const {testname, minscore, assignedQuestions} = req.body;
        // res.send(assignedQuestions);
        const newTest = await db.createTest(testname, minscore, user.user_id, assignedQuestions)
        res.redirect("/tests")
    }
    else res.send("invalid user");
});

app.post("/tests/", async (req, res)=>{
    const user = await getCurrUser(req)

    if(user){
        // console.log(user.user_id);
        const {testname, minscore} = req.body;
        const tests = await db.getTests();
        res.render("tests.ejs", {
            tests,
            user
        });
    }
    else res.send("invalid user");
});

app.post("/tests/edit/:id", async (req, res) => {
    const user = await getCurrUser(req);
    const {newname, min_score, assignedQuestions} = req.body;
    const id = +req.params.id;

    if(user && checkPerms(user)){
        db.editTest(id, newname, min_score, assignedQuestions);
        res.redirect("/tests/"+id)
    }else res.redirect("/login");
});

//END OF

app.use((err, req, res, next) => {
    console.error(err.stack)
    res.status(500).send('Something broke!')
  })

const port = 8080;

app.listen(port, ()=>{
    console.log(`server running at https://localhost:${port}`);
});