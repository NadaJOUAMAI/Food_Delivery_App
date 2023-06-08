const mysql = require('mysql');
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());
app.use(cors()); // Add CORS middleware

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'root',
  database: 'my_database',
});

// handle user registration
app.post('/register', (req, res) => {
  const { name, email, phone, password } = req.body;
  console.log('Received data:', name, email, phone, password);

  pool.query('INSERT INTO users (name, email, phone, password) VALUES (?, ?, ?, ?)', [name, email, phone, password], (error, results, fields) => {
    if (error) {
      console.error(error);
      res.status(500).json({ message: 'An error occurred' });
    } else {
      // Retrieve the next available user ID
      pool.query('SELECT MAX(id) AS id FROM users', (error, results, fields) => {
        if (error) {
          console.error(error);
          res.status(500).json({ message: 'An error occurred' });
        } else {
          const userId = results[0].id || 1; // If there are no existing users, start from ID 1
          res.json({ id: userId, message: 'User registration successful' });
        }
      });
    }
  });
});
app.post('/login1', (req, res) => {
  const { email, password } = req.body;

  pool.getConnection((err, connection) => {
    if (err) {
      res.status(500).json({ error: 'Failed to connect to the database.' });
      return;
    }

    const query = 'SELECT id FROM users WHERE email = ? AND password = ?';
    connection.query(query, [email, password], (err, results) => {
      connection.release();

      if (err) {
        res.status(500).json({ error: 'An error occurred while executing the query.' });
        return;
      }

      if (results.length === 0) {
        res.status(401).json({ error: 'Invalid email or password.' });
        return;
      }

      const user = results[0];
      res.status(200).json({ id: user.id });
    });
  });
});







app.get('/foods', (req, res) => {
  const categoryId = req.query.categoryId; // Assuming the category ID is passed as a query parameter
  const query = 'SELECT * FROM Foods' + (categoryId ? ' WHERE Category = ?' : '');

  pool.query(query, [categoryId], (error, results, fields) => {
    if (error) {
      console.error(error);
      res.status(500).json({ message: 'An error occurred' });
    } else {
      res.json(results);
    }
  });
});


app.post('/basket', (req, res) => {
  const { foodId, name, price, image, quantity ,idclient} = req.body;
  console.log('Received data:', foodId, name, price, image, quantity,idclient);
  pool.query('INSERT INTO commande (food_id, name, price, image, quantity,idclient) VALUES (?, ?, ?, ?, ?,?)', [foodId, name, price, image, quantity,idclient], (error, results, fields) => {
    if (error) {
      console.error(error);
      res.status(500).json({ message: 'An error occurred' });
    } else {
      res.json({ message: 'Command added successfully' });
    }
  });
});


app.get('/commande', (req, res) => {
  const idclient = req.query.idclient; // Retrieve the idclient from the query parameters
  pool.query('SELECT * FROM commande ', [idclient], (error, results, fields) => {
    if (error) {
      console.error(error);
      res.status(500).json({ message: 'An error occurred' });
    } else {
      res.json(results);
    } 
  });
});

app.put('/commande/:idclient', (req, res) => {
  const idclient = req.params.idclient;
  pool.query('UPDATE commande SET valider = true WHERE idclient = ?', [idclient], (error, results, fields) => {
    if (error) {
      console.error(error);
      res.status(500).json({ message: 'An error occurred' });
    } else {
      res.json({ message: 'Commande updated successfully' });
    }
  });
});



app.get('/search', (req, res) => {
  const name = req.query.name; // get the name parameter from the query string
  const query = 'SELECT * FROM Foods WHERE name LIKE ?'; // modify the query to include a WHERE clause
  const params = [`%${name}%`]; // set the parameter value to search for a substring of the name

  pool.query(query, params, (error, results, fields) => {
    if (error) {
      console.error(error);
      res.status(500).json({ message: 'An error occurred' });
    } else {
      res.json(results);
    }
  });
});

app.post('/DeliveryInfo', (req, res) => {
  const {  Address, Phone } = req.body;
  console.log('Received data:', Address, Phone); // Log the received data
  pool.query('INSERT INTO delivEryInfo ( address, phone) VALUES ( ?, ?)', [ Address,  Phone], (error, results, fields) => {
    if (error) {
      console.error(error);
      res.status(500).json({ message: 'An error occurred' });
    } else {
      res.json({ message: 'successful' });
    }
  });
});
app.post('/CardInfo', (req, res) => {
  const { Name , cardNumber, Date, CCV} = req.body;
  console.log('Received data:', Name,cardNumber, Date, CCV); // Log the received data
  pool.query('INSERT INTO cardInfo ( Name,cardNumber, Date, CCV) VALUES ( ?,?,?, ?)', [Name,cardNumber, Date, CCV], (error, results, fields) => {
    if (error) {
      console.error(error);
      res.status(500).json({ message: 'An error occurred' });
    } else {
      res.json({ message: 'successful' });
    }
  });
});

// Create "Chef" table if not exists
pool.query(
  `CREATE TABLE IF NOT EXISTS Chef (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    ville VARCHAR(255),
    Adresse VARCHAR(255),
    phone VARCHAR(255),
    jours VARCHAR(255),
    heure VARCHAR(255),
    image VARCHAR(1000) NULL
  );
  `,
  (error, results, fields) => {
    if (error) {
      console.error(error);
    } else {
      console.log('Table "Chef" created or already exists');
    }
  }
);

// API route for user registration
app.post('/join', (req, res) => {
  const { nom, prenom, ville, Adresse, phone, jours, heure, image } = req.body;
  console.log('Received data:', nom, prenom, ville, Adresse, phone, jours, heure, image); // Log the received data
  pool.query(
    'INSERT INTO Chef (nom, prenom, ville, Adresse, phone, jours, heure, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
    [nom, prenom, ville, Adresse, phone, jours, heure, image],
    (error, results, fields) => {
      if (error) {
        console.error(error);
        res.status(500).json({ message: 'An error occurred' });
      } else {
        res.json({ message: 'User registration successful' });
      }
    }
  );
});
app.get('/port_femme', (req, res) => {
  pool.query('SELECT * FROM chef limit 1', (err, rows) => {
    if (err) throw err;
    res.send(rows);
  });
})


// handle food item addition
app.post('/joinfood', (req, res) => {
  const { nom, Description, image, Prix, commentaire, category } = req.body;
  console.log('Received data:', nom, Description, image, Prix, commentaire, category); // Log the received data
  pool.query('INSERT INTO Foods (Category, name, price, Contains, commantaire, url) VALUES (?, ?, ?, ?, ?, ?)',
    [category, nom, Prix, Description, commentaire, image], (error, results, fields) => {
      if (error) {
        console.error(error);
        res.status(500).json({ message: 'An error occurred' });
      } else {
        res.json({ message: 'Food item added successfully' });
      }
    });
});

app.get('/portfolio', (req, res) => {
 
  pool.query(` select * FROM food `, (err, rows) => {
    if (err) throw err;
    res.send(rows);
  });
});



app.post('/login', (req, res) => {
  const { email, password } = req.body;

  // query the database to see if the user exists
  pool.query(
    'SELECT * FROM users WHERE email = ? AND password = ?',
    [email, password],
    (error, results) => {
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

app.listen(3000, () => {
  console.log('Server started on port 3000');
});



