const express = require('express')
const oracledb = require('oracledb');
oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

const app = express();
const bodyParser = require("body-parser");
const port = 3000;

app.use(bodyParser.json());

// database configuration
const dbConfig = require('./db.config');
const connectionData = dbConfig.connectionData;

async function selectAllUsers(req, res) {
  try {
    connection = await oracledb.getConnection(connectionData);

    console.log('connected to database');
    // run query to get all users
    result = await connection.execute(
      `SELECT ID as "id", NAME as "name", EMAIL as "email", CREATED as "created" FROM SD_USER`
      );

  } catch (err) {
    //send error message
    return res.send(err.message);
  } finally {
    if (connection) {
      try {
        // Always close connections
        await connection.close();
        console.log('close connection success');
      } catch (err) {
        console.error(err.message);
      }
    }
    if (result.rows.length == 0) {
      //query return zero users
      return res.send('query send no rows');
    } else {
      //send all users
      return res.json(result.rows);
    }

  }
}

//get /users
app.get('/api/users', function (req, res) {
  selectAllUsers(req, res);
})


async function selectUserById(req, res, id) {
  try {
    connection = await oracledb.getConnection(connectionData);
    // run query to get user with user_id
    result = await connection.execute(`SELECT ID as "id", NAME as "name", EMAIL as "email", CREATED as "created" FROM CUSTOMER where ID=:id`, [id]);

  } catch (err) {
    //send error message
    return res.send(err.message);
  } finally {
    if (connection) {
      try {
        // Always close connections
        await connection.close();
      } catch (err) {
        return console.error(err.message);
      }
    }
    if (result.rows.length == 0) {
      //query return zero users
      return res.send('query send no rows');
    } else {
      //send all users
      return res.json(result.rows);
    }
  }
}

//get /user?id=<id user>
app.get('/api/user', function (req, res) {
  //get query param ?id
  let id = req.query.id;
  // id param if it is number
  if (isNaN(id)) {
    res.json('Query param id is not number')
    return
  }
  selectUserById(req, res, id);
})


app.listen(port, () => console.log("nodeOracleRestApi app listening on port %s!", port))