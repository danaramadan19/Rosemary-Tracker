<?php

include "../connect.php";
include "../function.php";

//$title =        filterRequest("title");
$content =     filterRequest("content");
$userid =          filterRequest("id");

$imagename = imageUpload("file");

if($imagename != "fail"){

   $stmt = $con->prepare("INSERT INTO `notes`(`notes_content`, `notes_users` , `notes_image`) VALUES (? , ? , ?)");


   $stmt->execute(array($content , $userid , $imagename));
   
   
   
   $count = $stmt->rowCount();
   
   if($count > 0){
       echo json_encode(array("status" => "success"));   
    }else{
       echo json_encode(array("status" => "faild"));   
    }
} else{
   echo json_encode(array("status" => "faild"));  
}
// for security   htmlspecialchars(strip_tags())

