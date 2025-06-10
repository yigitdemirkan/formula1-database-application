<?php
// Database connection
$servername = "localhost";
$username = "root";
$password = ""; 
$dbname = "mydatabase"; 

$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$sql = "SELECT pid, reason, duration FROM Pit_Stop";
$result = $conn->query($sql);

if ($result->num_rows > 0) {

    echo "<table border='1'><tr><th>Pit Stop ID</th><th>Reason</th><th>Duration</th></tr>";
    while($row = $result->fetch_assoc()) {
        echo "<tr><td>" . $row['pid'] . "</td><td>" . $row['reason'] . "</td><td>" . $row['duration'] . "</td></tr>";
    }
    echo "</table>";
} else {
    echo "No pit stops found.";
}

$conn->close();
?>
