<?php
$servername = "localhost";
$username = "root"; 
$password = ""; 
$dbname = "mydatabase";

$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$sql = "SELECT esid, ename, country FROM Engine_Supplier";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<table border='1'><tr><th>Engine Supplier ID</th><th>Engine Supplier Name</th><th>Country</th></tr>";
    while($row = $result->fetch_assoc()) {
        echo "<tr><td>" . $row['esid'] . "</td><td>" . $row['ename'] . "</td><td>" . $row['country'] . "</td></tr>";
    }
    echo "</table>";
} else {
    echo "No engine suppliers found.";
}

$conn->close();
?>
