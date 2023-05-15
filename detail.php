<?php

$post_id = $_GET["id"];

$pdo = new PDO('mysql:host=localhost;dbname=classicmodels', 'root', 'root');

$pdo->exec('SET NAMES UTF8');

$query = $pdo->prepare
(
    'SELECT
        title,
        contents,
        creationTimestamp,
        author_id,
        category_id,
        id
     FROM post
     WHERE id = ?
     ORDER BY creationTimestamp DESC'
);

$query->execute([$post_id]);

$post = $query->fetch(PDO::FETCH_ASSOC);

// Format date
$post["creationTimestamp"] = date_format(date_create($post["creationTimestamp"]), "d/m/Y à H:i");

// Author
$author_id = $post['author_id'];

$query = $pdo->prepare
(
  'SELECT
    firstname,
    lastname
  FROM author
  WHERE id = ?'
);

$query->execute([$author_id]);

$author = $query->fetch(PDO::FETCH_ASSOC);

$post['author_name'] = $author['firstname'] . " " . $author['lastname'];

// Add category name to $post
$query = $pdo->prepare
(
  'SELECT
    name
  FROM category
  WHERE id = ?'
);

$query->execute([$post["category_id"]]);

$category_name = $query->fetch(PDO::FETCH_ASSOC)["name"];

$post['category_name'] = $category_name;

// Comment
$query = $pdo->prepare
(
    'SELECT
      contents,
      creationtimestamp,
      nickname,
      post_id
     FROM comment
     WHERE post_id = ?
     ORDER BY creationTimestamp DESC'
);

$query->execute([$post_id]);

$comments = $query->fetchAll(PDO::FETCH_ASSOC);

foreach($comments as &$comment) {

  // Format date
  $comment["creationtimestamp"] = date_format(date_create($comment["creationtimestamp"]), "d/m/Y à H:i");

  unset($comment);
}

include 'detail.phtml';
