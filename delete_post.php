<?php

if ( !isset($_POST['id']) || empty($_POST['id']) ) {
  echo "error";
} else {
  $pdo = new PDO('mysql:host=localhost;dbname=classicmodels', 'root', 'root');
  $pdo->exec('SET NAMES UTF8');

  $query = $pdo->prepare
  (
      'DELETE FROM post
      WHERE id = ?'
  );

  $query->execute([$_POST['id']]);

  // Delete comment from the post
  $query = $pdo->prepare
  (
      'DELETE FROM comment
      WHERE post_id = ?'
  );

  $query->execute([$_POST['id']]);

  // Redirection
  header('Location: /administration.php');
}