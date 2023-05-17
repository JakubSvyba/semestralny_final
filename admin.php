<?php
session_start();

// uzivatel je prihlaseny a je admin
if (!isset($_SESSION['isLoggedIn']) || !$_SESSION['isLoggedIn'] || $_SESSION['is_admin'] != 1) {
    header('Location: login.php');
    exit();
}

include 'db.php';

$users = $db->query("SELECT * FROM users")->fetchAll(PDO::FETCH_ASSOC);
$orders = $db->query("SELECT * FROM orders")->fetchAll(PDO::FETCH_ASSOC);
$products = $db->query("SELECT * FROM products")->fetchAll(PDO::FETCH_ASSOC);

// zakladne spracovanie formularov
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['update_users'])) {
        $userUpdates = $_POST['user'];

        // database update
        foreach ($userUpdates as $userId => $userUpdate) {
            $isAdmin = isset($userUpdate['is_admin']) ? 1 : 0;

            $stmt = $db->prepare("UPDATE users SET is_admin = :is_admin WHERE id = :user_id");
            $stmt->bindParam(':is_admin', $isAdmin);
            $stmt->bindParam(':user_id', $userId);
            $stmt->execute();
        }
    }

    // vytvorenie noveho uzivatela
    if (isset($_POST['create_order'])) {
        $newUserId = $_POST['new_user_id'];
        $newOrderDate = $_POST['new_order_date'];
        $newProductId = $_POST['new_product_id'];
        $newProductAmount = $_POST['new_product_amount'];
        $newPrice = $_POST['new_price'];

        $stmt = $db->prepare("INSERT INTO orders (user_id, order_date, product_id, product_amount, price) VALUES (:user_id, :order_date, :product_id, :product_amount, :price)");
        $stmt->bindParam(':user_id', $newUserId);
        $stmt->bindParam(':order_date', $newOrderDate);
        $stmt->bindParam(':product_id', $newProductId);
        $stmt->bindParam(':product_amount', $newProductAmount);
        $stmt->bindParam(':price', $newPrice);
        $stmt->execute();
    }

    header('Location: admin.php');
    exit();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <?php include 'navbar.php'; ?>

    <div class="container">
        <h1>Admin Panel</h1>

        <h2>Users</h2>
        <form method="post" action="admin.php">
            <table>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Registration Date</th>
                    <th>Is Admin</th>
                </tr>
                <?php foreach ($users as $user) : ?>
                    <tr>
                        <td><?php echo $user['id']; ?></td>
                        <td><?php echo $user['username']; ?></td>
                        <td><?php echo $user['email']; ?></td>
                        <td><?php echo $user['registration_date']; ?></td>
                        <td>
                            <input type="checkbox" name="user[<?php echo $user['id']; ?>][is_admin]" <?php if ($user['is_admin']) echo 'checked'; ?>>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </table>
            <input type="submit" name="update_users" value="Update">
        </form>

        <h2>Create New User</h2>
        <form method="post" action="admin.php">
            <label for="new_username">Username:</label>
            <input type="text" name="new_username" id="new_username" required><br>

            <label for="new_email">Email:</label>
            <input type="email" name="new_email" id="new_email" required><br>

            <label for="new_password">Password:</label>
            <input type="password" name="new_password" id="new_password" required><br>

            <label for="new_is_admin">Is Admin:</label>
            <input type="checkbox" name="new_is_admin" id="new_is_admin"><br>

            <input type="submit" value="Create User">
        </form>

        <h2>Orders</h2>
        <form method="post" action="admin.php">
            <table>
                <tr>
                    <th> Order ID</th>
                    <th>User ID</th>
                    <th>Order Date</th>
                    <th>Product ID</th>
                    <th>Product Amount</th>
                    <th>Price</th>
                </tr>
                <?php foreach ($orders as $order) : ?>
                    <tr>
                        <td><?php echo $order['id']; ?></td>
                        <td><?php echo $order['user_id']; ?></td>
                        <td><?php echo $order['order_date']; ?></td>
                        <td><?php echo $order['product_id']; ?></td>
                        <td><?php echo $order['product_amount']; ?></td>
                        <td><?php echo $order['price']; ?></td>
                    </tr>
                <?php endforeach; ?>
            </table>

            <h3>Create New Order</h3>
            <label for="new_user_id">User ID:</label>
            <input type="text" name="new_user_id" id="new_user_id" required><br>

            <label for="new_order_date">Order Date:</label>
            <input type="date" name="new_order_date" id="new_order_date" required><br>

            <label for="new_product_id">Product ID:</label>
            <input type="text" name="new_product_id" id="new_product_id" required><br>

            <label for="new_product_amount">Product Amount:</label>
            <input type="text" name="new_product_amount" id="new_product_amount" required><br>

            <label for="new_price">Price:</label>
            <input type="text" name="new_price" id="new_price" required><br>

            <input type="submit" name="create_order" value="Create Order">
        </form>
        
        <h2>Products</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
            </tr>
            <?php foreach ($products as $product) : ?>
                <tr>
                    <td><?php echo $product['id']; ?></td>
                    <td><?php echo $product['name']; ?></td>
                    <td><?php echo $product['description']; ?></td>
                </tr>
            <?php endforeach; ?>
        </table>
    </div>
</body>
</html>
