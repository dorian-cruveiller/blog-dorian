<?php

if ( !isset($_POST['id']) || empty($_POST['id']) || !isset($_POST['title']) || empty($_POST['title']) || !isset($_POST['content']) || empty($_POST['content']) ) {
  echo "error";
} else {
  $pdo = new PDO('mysql:host=localhost;dbname=classicmodels', 'root', 'root');
  $pdo->exec('SET NAMES UTF8');

  $query = $pdo->prepare
  (
      'UPDATE post
      SET title = ?,
      contents = ?
      WHERE id = ?'
  );

  $query->execute([$_POST['title'], $_POST['content'], $_POST['id']]);

  // Redirection
  header('Location: /administration.php');
}