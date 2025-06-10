<?php

$servername = "localhost";
$username = "root"; 
$password = ""; 
$dbname = "mydatabase"; 


$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$pid = $_POST['pid'];
$reason = $_POST['reason'];
$duration = $_POST['duration'];


$sql = "CALL addPitStop(?, ?, ?)";


$stmt = $conn->prepare($sql);
$stmt->bind_param("iss", $pid, $reason, $duration);

// Execute the stored procedure
if ($stmt->execute()) {
    echo "<p>Pit Stop added successfully!</p>";
} else {
    echo "<p>Error: " . $stmt->error . "</p>";
}

$stmt->close();
$conn->close();
?>
