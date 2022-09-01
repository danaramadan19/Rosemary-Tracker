<?php

include "../connect.php";
include "../function.php";



$username =  filterRequest("username");
$email =    filterRequest("email");
$password = filterRequest("password");


// for security   htmlspecialchars(strip_tags())

$stmt = $con->prepare("INSERT INTO `users`(`username`, `email`, `password`) VALUES (? , ? , ?)");

$stmt->execute(array($username , $email , $password));

$count = $stmt->rowCount();

if($count > 0){
    echo json_encode(array("status" => "success"));   
 }else{
    echo json_encode(array("status" => "fail"));   
 }