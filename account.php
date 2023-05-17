<?php
require_once 'db.php';

session_start();

// prihlaseny uzivatel moze pristupit len na tuto stranku
if (!isset($_SESSION['user_id'])) {
    //uzivatel nie je prihlaseny
    header('Location: login.php');
    exit();
}

// ziskaj id uzivatela z session
$userId = $_SESSION['user_id'];
$query = "SELECT * FROM users WHERE id = :user_id";
$stmt = $db->prepare($query);
$stmt->bindParam(':user_id', $userId);
$stmt->execute();
$user = $stmt->fetch(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Account</title>
</head>
<body>
    <h2>Account Details</h2>
    <p><strong>Username:</strong> <?php echo $user['username']; ?></p>
    <p><strong>Email:</strong> <?php echo $user['email']; ?></p>
    <p><strong>Is Admin:</strong> <?php echo $user['is_admin'] ? 'Yes' : 'No'; ?></p>

    <a href="logout.php">Logout</a>

    <footer>
        <p>
            <a href="index.php">Home</a> |
            <a href="products.php">Products</a> |
            <a href="about.php">About</a> |
            <a href="contact.php">Contact</a>
        </p>
    </footer>
</body>
</html>
