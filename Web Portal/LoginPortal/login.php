<?php
	require_once 'core/init.php';

	if(Input::exists()) {
		if(Token::check(Input::get('token'))) {
			$validate = new validate();
			$validation = $validate->check($_POST, array(
				'username' => array('required' => true),
				'password' => array('required' => true)
			));

			if($validation->passed()) {
				$user = new User();
				$login = $user->login(Input::get('username'), Input::get('password'));
				
				if($login) {
					echo 'You have successfully logged in!';
					Session::flash('success', 'You have successfully logged in!');
					Redirect::to("welcome.php");
				} else {
					echo '<p>Sorry, logging in failed.</p>';
				}


			} else {
				foreach($validation->errors() as $error) {
					echo $error, '<br>';
				}
			}
		}
	}
?>




<!-- Add fields for login page
<form action="" method="post">
	<div class="field">
		<label for="username">Username</label>
		<input type="text" name="username" id="username" autocomplete="off">
	</div>

	<div class="field">
		<label for="password">Password</label>
		<input type="password" name="password" id="password" autcomplete="off">
	</div>


	<input type="hidden" name="token" value="<?php echo Token::generate(); ?>">
	<input type="submit" value="Log in">


</form>-->

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Member Login</title>

    <!-- Bootstrap -->
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body style="background:#eee;">
    
    <div class="container">
    		<p><br/></p>
  		<div class="row">
  			<div class="col-md-8"></div>
  			<div class="col-md-4">
  				<div class="panel panel-default">
  					<div class="panel-body">
    						<div class="page-header">
  							<h3>Login Area</h3>
						</div>
						<form action="" method="post">
  							
    				
  							

							<label for="username">Username</label>
			  				<div class="input-group">
			  					<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
								<input type="text" name="username" id="username" placeholder="Username" autocomplete="off">
							</div>
							<label for="password">Password</label>
							<div class="input-group">
								<span class="input-group-addon"><span class="glyphicon glyphicon-star"></span></span>
								<input type="password" name="password" id="password" placeholder="Password"  autcomplete="off">
							</div>

  							<hr/>
  							<button type="button" class="btn btn-success"><span class="glyphicon glyphicon-arrow-left"></span> Back</button>
  							<input type="hidden" name="token" value="<?php echo Token::generate(); ?>">
  							<button type="submit" value="Log in" class="btn btn-primary"><span class="glyphicon glyphicon-lock"></span> Login</button>
  							
							
  							
						</form>
						<form action="register.php">
					    	<input type="submit" class="btn btn-danger" value="Register"></input>
						</form>
						<p><br/></p>
						
  					</div>
				</div>
  			</div>
		</div>
    </div>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
  </body>
</html>
