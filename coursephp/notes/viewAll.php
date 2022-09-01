<?php

include "../connect.php";
include "../function.php";


//$noteid = filterRequest("id");



// for security   htmlspecialchars(strip_tags())

$stmt = $con->prepare("SELECT * FROM notes");

$stmt->execute();

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$count = $stmt->rowCount();

if($count > 0){
    echo json_encode(array("status" => "success" , "data" => $data ));   
 }else{
    echo json_encode(array("status" => "faild"));   
 }