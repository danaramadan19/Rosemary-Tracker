<?php

//define a const to convert the size of the image to mb
define('MB' , 1048576);

function filterRequest($requestname){

 return   htmlspecialchars(strip_tags($_POST[$requestname]));
}


function imageUpload($imageRequest){
    global $msgError;
    $imagename = rand(1 , 10000) .$_FILES[$imageRequest]['name'];
    $imagetmp =$_FILES[$imageRequest]['tmp_name'];
    $imagesize = $_FILES[$imageRequest]['size'];
    //you can add mp3 or pdf or whatever you want
    $allowExt = array("jpg" , "png" , "gif" , "jpeg");
    $strToArray = explode("." , $imagename);
    $ext      =  end($strToArray);
    //convert the ext if it was capital to small letter
    $ext = strtolower($ext);

    if(!empty($imagename) && !in_array($ext , $allowExt)){
$msgError[] = "Ext";

    }
    if($imagesize > 2 * MB){
        $msgError[] = "size";
    }
    if(empty($msgError)){
    move_uploaded_file($imagetmp , "../upload/".$imagename);
    return $imagename;
}else{
    return "fail";
}
}

function deleteFile($dir , $imagename){
    if(file_exists($dir . "/" .$imagename)){
        unlink($dir . "/" .$imagename);
    }
}