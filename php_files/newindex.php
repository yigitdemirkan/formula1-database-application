<?php
require 'firebase-init.php'; // Include Firebase setup

session_start();
$userId = $_SESSION['user_id']; // Get logged-in user's ID
$messagesRef = $database->getReference('messages/' . $userId);
$messages = $messagesRef->getValue();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Messages</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 20px;
        }
        .container {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        textarea, button {
            width: 100%;
            margin: 10px 0;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h3>Your Messages</h3>
        <div id="messageContainer">
            <?php
            if ($messages) {
                foreach ($messages as $message) {
                    echo '<p><strong>Message:</strong> ' . htmlspecialchars($message['message']) . '</p>';
                    echo '<p><small><strong>Timestamp:</strong> ' . htmlspecialchars($message['timestamp']) . '</small></p>';
                }
            } else {
                echo '<p>No messages yet.</p>';
            }
            ?>
        </div>
        <form method="POST" action="save-message.php">
            <label for="message">Enter your message:</label>
            <textarea id="message" name="message" required></textarea>
            <button type="submit">Send</button>
        </form>
    </div>
</body>
</html>
