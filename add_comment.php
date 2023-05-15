<?php

if ( !isset($_POST['content']) || empty($_POST['content']) || !isset($_POST['nickname']) || empty($_POST['nickname']) || !isset($_POST['post_id']) || empty($_POST['post_id']) ) {
  echo "error";
} else {

  $pdo = new PDO('mysql:host=localhost;dbname=classicmodels', 'root', 'root');

  $pdo->exec('SET NAMES UTF8');

  date_default_timezone_set('Europe/Paris');

  $query = $pdo->prepare
  (
      'INSERT INTO comment (contents, nickname, creationtimestamp, post_id)
      VALUES (?, ?, ?, ?)'
  );

  $query->execute([$_POST['content'], $_POST['nickname'], date('Y-m-d H:i:s'), $_POST['post_id']]);

  // Redirection
  header('Location: /detail.php?id=' . $_POST['post_id']);
}