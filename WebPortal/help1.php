<?php

  require_once 'core/init.php';
?>

<!DOCTYPE html>
<html>
<head>
  <!-- Connect Bootstrap css -->
  <meta name ="viewport" content="width=deivce-width, initial-scale=1.0">
   <link href="includes/css/bootstrap.min.css" rel="stylesheet">
  <Title> Minute Math Racer</title>
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
    <a class="navbar-brand" href="#">Minute Math Racer</a>
  </div>
  <div class="navbar-collapse collapse">
    <ul class="nav navbar-nav navbar-right">
      <li><a href="register.php">Create Account</a></li>
       <li><a href="login.php">Log in</a></li>
      <li class="active"><a href="help1.php">Help</a></li>
    </ul>
  </div><!--/.nav-collapse -->
</div>
</div>

<div class="container">
  <h2>Welcome to the Minute math racer web portal. </h2>
  <p>This web portal is used with the Minute math racer iOS application.</p>
  <p>You can download the user manual <a href="defaults/User Manual.docx" download="User Manual.docx">here.</a></p>
</div>



  </body>
</head>

</html>
