<?php

$pdo = new PDO('mysql:host=localhost;dbname=classicmodels', 'root', 'root');

$pdo->exec('SET NAMES UTF8');

$query = $pdo->prepare
(
    'SELECT
        id,
        title,
        contents,
        creationTimestamp,
        author_id,
        category_id
     FROM post
     ORDER BY creationTimestamp DESC'
);

$query->execute();

$posts = $query->fetchAll(PDO::FETCH_ASSOC);

foreach($posts as &$post) {

  // Add author_name name to $post
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

  // Format date
  $post["creationTimestamp"] = date_format(date_create($post["creationTimestamp"]), "d/m/Y à H:i");

  unset($post);
}

include 'administration.phtml';