<?php

include "../connect.php";
include "../function.php";


$id =    filterRequest("id");



// for security   htmlspecialchars(strip_tags()) 

$stmt = $con->prepare("SELECT `username` FROM `users` WHERE `id` = ?");

$stmt->execute(array($id));

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$count = $stmt->rowCount();

if($count > 0){
    echo json_encode(array("status" => "success" , "data" => $data ));   
 }else{
    echo json_encode(array("status" => "faild"));   
 }