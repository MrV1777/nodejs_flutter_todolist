const mysql = require('mysql2');

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'lodo_list',
  port: 3306 // หรือ 3307 ตาม XAMPP/Laragon ของคุณ
});

db.connect(err => {
  if (err) throw err;
  console.log('✅ MySQL connected');
});

module.exports = db;
