<?php
include 'connect.php';

$id = addslashes( $_REQUEST['id'] );

//Querys last id from the photo table
//(Fetches an associative array) Gaining access to all columns of the table
//Turns $image into an array and grabs the photo. (Specified we want the StudentPhoto column)
$image = mysql_query("SELECT * FROM snapshot WHERE id=$id");
$image = mysql_fetch_assoc($image);
$image = $image['image'];

//Header function
//Change the format of the whole page into an image
header("Content-type: image/jpeg");

echo $image;
?>
