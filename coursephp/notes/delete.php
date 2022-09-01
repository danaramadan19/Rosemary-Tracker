<?php

include "../connect.php";
include "../function.php";

$noteid = filterRequest("id");
$imagename = filterRequest("imagename");



// for security   htmlspecialchars(strip_tags())

$stmt = $con->prepare("DELETE FROM `notes` WHERE `notes_id` = ? ");


$stmt->execute(array($noteid));



$count = $stmt->rowCount();

if($count > 0){
   deleteFile("../upload" , $imagename);
    echo json_encode(array("status" => "success"));   
 }else{
    echo json_encode(array("status" => "faild"));   
 }