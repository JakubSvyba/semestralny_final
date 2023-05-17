<?php
session_start();
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // skontrolujeme, či je používateľ prihlásený
    if (isset($_SESSION['isLoggedIn']) && $_SESSION['isLoggedIn'] === true) {
        // získame ID produktu a ID používateľa z POST dát
        $productId = $_POST['product_id'];
        $userId = $_POST['user_id'];

        // Skontrolujeme, či je produkt už v košíku
        $query = "SELECT * FROM cart WHERE user_id = :user_id AND product_id = :product_id";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':user_id', $userId, PDO::PARAM_INT);
        $stmt->bindParam(':product_id', $productId, PDO::PARAM_INT);
        $stmt->execute();
        $cartItem = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($cartItem) {
            // zvisi počet produktov v košíku, ak je 0, vložíme produkt s množstvom 1
            $query = "UPDATE cart SET product_amount = product_amount + 1 WHERE user_id = :user_id AND product_id = :product_id";
            $stmt = $db->prepare($query);
            $stmt->bindParam(':user_id', $userId, PDO::PARAM_INT);
            $stmt->bindParam(':product_id', $productId, PDO::PARAM_INT);
            $stmt->execute();
        } else {
            $query = "INSERT INTO cart (user_id, product_id, product_amount) VALUES (:user_id, :product_id, 1)";
            $stmt = $db->prepare($query);
            $stmt->bindParam(':user_id', $userId, PDO::PARAM_INT);
            $stmt->bindParam(':product_id', $productId, PDO::PARAM_INT);
            $stmt->execute();
        }

        header('Location: index.php');
        exit();
    }
}


header('Location: login.php');
exit();
?>
