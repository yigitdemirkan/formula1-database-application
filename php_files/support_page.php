<?php
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    // Sanitize user inputs
    $name = htmlspecialchars($_POST['name']);
    $subject = htmlspecialchars($_POST['subject']);
    $message = htmlspecialchars($_POST['message']);
    $dateTime = date("Y-m-d H:i:s");
    
    // Output the processed data as a properly formatted HTML page
    ?>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Support Message</title>
    </head>
    <body>
        <h1>Thank you, <?php echo $name; ?>!</h1>
        <p><strong>Subject:</strong> <?php echo $subject; ?></p>
        <p><strong>Message:</strong> <?php echo $message; ?></p>
        <p><strong>Submitted on:</strong> <?php echo $dateTime; ?></p>
        <br>
        <a href="support.html">Go back</a>
    </body>
    </html>
    <?php
} else {
    // Redirect to the form if accessed directly
    header("Location: support.html");
    exit();
}
?>
