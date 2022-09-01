<?php
  $name = $_POST['name'];
  $description = $_POST['description'];
  $notes = $_POST['notes'];
  $category = $_POST['category'];


	// Database connection
	$conn = new mysqli('localhost','root','','noteapp');
	if($conn->connect_error){
		echo "$conn->connect_error";
		die("Connection Failed : ". $conn->connect_error);
	} else {
		$stmt = $conn->prepare("INSERT INTO habit(`name`, `description`, notes, category) values(?, ?, ?, ?)");
		$stmt->bind_param("ssss", $name, $description, $notes, $category);
		$execval = $stmt->execute();
		echo $execval;
		echo "New Habit has been added";
		$stmt->close();
		$conn->close();
	}
?>

