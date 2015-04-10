<?php
	require_once 'core/init.php';

	if(Input::exists()) {
		if(Token::check(Input::get('token'))) {
			$validate = new Validate();
			$validation = $validate->check($_POST, array(
				'username' => array('required' => true),
				'password' => array('required' => true)
			));

			if($validation->passed()) {
				$user = new User();

				$remember = (Input::get('remember') == 'on') ? true : false;
				$login = $user->login(Input::get('username'), Input::get('password'), $remember);
				
				if($login) {
					Session::flash('success', 'You have successfully logged in!');
					Redirect::to("viewclass.php");
				} else {

          ?> <div class="alert alert-danger">
                <a href="login.php" class="close" data-dismiss="alert">&times;</a>
                <strong>Error!</strong>Sorry, logging in failed.
              </div> <?php
				}


			} else {
				foreach($validation->errors() as $error) {
					echo $error, '<br>';
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
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
  <script src="https://rawgit.com/nnnick/Chart.js/master/Chart.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  <script src="./Chart.Bar.js"></script>
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
      <!-- <li><a href="help1.php">Help</a></li> -->
    </ul>
  </div><!--/.nav-collapse -->
</div>
</div>


<!--login form -->

<div class="container">
  <div class="row">
      <div class="col-sm-6 col-md-4 col-md-offset-4">
          <h2 class="text-center login-title">Log In </h2>
          <div class="account-wall">
              <form class="form-signin" form action="" method="post">

              

              <input type="text" class="form-control"  name="username" id="username" placeholder="Username" required autofocus>
              <input type="password" name="password" id="password" class="form-control" placeholder="Password" required>
              <input type="hidden" name="token" value="<?php echo Token::generate(); ?>">
              <button class="btn btn-lg btn-primary btn-block" type="submit">Sign In</button>
		

            <div class="field">
    			  	<label class="checkbox pull-left" for="remember">
    					 <input type="checkbox" name="remember" id="remember">Remember me
    				  </label>
  			   </div>

              </form>
             
          </div>
      </div>
  </div>
</div>

<!-- This script will check to see if the caps lock is on when entering a password -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
    <script language="Javascript">
        $(document).ready(function(){
            $('input').keypress(function(e) { 
                var s = String.fromCharCode( e.which );

                if((s.toUpperCase() === s && s.toLowerCase() !== s && !e.shiftKey) ||
                   (s.toUpperCase() !== s && s.toLowerCase() === s && e.shiftKey)){
                    if($('#capsalert').length < 1) $(this).after('<b id="capsalert">CapsLock is on!</b>');
                } else {
                    if($('#capsalert').length > 0 ) $('#capsalert').remove();
                }
            });
        });
    </script>
  <!-- Bootstrap js plugins -->
  <script src="https://code.jquery.com/jquery.js"></script>
  <!-- include all compiled plugins -->
  <script src="js/bootstrap.min.js"></script>

</body>


</html>
