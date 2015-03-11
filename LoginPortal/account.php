<?php 
  require_once 'core/init.php';

  $user = new User();//Picking current user details

  //Redirect the user if they are not logged in.
  if(!$user->isLoggedIn()) {
      Redirect::to("includes/errors/loginError.php");
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
            //Session::flash('success', 'Name has been updated.');
            //Redirect::to("account.php");
            //Refresh the page to show the update
           header("Refresh:0");
        } catch(Execption $e) {
          die($e->getMessage());
        }

      } else {
        foreach($validation->errors() as $error) {
          echo $error, '<br>';
        }
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
      

      if($validation->passed()) {

        try {
          
            //trim the hash before check
            $trimHash = Hash::make(Input::get('password_current'), $user->data()->salt);
            $trimHash = substr ($trimHash ,0,-14);
      
            if($trimHash !== $user->data()->password){
              echo "Current password is wrong";
            }else {
              $salt = Hash::salt(32);
              $user->update(array(
                'password' => Hash::make(Input::get('password_new'), $salt),
                'salt' => $salt
                ));
            }
        
            //Flash message
            //Session::flash('success', 'password has been changed.');
            //Redirect::to("account.php");
            //Refresh the page to show the update
           //header("Refresh:0");
        } catch(Execption $e) {
          die($e->getMessage());
        }

      } else {
        foreach($validation->errors() as $error) {
          echo $error, '<br>';
        }
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
  <Title> Grayling Math Racer</title>
  </head>

  <!-- Bootstrap js plugins -->
  <script src="https://code.jquery.com/jquery.js"></script>
  <!-- include all compiled plugins -->
  <script src="includes/js/bootstrap.min.js"></script>

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
      <a class="navbar-brand" href="index.html">Grayling Math Racer</a>
    </div>
    <div class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
        <li><a href="index.php">Home</a></li>
        <li><a href="viewClass.php">Class</a></li>
        <li><a href="addLevel.php">Add Level</a></li>
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
<div class="modal fade" id="updateNameModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Create Level</h4>
      </div>
      <div class="modal-body">

        <!--forms for input -->
        <form action="" method="post">
          <div class ="field">
            <label for="name">New Name</label>
              <input type="text" class"field" id ="name" name="name" value="<?php echo escape($user->data()->name); ?>">
          </div>

      
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
<div class="modal fade" id="changePasswordModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Change Password</h4>
      </div>
      <div class="modal-body">

         <!--forms for input -->
       <!-- <form action="" method="post">-->
          <div class ="field">
            <label for="password_current">Current Password</label>
              <input type="password" name="password_current" id="password_current">
          </div>

          <div class ="field">
            <label for="password_new">New Password</label>
              <input type="password" name="password_new" id="password_new">
          </div>

          <div class ="field">
            <label for="password_new_again">Confirm Password</label>
              <input type="password" name="password_new_again" id="password_new_again">
          </div>
         
      

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
