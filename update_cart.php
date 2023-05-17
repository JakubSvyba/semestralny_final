<?php
session_start();
include 'db.php';

$isLoggedIn = isset($_SESSION['isLoggedIn']) && $_SESSION['isLoggedIn'] === true;

// neprihlaseny pouzivatel
if (!$isLoggedIn) {
    header('Location: login.php');
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $cartId = $_POST['cart_id'];
    $productId = $_POST['product_id'];
    $userId = $_POST['user_id'];


    if (isset($_POST['increase'])) {
        // zvisi pocet produktov v kosiku
        $query = "UPDATE cart SET product_amount = product_amount + 1 WHERE id = :cart_id";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':cart_id', $cartId, PDO::PARAM_INT);
        $stmt->execute();
    }

    // znizovanie
    if (isset($_POST['decrease'])) {
        $query = "UPDATE cart SET product_amount = product_amount - 1 WHERE id = :cart_id";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':cart_id', $cartId, PDO::PARAM_INT);
        $stmt->execute();

        // ak product_amount je 0, vymazeme produkt z kosika
        $query = "SELECT product_amount FROM cart WHERE id = :cart_id";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':cart_id', $cartId, PDO::PARAM_INT);
        $stmt->execute();
        $productAmount = $stmt->fetchColumn();

        if ($productAmount <= 0) {
            $query = "DELETE FROM cart WHERE id = :cart_id";
            $stmt = $db->prepare($query);
            $stmt->bindParam(':cart_id', $cartId, PDO::PARAM_INT);
            $stmt->execute();
        }
    }
    // vymazavanie
    if (isset($_POST['delete'])) {
        $query = "DELETE FROM cart WHERE id = :cart_id";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':cart_id', $cartId, PDO::PARAM_INT);
        $stmt->execute();
    }

    header('Location: cart.php');
    exit();
} else {
    header('Location: cart.php');
    exit();
}
?>
