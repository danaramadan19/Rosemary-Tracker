<?php

include "../connect.php";
include "../function.php";


$email =    filterRequest("email");
$password = filterRequest("password");


// for security   htmlspecialchars(strip_tags()) 

$stmt = $con->prepare("SELECT * FROM users WHERE `password` = ? AND email = ?  ");

$stmt->execute(array($password , $email));

$data = $stmt->fetch(PDO::FETCH_ASSOC);

$count = $stmt->rowCount();

if($count > 0){
    echo json_encode(array("status" => "success" , "data" => $data ));   
 }else{
    echo json_encode(array("status" => "faild"));   
 }