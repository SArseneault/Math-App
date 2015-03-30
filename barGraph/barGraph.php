<?php
//include the free open source library phpgraphlib
include('phpgraphlib.php');

//creating a new bar graph
$graph = new PHPGraphLib(500,350);

//connecting to a local host database
$link = mysql_connect('localhost', 'root', '')
   or die('Could not connect: ' . mysql_error());
 
 //selecting the database to use    
mysql_select_db('mathappinfo') or die('Could not select database');
  
 //create an array 
$data=array();
  
//get data from database, in this case, the student id is going along my 
//x-axis and the level id is going along the y-axis
$sql="SELECT  student_id,level_id FROM  level_progress";
$result = mysql_query($sql) or die('Query failed: ' . mysql_error());
if ($result) {
  while ($row = mysql_fetch_assoc($result)) {
      $name=$row['student_id'];
      $description=$row['level_id'];
      //add to data areray
      $data[$name]=$description;
  }
}

//using the pre built functions to make the graph
//the x-axis are numbers because i used the student id instead of names
$graph->addData($data);
$graph->setTitle('x=Student ID, y=Level ID');
//changes bar color apperance, two-toned
$graph->setGradient('green', 'blue');
$graph->createGraph();
?>