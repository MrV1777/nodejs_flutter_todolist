const express = require('express');
const router = express.Router();
const db = require('../db');

//  GET /tasks - Retrieve all tasks
router.get('/', (req, res) => {
  db.query('SELECT * FROM tasks', (err, results) => {
    if (err) 
      return res.status(500).json({ error: err.message }); // Return 500 if DB error
    res.json(results); // Return all tasks as JSON
  });
});

//  POST /tasks - Add a new task
router.post('/', (req, res) => {
  const { title } = req.body;
  if (!title) 
    return res.status(400).json({ error: 'Title is required' }); // Validate title presence

  const sql = 'INSERT INTO tasks (title) VALUES (?)';
  db.query(sql, [title], (err, result) => {
    if (err) 
      return res.status(500).json({ error: err.message }); // Return 500 if DB error

    // Return the created task with inserted id and default is_done = 0
    res.status(201).json({ id: result.insertId, title, is_done: 0 });
  });
});

//  DELETE /tasks/:id - Delete a task by ID
router.delete('/:id', (req, res) => {
  const id = req.params.id;
  const sql = 'DELETE FROM tasks WHERE id = ?';
  db.query(sql, [id], (err, result) => {
    if (err) 
      return res.status(500).json({ error: err.message }); // Return 500 if DB error

    if (result.affectedRows === 0) {
      // No task found with this id
      return res.status(404).json({ error: 'Task not found' });
    }

    res.json({ message: 'Task deleted' }); // Success message
  });
});

// PUT /tasks/:id - Update title, is_done, or both fields of a task
router.put('/:id', (req, res) => {
  const id = req.params.id;
  const { title, is_done } = req.body;

  const fields = [];
  const values = [];

  // Add title to update if provided
  if (title !== undefined) {
    fields.push('title = ?');
    values.push(title);
  }

  // Add is_done to update if provided, convert boolean to 1 or 0
  if (is_done !== undefined) {
    fields.push('is_done = ?');
    values.push(is_done ? 1 : 0);
  }

  // If no fields to update, return error
  if (fields.length === 0) {
    return res.status(400).json({ error: 'No fields to update' });
  }

  // Prepare SQL update statement dynamically based on fields
  const sql = `UPDATE tasks SET ${fields.join(', ')} WHERE id = ?`;
  values.push(id); // Add id as last parameter

  db.query(sql, values, (err, result) => {
    if (err) 
      return res.status(500).json({ error: err.message }); // Return 500 if DB error

    res.json({ message: 'Task updated' }); // Success message
  });
});

module.exports = router;
