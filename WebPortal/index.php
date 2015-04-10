<?php
	require_once 'core/init.php';

  //Decides when to display the success messages
  if(Session::exists('success')) {
   
      

      //Displaying the flash message
      ?><div class="alert alert-success">
                  <a href="" class="close" data-dismiss="alert">&times;</a>
                  <strong><?php print_r(Session::get('success') );?></strong> 
        </div> <?php

        //Removing the flash instance
        Session::flash('success');

    }

	$user = new User();//Picking current user details

	//Redirect the user if they are not logged in.
	if(!$user->isLoggedIn()) {
    	Redirect::to("includes/errors/loginerror.php");

 	} 



?>

<!DOCTYPE html>
<html>
<head>
  <!-- Connect Bootstrap css -->
  <meta name ="viewport" content="width=deivce-width, initial-scale=1.0">
  <link href="includes/css/bootstrap.min.css" rel="stylesheet">
  <Title> Grayling Math Racer</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
  <script src="https://rawgit.com/nnnick/Chart.js/master/Chart.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  <script src="./Chart.Bar.js"></script>
  </head>

  <!-- Bootstrap js plugins -->
  <script src="https://code.jquery.com/jquery.js"></script>
  <!-- include all compiled plugins -->
  <script src="js/bootstrap.min.js"></script>

</head>

  <body>

    <!-- Navbar -->
<div class="navbar navbar-default navbar-static-top" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Grayling Math Racer</a>
    </div>
    <div class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
<!--         <li class="active"><a href="index.php">Home</a></li>
 -->        <li><a href="viewclass.php">Class Editor</a></li>
        <li><a href="addlevel.php">Level Editor</a></li>
        <li><a href="importexport.php">Import/Export</a></li>
<!--         <li><a href="help.php">Help</a></li>
 -->      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="account.php">Account</a></li>
        <li><a href="logout.php">Log Out</a></li>
         <?php  if($user->isLoggedIn()) {?>
		<li><a><?php echo escape($user->data()->name); ?>!</a></li>
		<?php
		}?>
      </ul>
    </div><!--/.nav-collapse -->
  </div>
</div>

<div class="container">
  <h2>Home</h2>
  <p>Welcome to the grayling math racer web portal. Here you will find the ability to add classes, students, questions, and levels. If you need help with these tasks, please seek the help tab.</p>
</div>

  </body>


</html>
