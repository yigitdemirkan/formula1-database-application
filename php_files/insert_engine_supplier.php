<?php
$servername = "localhost";
$username = "root";
$password = ""; 
$dbname = "mydatabase"; 

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$esid = $_POST['esid'];
$ename = $_POST['ename'];
$country = $_POST['country'];

$sql = "CALL addEngineSupplier(?, ?, ?)";

$stmt = $conn->prepare($sql);
$stmt->bind_param("iss", $esid, $ename, $country);

if ($stmt->execute()) {
    echo "<p>Engine Supplier added successfully!</p>";
} else {
    echo "<p>Error: " . $stmt->error . "</p>";
}

$stmt->close();
$conn->close();
?>
