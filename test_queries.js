var db = require('./connectdb');

var xd = `INSERT INTO Users (username, password, name, role, is_logged_in, cookie)
 VALUES ("gatya", "paraszt2", "Zsoldos Tamàs", "user", true, "kuki")`

//  db.query(xd, function(err, result, fields) {
//     if (err) {
//         return console.log(err);
//     }
//     return console.log(result);
// })

db.query(`select name from Users WHERE username = "fasz"`, function(err, result, fields) {
    if (err) {
        return console.log(err);
    }
    return console.log(result);
})

db.query(`select name from Users WHERE role = ?`,["user"], function(err, result, fields) {
    if (err) {
        return console.log(err);
    }
    return console.log(result);
})

// const fs = require('fs');
// fs.readFile("./sql/test.sql", (err, data) => {
//     db.query(data, function(err, result, fields) {
//         if (err) {
//             return console.log(err);
//         }
//         return console.log(result);
//     });
// });



