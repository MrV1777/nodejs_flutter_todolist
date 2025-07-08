const express = require('express');
const router = express.Router();
const db = require('../db');

// ดึงรายการทั้งหมด
router.get('/', (req, res) => {
  db.query('SELECT * FROM tasks', (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

// เพิ่มรายการใหม่
router.post('/', (req, res) => {
  const { title } = req.body;
  if (!title) return res.status(400).json({ error: 'Title is required' });

  const sql = 'INSERT INTO tasks (title) VALUES (?)';
  db.query(sql, [title], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(201).json({ id: result.insertId, title });
  });
});


// เพิ่ม task ใหม่
router.post('/', (req, res) => {
  const { title } = req.body;

  if (!title) {
    return res.status(400).json({ error: 'Title is required' });
  }

  const sql = 'INSERT INTO tasks (title) VALUES (?)';
  db.query(sql, [title], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });

    // ส่งข้อมูลที่เพิ่มกลับไป
    res.status(201).json({ id: result.insertId, title, is_done: 0 });
  });
});

// DELETE /tasks/:id - ลบ task ตาม id
router.delete('/:id', (req, res) => {
  const id = req.params.id;
  const sql = 'DELETE FROM tasks WHERE id = ?';
  db.query(sql, [id], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Task not found' });
    }
    res.json({ message: 'Task deleted' });
  });
});

module.exports = router;
