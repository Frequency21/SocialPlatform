const express = require('express')
const oracledb = require('oracledb');
oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;
// adatbázis timezone-ja
process.env.ORA_SDTZ = 'Europe/Prague';

const app = express();
const bodyParser = require("body-parser");
const port = 3000;

app.use(bodyParser.json());

// database configuration
const dbConfig = require('./db.config');
const connectionData = dbConfig.connectionData;

//Querik
const SELECT_ALL_USER = `SELECT ID as "id", csatl_dat as "csatl", email as "email", f.nev.keresztnev as "knev", f.nev.vezeteknev as "vnev" FROM FELHASZNALO f`;
const SELECT_ALL_GROUP = 'SELECT cs.csoport_id AS "id", cs.leiras AS "leiras", cs.nev AS "nev", f.nev.keresztnev AS "tulaj_knev", f.nev.vezeteknev AS "tulaj_vnev" FROM CSOPORT cs INNER JOIN FELHASZNALO f ON cs.tulaj_id=f.ID';

async function selectAllUsers(req, res, query) {
  try {
    var connection = await oracledb.getConnection(connectionData);

    console.log('connected to database');
    // run query to get all users
    var result = await connection.execute(query);

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
      //query return zero users or something else
      return res.send('query send no rows');
    } else {
      //send all users
      return res.json(result.rows);
    }

  }
}

//get /users
app.get('/api/users', function (req, res) {
  selectAllUsers(req, res, SELECT_ALL_USER);
})

//get /groups
app.get('/api/groups', function(req, resp) {
  selectAllUsers(req, resp, SELECT_ALL_GROUP);
})


async function selectUserById(req, res, id) {
  try {
    var connection = await oracledb.getConnection(connectionData);
    // run query to get user with user_id
    var result = await connection.execute(
      `SELECT ID as "id", csatl_dat as "csatl", szul_dat as "szul_dat", email as "email", f.nev.keresztnev as "knev", f.nev.vezeteknev as "vnev" FROM FELHASZNALO f where ID=:id`, [id]
      );

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
  var id = req.query.id;
  // id param if it is number
  if (isNaN(+id)) {
    res.json('Query param id is not number')
    return
  }
  selectUserById(req, res, id);
})

// SELECT Group

async function selectGroupById(req, res, id) {
  try {
    var connection = await oracledb.getConnection(connectionData);
    // run query to get user with user_id
    var result = await connection.execute(
      `SELECT cs.csoport_id AS "id", cs.leiras AS "leiras", cs.nev AS "nev", f.nev.keresztnev AS "tulaj_knev", f.nev.vezeteknev AS "tulaj_vnev" FROM CSOPORT cs INNER JOIN FELHASZNALO f ON cs.tulaj_id=f.ID WHERE cs.csoport_id=:id`, [id]
      );

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


app.get('/api/group' , function(req, resp) {
  //get query param ?id
  var id = req.query.id;
  // id param if it is number
  if (isNaN(+id)) {
    res.json('Query param id is not number')
    return
  }
  selectGroupById(req, resp, id);
})

async function selectAllPoszt(req, res) {
  try {
    var connection = await oracledb.getConnection(connectionData);

    console.log('connected to database');
    // run query to get all users
    var poszts = await connection.execute(
      `SELECT id as "id", idopont as "idopont", szerzo_id as "szerzo_id", szerzo_nev as "szerzo_nev", szoveg as "szoveg", p.ertekeles.like_szamlalo as "like", p.ertekeles.dislike_szamlalo as "dislike", isPublic as "isPublic" FROM FELH_POSZT p`
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
    if (poszts.rows.length == 0) {
      //query return zero users
      return res.send('query send no rows');
    } else {
      //send all users
      return res.json(poszts.rows);
    }

  }
}

//get /users
app.get('/api/poszts', function (req, res) {
  selectAllPoszt(req, res);
})


// -------------- login ---------------
app.post('/api/login', function (req, res) {
  console.log('body:', req.body);
  // res.sendStatus(200);
  res.json({ "isOK": true, "age": req.body.age * 10 })
})

// -------------- register -----------
app.post('/api/register', function (req, res) {
  console.log('body:', req.body);



  res.sendStatus(200);
})
// asd
async function listUserIsmerosok(req, res, fh_id) {
  try {
    var connection = await oracledb.getConnection(connectionData);
    // run query to get ismerosok with user_id
    var result = await connection.execute(
      `SELECT ID as "id", csatl_dat as "csatl", szul_dat as "szul_dat", email as "email", f.nev.keresztnev as "knev", f.nev.vezeteknev as "vnev" FROM FELHASZNALO f INNER JOIN ismeros i on f.id=:fh_id and f.id = i.felhasznalo1_id`, [fh_id]
   );
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
      //query return zero data
      return res.send('query send no rows');
    } else {
      //send all data
      return res.json(result.rows);
    }
  }
}

//get ...
app.get('/api/ismerosok', function (req, res) {
  // ismerosok?fh='+felhasznalo_id
  var felhasznalo_id = req.query.fh;

  // id param if it is number
  if (isNaN(+felhasznalo_id)) {
    res.json('Query param is not number')
    return;
  }
  listUserIsmerosok(req, res, felhasznalo_id);
})

app.get('/api/fenykepalbum', function (req, res) {
  // /fenykepalbum?album='+ album_id);
  var album_id = req.query.album;

  // id param if it is number
  if (isNaN(+album_id)) {
    res.json('Query param is not number')
    return;
  }
  listUserIsmerosok(req, res, album_id); //tba
})

app.get('/api/kategorias', function (req, res) {
  // '/kategorias?fa=' + fenykepalbum_id);
  var fenykepalbum_id = req.query.fa;

  // id param if it is number
  if (isNaN(+fenykepalbum_id)) {
    res.json('Query param is not number')
    return;
  }
  listUserIsmerosok(req, res, felhasznalo_id);
})

app.get('/api/fenykeps', function (req, res) {
  // '/fenykeps?fa=' + fenykepalbum_id+'?kategorianev=' + kategorianev);
  var fenykepalbum_id = req.query.fa;
  var kategorianev = req.query.kategorianev;

  // id param if it is number
  if (isNaN(+fenykepalbum_id) || isNaN(+kategorianev)) {
    res.json('Query param is not number')
    return;
  }
  listUserIsmerosok(req, res, felhasznalo_id);
})

app.listen(port, () => console.log("nodeOracleRestApi app listening on port %s!", port))
