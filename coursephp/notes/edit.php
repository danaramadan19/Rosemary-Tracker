<?php

include "../connect.php";
include "../function.php";

$noteid =       filterRequest("id");
//$title =  filterRequest("title");

$content =  filterRequest("content");

// for security   htmlspecialchars(strip_tags())

$stmt = $con->prepare("UPDATE `notes` SET `notes_content` = ? WHERE `notes_id` = ? ");


$stmt->execute(array($content , $noteid));


$count = $stmt->rowCount();

if($count > 0){
    echo json_encode(array("status" => "success"));   
 }else{
    echo json_encode(array("status" => "faild"));   
 }