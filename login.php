<?php
include 'db.php';

session_start();

if (isset($_SESSION['isLoggedIn']) && $_SESSION['isLoggedIn'] === true) {
    header('Location: index.php');
    exit();
}

$username = $password = '';
$username_err = $password_err = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Validate username
    if (empty(trim($_POST['username']))) {
        $username_err = 'Please enter a username.';
    } else {
        $username = trim($_POST['username']);
    }

    // overenie hesla
    if (empty(trim($_POST['password']))) {
        $password_err = 'Please enter a password.';
    } else {
        $password = trim($_POST['password']);
    }

    if (empty($username_err) && empty($password_err)) {
        // prikaz select
        $query = "SELECT id, username, password, is_admin FROM users WHERE username = :username";

        if ($stmt = $db->prepare($query)) {
            $stmt->bindParam(':username', $param_username, PDO::PARAM_STR);

            $param_username = $username;

            if ($stmt->execute()) {
                // overenie ci existuje uzivatel a ci je heslo spravne
                if ($stmt->rowCount() === 1) {
                    $row = $stmt->fetch(PDO::FETCH_ASSOC);
                    $hashed_password = $row['password'];

                    if (password_verify($password, $hashed_password)) {
                        // heslo je spravne
                        session_start();

                        $_SESSION['isLoggedIn'] = true;
                        $_SESSION['user_id'] = $row['id'];
                        $_SESSION['username'] = $row['username'];
                        $_SESSION['is_admin'] = $row['is_admin'];

                        header('Location: index.php');
                        exit();
                    } else {
                        $password_err = 'Invalid password.';
                    }
                } else {
                    $username_err = 'Username does not exist.';
                }
            } else {
                echo 'Oops! Something went wrong. Please try again later.';
            }

            $stmt = null;
        }
    }

    $db = null;
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <?php include 'navbar.php'; ?>

    <div class="container">
        <h1>Login</h1>

        <?php if (isset($loginError)) : ?>
            <p><?php echo $loginError; ?></p>
        <?php endif; ?>

        <form method="POST">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>
