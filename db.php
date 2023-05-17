<?php

// Database connection parameters
$host = 'localhost';
$dbname = 'eshop';
$username = 'root';
$password = '';

try {
    // Create a PDO instance for database connection
    $db = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo 'Database connection error: ' . $e->getMessage();
    die();
}
