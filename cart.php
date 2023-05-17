<?php
session_start();
include 'db.php';
// prihlaseny uzivatel
$isLoggedIn = isset($_SESSION['isLoggedIn']) && $_SESSION['isLoggedIn'] === true;
//presmeruje neprihlaseneho uzivatela na login.php
if (!$isLoggedIn) {
    header('Location: login.php');
    exit();
}

// ziskaj id uzivatela z session
$userId = $_SESSION['user_id'];

$query = "SELECT cart.id AS cart_id, cart.product_amount, products.* FROM cart 
          INNER JOIN products ON cart.product_id = products.id 
          WHERE cart.user_id = :user_id";
$stmt = $db->prepare($query);
$stmt->bindParam(':user_id', $userId, PDO::PARAM_INT);
$stmt->execute();
$cartItems = $stmt->fetchAll(PDO::FETCH_ASSOC);

$total = 0;
foreach ($cartItems as $item) {
    $total += $item['product_amount'] * $item['price'];
}

// vytvori objednavku, vyprazdni kosik a presmeruje na order_confirmation
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['create_order'])) {
        // Check if the cart is not empty
        if (count($cartItems) > 0) {
            $orderDate = date('Y-m-d');
            $stmt = $db->prepare("INSERT INTO orders (user_id, order_date, product_id, product_amount, price) VALUES (:user_id, :order_date, :product_id, :product_amount, :price)");

            foreach ($cartItems as $item) {
                $stmt->bindParam(':user_id', $userId);
                $stmt->bindParam(':order_date', $orderDate);
                $stmt->bindParam(':product_id', $item['id']);
                $stmt->bindParam(':product_amount', $item['product_amount']);
                $stmt->bindParam(':price', $item['price']);
                $stmt->execute();
            }

            $stmt = $db->prepare("DELETE FROM cart WHERE user_id = :user_id");
            $stmt->bindParam(':user_id', $userId, PDO::PARAM_INT);
            $stmt->execute();

            header('Location: order_confirmation.php');
            exit();
        }
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>My Cart</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
</head>
<body>
    <?php include 'navbar.php'; ?>

    <div class="container">
        <h1>My Cart</h1>

        <div class="cart-list">
            <?php foreach ($cartItems as $item) : ?>
                <div class="cart-item">
                    <img class="cart-image" src="<?php echo $item['image_url']; ?>" alt="<?php echo $item['name']; ?>">
                    <h3><?php echo $item['name']; ?></h3>
                    <p><?php echo $item['description']; ?></p>
                    <p class="price">$<?php echo $item['price']; ?></p>
                    <div class="quantity-controls">
                        <form method="POST" action="update_cart.php">
                            <input type="hidden" name="cart_id" value="<?php echo $item['cart_id']; ?>">
                            <input type="hidden" name="product_id" value="<?php echo $item['id']; ?>">
                            <input type="hidden" name="user_id" value="<?php echo $userId; ?>">
                            <button type="submit" name="decrease"><i class="fas fa-minus"></i></button>
                        </form>
                        <p>Quantity: <?php echo $item['product_amount']; ?></p>
                        <form method="POST" action="update_cart.php">
                            <input type="hidden" name="cart_id" value="<?php echo $item['cart_id']; ?>">
                            <input type="hidden" name="product_id" value="<?php echo $item['id']; ?>">
                            <input type="hidden" name="user_id" value="<?php echo $userId; ?>">
                            <button type="submit" name="increase"><i class="fas fa-plus"></i></button>
                        </form>
                        <form method="POST" action="update_cart.php">
                            <input type="hidden" name="cart_id" value="<?php echo $item['cart_id']; ?>">
                            <input type="hidden" name="product_id" value="<?php echo $item['id']; ?>">
                            <input type="hidden" name="user_id" value="<?php echo $userId; ?>">
                            <button type="submit" name="delete"><i class="fas fa-trash"></i></button>
                        </form>
                    </div>
                </div>
            <?php endforeach; ?>

            <h3>Total: $<?php echo number_format($total, 2); ?></h3>

            <?php if (count($cartItems) > 0) : ?>
                <form method="POST" action="cart.php">
                    <button type="submit" name="create_order">Place Order</button>
                </form>
            <?php endif; ?>
        </div>
    </div>
</body>
</html>
