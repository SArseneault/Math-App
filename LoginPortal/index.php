<?php
	require_once 'core/init.php';

	if(Session::exists('success')) {
		echo '<p>' . Session::flash('success') . '</p>';
	}

	$user = new User();//Picking current user details

	//Redirect the user if they are not logged in.
	if(!$user->isLoggedIn()) {
    	Redirect::to("includes/errors/loginError.php");

 	} 



	//echo Config::get('mysql/host'); //127.0.0.1


	////////////////////////////////////////////    How to query from data base    ////////////////////////////////////////////

	/*$users = DB::getInstance()->query('SELECT username FROM teacher');
	$users = DB::getInstance()->get('users', array('username', '=', 'alex'));
	$users = DB::getInstance()->get('users', array('username', '>', '5'));
	if($users->count()){
		foreach($users as $user){
			echo $user->username;
		}
	}*/

	//b = new DB();
	/*DB::getInstance()->query('Select username FROM teachers WHERE username = "?' or username = "?", array(
		'alex',
		'billy',
		)*/

	//$user = DB::getInstance()->query( "SELECT username FROM teacher WHERE username = ?", array('alex') );
	//$user = DB::getInstance()->get('teacher', array('username', '=', 'alex'));
	
	/*
	//Grab all the users from the DB
	$user = DB::getInstance()->query( "SELECT * FROM teacher");

	if(!$user->count()) {
		echo '</br>No User';
	} else {
		//Looping through each user
		foreach($user->results() as $user) {
			echo $user->username, "</br>";
		}

		//Grabing just one user 
		echo $user->first()->username;
	}
	*/

	////////////////////////////////////////////    How to inset into data base    ////////////////////////////////////////////
	/*
	$userInsert = DB::getInstance()->insert('teacher', array(
		'username' => 'Dale',
		'password' => 'dPass',
		'salt' => 'salt'
	));

	if($userInsert) {
		//Success
	}
	*/

	////////////////////////////////////////////    How to update data base    ////////////////////////////////////////////
	/*$userInsert = DB::getInstance()->update('teacher', 21, array(
		'password' => 'newPass',
		'name' => 'Mike V'
	));*/

?>

<!DOCTYPE html>
<html>
<head>
  <!-- Connect Bootstrap css -->
  <meta name ="viewport" content="width=deivce-width, initial-scale=1.0">
  <link href="includes/css/bootstrap.min.css" rel="stylesheet">
  <Title> Grayling Math Racer</title>
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
        <li class="active"><a href="index.php">Home</a></li>
        <li><a href="viewClass.php">Class</a></li>
        <li><a href="addLevel.php">Add Level</a></li>
        <li><a href="help.php">Help</a></li>
      </ul>
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
