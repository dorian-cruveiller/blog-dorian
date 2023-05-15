<?php

if ( !isset($_POST['title']) || empty($_POST['title']) || !isset($_POST['content']) || empty($_POST['content']) || !isset($_POST['author-firstname']) || empty($_POST['author-firstname']) || !isset($_POST['author-lastname']) || empty($_POST['author-lastname']) || !isset($_POST['category']) || empty($_POST['category']) ) {
  echo "error";
} else {

  $pdo = new PDO('mysql:host=localhost;dbname=classicmodels', 'root', 'root');

  $pdo->exec('SET NAMES UTF8');

  $query = $pdo->prepare
  (
      'SELECT *
      FROM author
      WHERE firstname = ? AND lastname = ?'
  );

  $query->execute([$_POST['author-firstname'], $_POST['author-lastname']]);

  $author = $query->fetch(PDO::FETCH_ASSOC);

  $category_id = checkCategory($pdo, $_POST['category']);

  if (empty($author)) {

    $query = $pdo->prepare
    (
        'INSERT INTO author (firstname, lastname)
        VALUES (?, ?)'
    );

    $query->execute([$_POST['author-firstname'], $_POST['author-lastname']]);

    $author_id = $pdo->lastInsertId();

    addPost($pdo, $author_id, $_POST['title'], $_POST['content'], $category_id);
  } else {
    addPost($pdo, $author['Id'], $_POST['title'], $_POST['content'], $category_id);
  }
}

function checkCategory($pdo, $category) {
  $query = $pdo->prepare
  (
      'SELECT *
      FROM category
      WHERE name = ?'
  );

  $query->execute([$category]);

  $categoryFound = $query->fetch(PDO::FETCH_ASSOC);

  if (empty($categoryFound)) {
    $query = $pdo->prepare
    (
        'INSERT INTO category (name)
        VALUES (?)'
    );

    $query->execute([$category]);

    $category_id = $pdo->lastInsertId();

    return $category_id;
  } else {
    return $categoryFound['Id'];
  }
}

function addPost($pdo, $author_id, $title, $content, $category_id) {

  date_default_timezone_set('Europe/Paris');

  $query = $pdo->prepare
  (
      'INSERT INTO post (title, contents, creationtimestamp, author_id, category_id)
      VALUES (?, ?, ?, ?, ?)'
  );

  $query->execute([$title, $content, date('Y-m-d H:i:s'), $author_id, $category_id]);

  // Redirection
  header('Location: /administration.php');
}