<?php 
  require_once 'core/init.php';

  $user = new User();//Picking current user details
  $student = new Student(); //Creating a student object

  //Redirect the user if they are not logged in.
  if(!$user->isLoggedIn()) {
      Redirect::to("includes/errors/loginError.php");
  }

  //Creating and setting the classInfo and students variables
  if($user->classExist()){
    $classInfo = $user->getClass();
    $students = $student->getStudents($classInfo['class_id']);

    $levelInfo = null;
  } else {
    $classInfo = null;
  }

if(Input::exists()) {
    if (isset($_POST['createLevel'])) {
      if(Token::check(Input::get('token'))) {

      //Validate fields
      $validate = new Validate();

        
      $validation = $validate->check($_POST, array(
        'level_name' => array(
          'required' => true,
          'min' => 2,
          'max' => 50
          ),
        'time_limit' => array(
          'required' => true,
          'max' => 11
          ),
        'lDescription' => array(
              'required' => false,
              'min' => 6,
              'max' => 100
           ),
        ));
      

      if($validation->passed()) {

        try {
           

            //Inserting the new levelinto the database
            $user->addLevel(array(
              'name' => Input::get('level_name'),
              'description' => Input::get('lDescription'),
              'time_limit' => Input::get('time_limit'),
              'class_id' => $classInfo['class_id']
              ));

            

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
  } elseif (isset($_POST['addQuestion'])) {
      if(Token::check(Input::get('token'))) {

      //Validate fields
      $validate = new Validate();

      $validation = $validate->check($_POST, array(
        'first_name' => array(
          'required' => true,
          'min' => 2,
          'max' => 50
          ),
        'last_name' => array(
          'required' => true,
          'min' => 2,
          'max' => 50
          ),
        'password' => array(
            'required' => true,
            'min' => 6
           ),
        'password_again' => array(
            'required' => true,
            'min' => 6,
            'matches' => 'password'
            )

        ));
      

      if($validation->passed()) {

        try {
           

            //Creating a new student
            $student = new Student();
            $salt = Hash::salt(32);
            //Inserting the new student into the database
            $student->create(array(
              'first_name' => Input::get('first_name'),
              'last_name' => Input::get('last_name'),
              'username' => Input::get('username'),
              'password' => Hash::make(Input::get('password'), $salt),
              'class_id' => $classInfo['class_id'],
              'joined' => date('Y-m-d H:i:s'),
              'salt' => $salt
              ));


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
      <a class="navbar-brand" href="index.php">Grayling Math Racer</a>
    </div>
    <div class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
        <li><a href="index.php">Home</a></li>
        <li><a href="viewClass.php">Class</a></li>
        <li class="active"><a href="addLevel.php">Add Level</a></li>
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


<!-- Table used to display levels -->
<?php 
// If the class exists then display the table and grab the info
if($user->classExist()){  ?>
<div class ="container">
  <div class = "table-responsive">
    <table class = "table">
      <thread>
        <tr>
          <th>Level</th>
          <th>Practice Questions</th>
          <th>Test Questions</th>
          <th>Students on level</th>
        </tr>
      </thred>
      <tbody>
        <tr>
          <td>Level 1</td>
          <td>5</td>
          <td>15</td>
          <td>2<td>
        </tr>
        <tr>
          <td>Level 2</td>
          <td>6</td>
          <td>10</td>
          <td>4</td>
        </tr>
        <tr>
          <td>Level 3</td>
          <td>7</td>
          <td>9</td>
          <td>1</td>
        </tr>
      </tbody>
  </table>
</div>
</div>

<!-- Create level buton-->
<div class ="container">
  <div class="row">
    <div class ="col-md-2">
      <a href="#" class="btn btn-default" data-toggle="modal" data-target="#createLevelModal">Create Level</a>
    </div>
 
</div>
<?php } else { //Display this message if the class doesn't exsits?>
  <h3><p>You have not created a class yet!</p></h3>
  <p>Please created a class to the unlock level editor mode</p>
  
<?php } ?>

<!--modal for create Class -->
<div class="modal fade" id="createLevelModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Create Class</h4>
      </div>
      <div class="modal-body">

        <!--forms for input -->
        <form action="" method="post">
          <div class ="form-group">
            <label for "labelForLevelName">Name</label>
              <input type ="text" class"form-control" name="level_name" id ="labelForLevelName" placeholder="Level Name">
          </div>
          <div class ="form-group">
            <label for "labelForLevelDescription">Description</label>
              <input type ="text" class"form-control" name="lDescription" id ="labelForLevelName" placeholder="Description">
          </div>
          <div class ="form-group">
            <label for "labelForLevelTime">Time Limit</label>
              <input type ="text" class"form-control" name="time_limit" id ="labelForLevelTime" placeholder="in minutes">
          </div>
  

        
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            <button type="submit" name="createLevel" class="btn btn-primary">Create Level</button>
            <input type="hidden" name="token" value="<?php echo Token::generate(); ?>">
          </div>
        </div>
      
  </div>
</div> 





<!--modal for add question -->
<div class="modal fade" id="addQuestionModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add Question</h4>
      </div>
      <div class="modal-body">

        <!--forms for input -->
          <div class ="form-group">
            <label for "labelForQuestionName">Name</lable>
              <input type ="text" class"form-control" name="question_name" id ="labelForQuestionName" placeholder="Question Name">
          </div>

          <div class ="form-group">
            <label for "labelForQuestionDescription">Description</lable>
              <input type ="text" class"form-control" name="qDescription" id ="labelForQuestionDescription" placeholder="Question Name">
          </div>

          <!-- need to change input type -->
          <div class ="form-group">
            <label for "labelForQuestionFreq">Question Frequency</lable>
              <input type ="number" class"form-control" name="qfrequency" id ="labelForQuestionFreq" placeholder="Question Frequency">
          </div>

          <!--check box for practice/test question -->
          <div class ="form-group">
            <h4>Question Type</h4>
            <form role ="form">
              <label class ="radio-inline">
                <input type="radio" name="practiceRadio">Practice
              </label>
              <label class ="radio-inline">
                <input type="radio" name="testRadio">Test
              </label>
            </form>
          </div>


          <!-- need to fix input operation (-/+) size is all messed up -->
          <div class ="form-group">
            <label for "labelForQuestionEntry">Question</lable>
            <input type ="number" class"form-control" id ="labelOperatorOne" placeholder="Operator 1">
            <input type ="number" class"form-control" id ="labelOperatorTwo" placeholder="Operator 2">
            <select class ="form-control" id="operator">
              <option>+</option>
              <option>-</option>
            </select>
          </div>


          <div class ="form-group">
            <label for "labelForQuestionAnswer">Answer</lable>
              <input type ="number" class"form-control" id ="labelForQuestionAnswer" placeholder="Answer">
          </div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="submit" name="addQuestion" class="btn btn-primary">Add Question</button>
       
      </div>
    </div>
  </form>
  </div>
</div>








  </body>


</html>
