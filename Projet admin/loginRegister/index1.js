const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();

// enable CORS for all routes
app.use(cors());

// create a connection to the MySQL database
const connection = mysql.createConnection({
  host: "localhost",
    user: "root",
    password: "Lamadev123",
    database: "test",
});

// use body-parser middleware to parse request bodies
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// define a route for handling login requests
app.post('/login', (req, res) => {
  const { email, password } = req.body;

  // query the database to see if the user exists
  connection.query('SELECT * FROM admin WHERE email = ? AND password = ?',[email, password],(error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
        return;
      }

      if (results.length === 0) {
        // no user found with the specified email and password
        res.status(401).json({ message: 'Invalid email or password' });
      } else {
        // user found, send a success response
        res.status(200).json({ message: 'Login successful' });
      }
    }
  );
});


app.get('/addressChef', (req, res) => {
  connection.query('SELECT DISTINCT nomprenom, address FROM chefs', (err, rows) => {
    if (err) throw err;
    res.send(rows);
  });
});

app.get('/search', (req, res) => {
  const name = req.query.name; // Récupérer le paramètre name de la chaîne de requête
  const query = 'SELECT * FROM chefs WHERE nomprenom LIKE ?'; // Modifier la requête pour inclure une clause WHERE
  const params = [`%${name}%`]; // Définir la valeur du paramètre pour rechercher une sous-chaîne du nom

  connection.query(query, params, (error, results, fields) => {
    if (error) {
      console.error(error);
      res.status(500).json({ message: 'Une erreur est survenue' });
    } else {
      res.json(results);
    }
  });
});
app.get('/affichage', (req, res) => {
  connection.query('SELECT * FROM chefs', (error, results, fields) => {
    if (error) {
      console.error(error);
      res.status(500).json({ message: 'An error occurred' });
    } else {
      res.json(results);
    }
  });
});
app.get('/dishes', (req, res) => {
  connection.query('SELECT * FROM food', (err, rows) => {
    if (err) throw err;
    res.send(rows);
  });
});
app.get('/dashbo', (req, res) => {
  connection.query('SELECT * FROM orders ', (err, rows) => {
    if (err) throw err;
    res.send(rows);
  });
});
app.get('/customer', (req, res) => {
  connection.query('SELECT * FROM customer ', (err, rows) => {
    if (err) throw err;
    res.send(rows);
  });
});
// start the server
app.listen(3000, () => {
  console.log('Server started on port 3000');
});

