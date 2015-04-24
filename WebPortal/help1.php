<?php

  require_once 'core/init.php';

  $user = new User();//Picking current user details
    //Redirect the user if they are not logged in.
    if(!$user->isLoggedIn()) {
        Redirect::to("includes/errors/loginerror.php");
    }
    if(!Session::exists(Config::get('teachersession/session_name'))) {

        Redirect::to("includes/errors/sessionexpired.php");

    }

?>

<!DOCTYPE html>
<html>
<head>
  <!-- Connect Bootstrap css -->
  <meta name ="viewport" content="width=deivce-width, initial-scale=1.0">
  <link href="includes/css/bootstrap.min.css" rel="stylesheet">
  <Title> Minute Math Racer</title>
  </head>

  <!-- Bootstrap js plugins -->
  <script src="https://code.jquery.com/jquery.js"></script>
  <!-- include all compiled plugins -->
  <script src="includes/js/bootstrap.min.js"></script>

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
      <a class="navbar-brand" href="index.php">Minute Math Racer</a>
    </div>
    <div class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
        <li><a href="login.php">Log in</a></li>
        <li><a href="register.php">Create Account</a></li>
        <li class="active"><a href="help.php">Help</a></li>

    
    </div><!--/.nav-collapse -->
  </div>
</div>

<div class="container">
  <h2>Welcome to the Minute math racer web portal. </h2>
  <p>This web portal is used with the Minute math racer iOS application.</p>
</div>



  </body>
</head>

</html>
