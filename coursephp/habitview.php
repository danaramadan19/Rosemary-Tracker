<?php

include "connect.php";
include "function.php";


$stmt = $con->prepare("SELECT `name` , `description`, `category` , `notes` FROM habit");



$stmt->execute();

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$count = $stmt->rowCount();

if($count > 0){
    echo json_encode(array("status" => "success" , "data" => $data ));   
 }else{
    echo json_encode(array("status" => "faild"));   
 }