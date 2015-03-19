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

    $levels = $user->getLevels();

  } else {
    $classInfo = null;
    $levels = null;
    
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
              'min' => 2,
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
        'level_id' => array(
          'required' => true
          ),
        'question_name' => array(
          'required' => true,
          'min' => 2,
          'max' => 50
          ),
        'qDescription' => array(
          'min' => 2,
          'max' => 100
          ),
        'qfrequency' => array(
            'required' => true
           ),
        'operand1' => array(
            'required' => true
            ),
        'operand2' => array(
            'required' => true
            )
        ));
      
      $qtype = -1;
      if (isset($_POST['practiceRadio'])) {
        $qtype = 0;
      } elseif(isset($_POST['testRadio'])) {
         $qtype = 1;
      }


      if($validation->passed()) {

        try {
           
          
            //Inserting the new question into the database
            $user->addQuestion(array(
              'name' => Input::get('question_name'),
              'description' => Input::get('qDescription'),
              'freq' => Input::get('qfrequency'),
              'question_type' => $qtype,
              'operator' => Input::get('operator'),
              'operand1' => Input::get('operand1'),
              'operand2' => Input::get('operand2'),
              'level_id' => Input::get('level_id'),
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
      <?php if($levels){ ?>
      <thread>
        <tr>
          <th>Level</th>
          <th>Time Limit</th>
          <th>Practice Questions</th>
          <th>Test Questions</th>
          <th>Students on level</th>
        </tr>
      </thred>
      <tbody>
        
        <?php
          $i = 0;

          foreach($levels as $level){
           

            //Convert the std object to an array
            $level = get_object_vars($level); 

            //Grabbing the questons for this level
            $questions = $user->getQuestions($level['level_id']);

            //Grabbing the question and test count
            $practiceCount = 0;
            $testCount = 0;
            foreach($questions as $question) {

              

              if($question['question_type'] == 0)
                $practiceCount++;
              elseif($question['question_type'] == 1)
                $testCount++;
            }
          
          

            ?>

    

        <tr>
          <td><a data-toggle="modal" data-target="#editLevelModal" id="levelview" onclick="setLevelID( '<?php print_r($classInfo['class_id']); ?>' , '<?php print_r($level['level_id']); ?>' ) "><?php print_r($level['name']); ?></a></td>
          <td><?php print_r($level['time_limit']); ?></td>
          <td><?php print_r($practiceCount); ?></td>
          <td><?php print_r($testCount); ?></td>
          <td></td>
        </tr>

        <?php $i = $i + 1; } ?>
      </tbody>
      <?php } ?>
  </table>
</div>
</div>

<!-- Create level buton-->
<div class ="container">
  <div class="row">
    <div class ="col-md-2">
      <a href="#" class="btn btn-default" data-toggle="modal" data-target="#createLevelModal">Create Level</a>
    </div>
    <?php if($levels){ ?>
    <div class ="col-md-2">
      <a href="#" class="btn btn-default" data-toggle="modal" data-target="#addQuestionModal">Add Question</a>
    </div>
    <?php } ?>

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





<!--modal for add Question -->
<div class="modal fade" id="addQuestionModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add Question</h4>
      </div>
      <div class="modal-body">

 <!--forms for input -->

          <!-- need to fix input operation (-/+) size is all messed up -->
          <div class ="form-group">
            <label for "labelForLevelid">LevelName</label>
            <select class ="form-control" name="level_id" id="level_id">
              <?php foreach($levels as $level){
                //Convert the std object to an array
                $level = get_object_vars($level); ?>
              <option value="<?php print_r($level['level_id']); ?>"><?php print_r($level['name']); ?></option>
              <?php } ?>
            </select>
          </div>

          

          <div class ="form-group">
            <label for "labelForQuestionName">Name</label>
              <input type ="text" class"form-control" name="question_name" id ="labelForQuestionName" placeholder="Question Name">
          </div>

          <div class ="form-group">
            <label for "labelForQuestionDescription">Description</label>
              <input type ="text" class"form-control" name="qDescription" id ="labelForQuestionDescription" placeholder="Question Name">
          </div>

          <!-- need to change input type -->
          <div class ="form-group">
            <label for "labelForQuestionFreq">Question Frequency</label>
              <input type ="number" class"form-control" name="qfrequency" id ="labelForQuestionFreq" placeholder="Question Frequency">
          </div>

          <!--check box for practice/test question -->
          <div class ="form-group">
            <h4>Question Type</h4>
            
              <label class ="radio-inline">
                <input type="radio" name="practiceRadio">Practice
              </label>
              <label class ="radio-inline">
                <input type="radio" name="testRadio">Test
              </label>
          
          </div>


          <!-- need to fix input operation (-/+) size is all messed up -->
          <div class ="form-group">
            <label for "labelForQuestionEntry">Question</label>
            <input type ="number" class"form-control" name="operand1" id ="labelOperandrOne" placeholder="Operand 1">
            <input type ="number" class"form-control" name="operand2" id ="labelOperandTwo" placeholder="Operand 2">
            <select class ="form-control" name="operator" id="operator">
              <option>+</option>
              <option>-</option>
            </select>
          </div>



      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="submit" name="addQuestion" class="btn btn-primary">Add Question</button>
       
      </div>
    </div>

  
  
  </div>
</div> 







<!--Script to grab level info for editlevelmodal-->
<script type="text/javascript" src="./jquery-1.4.2.js"></script>
<script type="text/javascript">

  //Variable to store level id info
  var LID = 0;
  var CID = 0;
  QArrLength = -1;
  var Qarr; 
  function setLevelID(classID, levelID){
  
    //document.getElementById('level_ID').innerHTML="Level "+levelID+" info:";
    CID = classID;
    LID = levelID;
    
    //questions = JSON.parse(questions);



    $.post('getQ.php',{classid:CID, levelid:LID},function(data){ 
      
      //alert(data);
      Qarr = JSON.parse(data);

      QArrLength = Qarr.length;

      createTable();
     
     
    }); 

  

  }

</script>

    




<!--Model for editing a level-->
<div class="modal fade" id="editLevelModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">

        
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Level Edit</h4>
    
        <h2 id="level_ID"></h2>
        <div class = "table-responsive" >
          <table id="qtable" class = "table" max-width="150px">
            <thread>
              <tr>
                <th>Question</th>
                <th>Description</th>
                <th>Operand_1</th>
                <th>Operand_2</th>
                <th>Operator</th>
                <th>Question_Type</th>
                <th>Question_Frequency</th>
                <th>Remove_Question</th>
              </tr>
            </thred>
           
                    <script type="text/javascript">
                       //document.getElementById("level_ID").innerHTML=QArrLength;


                       function createTable(){

                         //Linking to the table
                        var table = document.getElementById("qtable");

                        //Creating a new body and adding it to the table
                        var body = document.createElement("tbody");
                        table.appendChild(body);

                          //Loop through each element of the array 
                          for (var i = 0; i < QArrLength; i++) {

                            //Create a new row
                            var newRow = document.createElement("tr");
                            newRow.align = "center";
                            body.appendChild(newRow);

                            //Adding new column to question name
                            var newColumn = document.createElement("TD"); 
                            var t = document.createTextNode(Qarr[i]['questionName']);       
                            newColumn.appendChild(t); 
                            newRow.appendChild(newColumn); 

                            // Description
                            var newColumn = document.createElement("TD"); 
                            var t = document.createTextNode(Qarr[i]['description']);       
                            newColumn.appendChild(t); 
                            newRow.appendChild(newColumn); 

                            //Operand1
                            var newColumn = document.createElement("TD"); 
                            var t = document.createTextNode(Qarr[i]['operand1']);       
                            newColumn.appendChild(t); 
                            newRow.appendChild(newColumn);  

                            //Operand2
                            var newColumn = document.createElement("TD"); 
                            var t = document.createTextNode(Qarr[i]['operand2']);       
                            newColumn.appendChild(t); 
                            newRow.appendChild(newColumn); 

                            //Operator
                            var newColumn = document.createElement("TD"); 
                            var t = document.createTextNode(Qarr[i]['operator']);       
                            newColumn.appendChild(t); 
                            newRow.appendChild(newColumn);  

                            //Question type
                            var newColumn = document.createElement("TD"); 
                            var t = document.createTextNode(Qarr[i]['questiontype']);       
                            newColumn.appendChild(t); 
                            newRow.appendChild(newColumn); 

                            //Question freq
                            var newColumn = document.createElement("TD"); 
                            var t = document.createTextNode(Qarr[i]['frequency']);       
                            newColumn.appendChild(t); 
                            newRow.appendChild(newColumn); 

                            //Remove question button
                            var newColumn = document.createElement("TD"); 
                            var removebtn = document.createElement("Button")
                            removebtn.innerHTML = "Remove";
                            removebtn.onclick = function() {

                              $.post('removequestion.php',{questionid:removebtn.value},
                              function(data)
                              {
                                document.getElementById('level_ID').innerHTML=data;
                              });
                            }
                            removebtn.id = "1";
                            removebtn.value = Qarr[i]['questionid'];
                            newColumn.appendChild(removebtn);
                            newRow.appendChild(newColumn); 

                          }
                          
                        }


                     
                      </script>
                         

          </table>
        </div>

      <div class="modal-footer">
        <button type="button" id="refreshpage" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" id="removelevel"class="btn btn-danger" name="removeLevel">Remove level</button>
      </div>
    </div>
  
  </div>
</div>
<script type="text/javascript" src="./jquery-1.4.2.js"></script>
<script type="text/javascript">

  $('#removelevel').on('click', function (e) {

    $.post('removelevel.php',{levelid:LID},
    function(data)
    {
      document.getElementById('level_ID').innerHTML=data;
    });

  })


  $('#refreshpage').on('click', function (e) {
  
    location.reload();
  })


 

</script>







  </body>

</html>
