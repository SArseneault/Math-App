<?php
//include the free open source library phpgraphlib
//require_once 'core/init.php';
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
$data2=array();
  
//get data from database, in this case, the student id is going along my 
//x-axis and the level id is going along the y-axis
$sql="SELECT  time_limit,level_id,class_id,name FROM  level";
$result = mysql_query($sql) or die('Query failed: ' . mysql_error());
if ($result) {
  while ($row = mysql_fetch_assoc($result)) {
		//y-axis      
      $name=$row['name'];
      //x-axis
      $description=$row['level_id'];
      $description2=$row['class_id'];
      //add to data areray
      $data[$name]=$description;
  	  $data2[$name]=$description2;
	}		
}

$graph->addData($data, $data2);

//set bar colors
$graph->setBarColor('blue', 'green');

//Title for the graph
$graph->setTitle('Student Progress');
$graph->setupYAxis(12, 'blue');
$graph->setupXAxis(20);
//true = a grid behind the bars False =  no grid
$graph->setGrid(true);
//creates a legend to the graph
$graph->setLegend(true);
//title alignment across the top of the graph
$graph->setTitleLocation('center');

//set color of the title
$graph->setTitleColor('blue');
$graph->setLegendOutlineColor('white');
//set a legend for the bar graph
$graph->setLegendTitle('level_id', 'student_id');

$graph->setXValuesHorizontal(true);
//render graph
$graph->createGraph();

//this snippet is for non-stacked bars for graph
//using the pre built functions to make the graph
//the x-axis are numbers because i used the student id instead of names
// $graph->addData($data);
// $graph->setTitle('x=Student ID, y=Level ID');
// //changes bar color apperance, two-toned
// $graph->setGradient('green', 'green');
// $graph->createGraph();


?>