<?php
session_start();
include 'db.php';

// prihlaseny uzivatel
$isLoggedIn = isset($_SESSION['isLoggedIn']) && $_SESSION['isLoggedIn'] === true;

// meno a id uzivatela
$username = '';
$userId = 0;
if ($isLoggedIn) {
    $username = $_SESSION['username'];

    // ziskaj id uzivatela z databazy
    $query = "SELECT id FROM users WHERE username = :username";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':username', $username, PDO::PARAM_STR);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $userId = $result['id'];
}

// logout
if (isset($_GET['logout'])) {
    $_SESSION = array();
    session_destroy();
    header('Location: login.php');
    exit();
}

// produkty z databazy
$query = "SELECT * FROM products LIMIT 9";
$stmt = $db->query($query);
$products = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
    <title>My eShop</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
</head>
<body>
    <?php include 'navbar.php'; ?>

    <div class="container">
        <h1>Welcome to My eShop</h1>
        <div class="product-list">
            <?php foreach ($products as $product) : ?>
                <div class="product">
                    <img src="<?php echo $product['image_url']; ?>" alt="<?php echo $product['name']; ?>">
                    <h3><?php echo $product['name']; ?></h3>
                    <p><?php echo $product['description']; ?></p>
                    <p class="price">$<?php echo $product['price']; ?></p>
                    <?php if ($isLoggedIn) : ?>
                        <form method="POST" action="add_to_cart.php">
                            <input type="hidden" name="product_id" value="<?php echo $product['id']; ?>">
                            <input type="hidden" name="user_id" value="<?php echo $userId; ?>">
                            <button type="submit">Add to Cart</button>
                        </form>
                    <?php endif; ?>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
</body>
</html>
