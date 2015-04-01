<?php
											/////Includes forms and validates form fields. Does NOT actually register the teachers/////
	require_once 'core/init.php';

	//var_dump(Token::check(Input::get('token')));

	//Grabbing data from the forms
	if( Input::exists() ){
		if(Token::check(Input::get('token'))) {

			$validate = new Validate();
			$validation = $validate->check($_POST, array(
				'username' => array(
					'required' => true,
					'min' => 2,
					'max' => 20,
					'unique' => 'teacher' //Unique to the teacher table
				),
				'password' => array(
					'required' => true,
					'min' => 6
				),
				'password_again' => array(
					'required' => true,
					'matches' => 'password'
				),
				'name' => array(
					'required' => true,
					'min' => 2,
					'max' => 50
				)
			));

			if($validation->passed()) {
					$user = new User();
					$salt = Hash::salt(32);

					$username = Input::get('username');
					$password = Hash::make(Input::get('password'), $salt);
					
					try{
						$user->create(array(
							'name' => Input::get('name'),
							'username' => $username,
							'password' => $password,
							'salt' => $salt,
							'joined' => date('Y-m-d H:i:s')
						));


						$login = $user->login($username, $password, true);

						?><div class="alert alert-success">
						    <a href="login.php" class="close" data-dismiss="alert">&times;</a>
						    <strong>Success!</strong> Please go to the login page to login
						</div> <?php
						//Redirect::to("login.php");
					
						
						

					} catch(Exception $e) {
						die($e->getMessage()); //Eventaully redirect user to a error page
					}
					
					
				} else {
					foreach($validation->errors() as $error) {
						echo "<script type='text/javascript'>alert('$error');</script>";
					}
				}
		}
	}


?>






<!DOCTYPE html>
<html>
<head>
  <!-- Connect Bootstrap css -->
  <meta name ="viewport" content="width=deivce-width, initial-scale=1.0">
   <link href="includes/css/bootstrap.min.css" rel="stylesheet">
  <Title> Grayling Math Racer</title>
  </head>
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
    <ul class="nav navbar-nav navbar-right">
      <li><a href="register.php">Create Account</a></li>
       <li><a href="login.php">Log in</a></li>
      <li><a href="help1.php">Help</a></li>
    </ul>
  </div><!--/.nav-collapse -->
</div>
</div>

  <!-- Login information -->
  <div class="container">
    <div class="row">
        <div class="col-sm-6 col-md-4 col-md-offset-4">
            <h2 class="text-center login-title">Create Account</h2>
            <div class="account-wall">
			    <form class="form-signin" action="" method="post">
			    	<input type="text" class="form-control" placeholder="Name"name="name" value="<?php echo escape(Input::get('name')); ?>" id="name">
					<input type="text" class="form-control" placeholder="Username" name="username" id="username" value="<?php echo escape(Input::get('username')); ?>" required autofocus>
					<input type="password" class="form-control" placeholder="Password" name="password" id="password" autocomplete="off" required>
					<input type="password" class="form-control" placeholder="Confirm Password" name="password_again" id="password_again" autocomplete="off" required>
					
					<!-- Grabbing token from form-->
					<input type="hidden" name="token" value="<?php echo Token::generate(); ?>">
					 <button class="btn btn-lg btn-primary btn-block" type="submit">Create Account</button>
				</form>

            </div>
        </div>
    </div>
</div>

  <!-- Bootstrap js plugins -->
  <script src="https://code.jquery.com/jquery.js"></script>
  <!-- include all compiled plugins -->
  <script src="js/bootstrap.min.js"></script>

  </body>
</html>

