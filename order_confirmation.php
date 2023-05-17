<?php
session_start();
include 'db.php';

$isLoggedIn = isset($_SESSION['isLoggedIn']) && $_SESSION['isLoggedIn'] === true;

if (!$isLoggedIn) {
    header('Location: login.php');
    exit();
}

$userId = $_SESSION['user_id'];

$query = "SELECT orders.id AS order_id, orders.order_date, orders.product_amount, products.* FROM orders 
          INNER JOIN products ON orders.product_id = products.id 
          WHERE orders.user_id = :user_id
          ORDER BY orders.order_date DESC
          LIMIT 1";
$stmt = $db->prepare($query);
$stmt->bindParam(':user_id', $userId, PDO::PARAM_INT);
$stmt->execute();
$order = $stmt->fetch(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <?php include 'navbar.php'; ?>

    <div class="container">
        <h1>Order Confirmation</h1>

        <?php if ($order) : ?>
            <div class="order-details">
                <h2>Order ID: <?php echo $order['order_id']; ?></h2>
                <p>Order Date: <?php echo $order['order_date']; ?></p>
                <h3>Product Details:</h3>
                <div class="product-details">
                    <img class="product-image" src="<?php echo $order['image_url']; ?>" alt="<?php echo $order['name']; ?>">
                    <h3><?php echo $order['name']; ?></h3>
                    <p><?php echo $order['description']; ?></p>
                    <p class="price">$<?php echo $order['price']; ?></p>
                    <p>Quantity: <?php echo $order['product_amount']; ?></p>
                </div>
            </div>
        <?php else : ?>
            <p>No order found.</p>
        <?php endif; ?>
    </div>
</body>
</html>
