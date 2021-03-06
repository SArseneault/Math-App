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


  //Decides when to display the success messages
  if(Session::exists('success')) {
   
      

      //Displaying the flash message
      ?><div class="alert alert-success">
                  <a href="viewclass.php" class="close" data-dismiss="alert">&times;</a>
                  <strong><?php print_r(Session::get('success') );?></strong> 
        </div> <?php

        //Removing the flash instance
        Session::flash('success');

    } else if(Session::exists('fail')) {
   
      

      //Displaying the flash message
      ?><div class="alert alert-danger">
                  <a href="viewclass.php" class="close" data-dismiss="alert">&times;</a>
                  <strong><?php print_r(Session::get('fail') );?></strong> 
        </div> <?php

        //Removing the flash instance
        Session::flash('fail');

    }


  if(Input::exists()) {
      if (isset($_POST['ChangeName'])) {//////////////////////////
      
      if(Token::check(Input::get('token'))) {

      //Validate fields
      $validate = new Validate();

      
      $validation = $validate->check($_POST, array(
        'name' => array(
          'required' => true,
          'min' => 2,
          'max' => 50
          )
        ));
      

      if($validation->passed()) {

        try {
            //Validate with current users
            $user->update(array(
              'name' => Input::get('name')
            ));

            //Flash message
            Session::flash('success', 'Name has been updated.');
            //Redirect::to("account.php");
            //Refresh the page to show the update
           header("Refresh:0");
        } catch(Execption $e) {
          die($e->getMessage());
        }

      } else {

              $errorString = "</br>";
              foreach($validation->errors() as $error) {
                $errorString = $errorString . $error . "</br>";
               
              }


          ?> <div class="alert alert-danger">
                <a href="login.php" class="close" data-dismiss="alert">&times;</a>
                <strong>Error!</strong> <?php echo($errorString); ?>
              </div> <?php
      }
    }
  } elseif(isset($_POST['ChangePass'])) {/////////////////////////////////////
     
      if(Token::check(Input::get('token'))) {
   
      //Validate fields
      $validate = new Validate();
      $validation = $validate->check($_POST, array(
        'password_current' => array(
            'required' => true,
            'min' => 6
         ),
        'password_new' => array(
            'required' => true,
            'min' => 6
         ),
        'password_new_again' => array(
            'required' => true,
            'min' => 6,
            'matches' => 'password_new'
          )
        ));
      //Creating an error string
      $errorString = "</br>";

      if($validation->passed()) {

        try {
          
            if(Hash::make(Input::get('password_current'), $user->data()->salt) !== $user->data()->password){
              $errorString = "Current password is wrong </br>";
              Session::flash('fail', $errorString);
              header("Refresh:0");
            }else {
              $salt = Hash::salt(32);
              $user->update(array(
                'password' => Hash::make(Input::get('password_new'), $salt),
                'salt' => $salt
                ));

              //Flash message
            Session::flash('success', 'password has been changed.');
            //Redirect::to("account.php");
            //Refresh the page to show the update
           header("Refresh:0");
            }
        
        } catch(Execption $e) {
          die($e->getMessage());
        }

      } else {
      
             
              foreach($validation->errors() as $error) {
                $errorString = $errorString . $error . "</br>";
               
              }


          ?> <div class="alert alert-danger">
                <a href="login.php" class="close" data-dismiss="alert">&times;</a>
                <strong>Error!</strong> <?php echo($errorString); ?>
              </div> <?php




      }
    }

  }//////////////////////////
   


  }


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
 
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  <script src="./Chart.Bar.js"></script>
  </head>

  <!-- Bootstrap js plugins -->
  <script src="https://code.jquery.com/jquery.js"></script>
  <!-- include all compiled plugins -->
  <script src="includes/js/bootstrap.min.js"></script>

</head>

  <body>


 <!-- Navbar -->
 <!-- Website icon -->
<link rel="shortcut icon" href="includes/images/icon.gif">

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
        <!-- <li><a href="index.php">Home</a></li> -->
        <li><a href="viewclass.php">Class Editor</a></li>
        <li><a href="addlevel.php">Level Editor</a></li>
        <li><a href="importexport.php">Import/Export</a></li>
        <li><a href="help.php">Help</a></li>

      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li class="active"><a href="account.php">Account</a></li>
        <li><a href="logout.php">Log Out</a></li>
         <?php  if($user->isLoggedIn()) {?>
        <li><a><?php echo escape($user->data()->name); ?></a></li>
        <?php
        }?>
      </ul>
    </div><!--/.nav-collapse -->
  </div>
</div>


  <div class="container">
    <h2> Account </h2>
    <?php if($user->hasPermission('admin')) {?>
     <p>**This account is an administrator</p>
    <?php } ?>

      
  </div>

 

<!-- Buttons for the modals-->
<div class ="container">
  <div class="row">
    <div class ="col-md-2">
      <a href="#" class="btn btn-default" data-toggle="modal" data-target="#updateNameModal">Update name</a>
      
    </div>
    <div class ="col-md-2">
      <a href="#" class="btn btn-default" data-toggle="modal" data-target="#changePasswordModal">Change Password</a>
     
    </div>

  </div>
</div>


<!--modal update name -->
<div class="modal fade" id="updateNameModal" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Create Level</h4>
      </div>
      <div class="modal-body">

        <!--forms for input -->
        <form action="" method="post">
          <pre>
          New Name: <input type="text" class"field" id ="name" name="name" value="<?php echo escape($user->data()->name); ?>">
          </br>
        </pre>

      
          </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="submit" name="ChangeName" class="btn btn-primary">Update</button>
              <input type="hidden" name="token" value="<?php echo Token::generate(); ?>">
            </div>
          </div>
      <!--</form>-->

  </div>
</div>


<!--modal for add question -->
<div class="modal fade" id="changePasswordModal" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Change Password</h4>
      </div>
      <div class="modal-body">

         <!--forms for input -->
       <!-- <form action="" method="post">-->
       <pre>
            Current Password: <input type="password" name="password_current" id="password_current">
          </br>
                New Password: <input type="password" name="password_new" id="password_new">
          </br>
            Confirm Password: <input type="password" name="password_new_again" id="password_new_again">
          </br>
         
      </pre>

          </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
               <button type="submit" name="ChangePass" class="btn btn-primary">Change Password</button>
               
               
               
            </div>
        </form>

    </div>
  </div>
</div>
 






  </body>
</html>
