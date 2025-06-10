<?php
require 'firebase-init.php'; // Include Firebase setup

session_start();
$userId = $_SESSION['user_id']; // Get logged-in user's ID
$message = $_POST['message'];
$timestamp = date('Y-m-d H:i:s');

$messagesRef = $database->getReference('messages/' . $userId);
$messagesRef->push([
    'message' => $message,
    'timestamp' => $timestamp
]);

header('Location: newindex.php'); // Redirect back to the main page
exit;
?>
