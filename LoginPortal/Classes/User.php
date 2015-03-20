<?php
	class User {
		private $_db,
				$_data,
				$_sessionName,
				$_cookieName,
				$isLoggedIn;

		//Default constructor connects to database
		public function __construct($user = null) {
			$this->_db = DB::getInstance();
			$this->_sessionName = Config::get('session/session_name');
			$this->_cookieName = Config::get('remember/cookie_name');


			if(!$user) {

				//Checking if there is a user is logged in
				if(Session::exists($this->_sessionName)) {
					$user = Session::get($this->_sessionName);
				}

				//checking if the user exsits
				if($this->find($user)) {
					$this->_isLoggedIn = true;
				} else {
					$this->_isLoggedIn = false;
					// process logout
				}

			}else {
				$this->find($user);
			}

		}

		
		//Checking if the class exists
		public function classExist() {
		    
		    //Grabbing the current teacher id
		    $id = null;
			if(isset( $this->data()->id))
				$id =$this->data()->id;

		
			//Grabbing the class data
			$data = $this->_db->get('class', array('teacher_id', '=', $id));
			
			if($data->count()) {
				return true;
			}
			else
				return false;
			
			
		}

		//Returning an array containing the class information
		public function getClass(){
			
		    
		    //Grabbing the current teacher id
		    $id = null;
			if(isset( $this->data()->id))
				$id =$this->data()->id;


			//Grabbing the class data
			$data = $this->_db->get('class', array('teacher_id', '=', $id));
			
			//Set to first 
			$data = $data->first();
	
			//Convert the std object to an array
			$data = get_object_vars($data);
			
			return $data;
			
		}

		//Adding a level to a class
		public function addLevel($fields = array()){

			//Attempt to create the new level
			if(!$this->_db->insert('level', $fields)) {
				throw new Exception('There was a problem creating a level.');
			}

			//Grabbing the newly created level data
			$leveldata = $this->_db->get('level', array('name', '=', $fields['name']));

			//Grabbing std object
			$leveldata = $leveldata->first();

			//Convert the std object to an array
	        $leveldata = get_object_vars($leveldata);

		
			//Creating a student helper object
			$studentOBJ = new Student();

			//Gabbing all the students inside of this class
			$students = $studentOBJ->getStudents($this->getClass()['class_id']);
			
			if($students){
				//For each student update the level progress to a default value
				foreach($students as $student){

		            //Convert the std object to an array
		            $student = get_object_vars($student);



	            	//Creating a default progress level
					$defaultProgress = array(
		            	'student_id' => $student['student_id'],
		            	'level_id' => $leveldata['level_id'],
		            	'status' => 0,
		            	'elapsed_time' => '00:00:00',
		            	'test_attempts' => 0 ,
		            	'practice_attempts' => 0 
		            );

		       

					//Attempt to insert default data for the progress level
					if(!$this->_db->insert('level_progress', $defaultProgress)) {
						throw new Exception('There was a problem inserting default progress for one of the students');
					}
	           }
			}
		}

		//Removing a level to a class
		public function removeLevel($levelID){

			//Deleting actual level
			if(!$this->_db->delete('level', array('level_id', '=', $levelID))){
				throw new Exception('There was a problem deleting a level.');
			}

			//Deleting all the student progress tables associted with the level
			if(!$this->_db->delete('level_progress', array('level_id', '=', $levelID))){
				throw new Exception('There was a problem deleting the level progress.');
			}


			//Deleting all questions associated with the level
			if(!$this->_db->delete('question', array('level_id', '=', $levelID))){
				throw new Exception('There was a problem deleting the questions.');
			}

			
		}

		public function removeQuestion($questionID) {

		//Deleting the actual question
		if(!$this->_db->delete('question', array('question_id', '=', $questionID))){
			throw new Exception('There was a problem deleting the question.');
		}


		//Deleting all the student progress associated with the question_id
		if(!$this->_db->delete('question_progress', array('question_id', '=', $questionID))){
			throw new Exception('There was a problem deleting the question in the question progress table.');
		}

		}

		//Returns the union of the level and the 
		public function getLevels($classID = null){

			//If the class id exists then use it to find the levels
			if(!$classID){
				//Setting the class id to the current teacher's class
				$classID = $this->getClass()['class_id'];
			}


			//Grabbing the level data
			$data = $this->_db->get('level', array('class_id', '=', $classID));
			
			//Getting array of std objects
			$data = $data->results();
	
			

			return $data;
		}

		//Attemps to insert a question into the database
		public function addQuestion($fields = array()){

			//Attemping to insert the question into the data base.
			if(!$this->_db->insert('question', $fields)) {
				throw new Exception('There was a problem creating this question.');
			}

			//Grabbing the question id
			$questionID = $this->_db->query('SELECT * FROM question WHERE name = ? AND description = ? AND question_type = ? AND level_id = ?', array(
				$fields['name'],
				$fields['description'],
				$fields['question_type'],
				$fields['level_id']
				));

			//Getting std object
			$questionID = $questionID->first();

			//Convert the std object to an array
	       $questionID = get_object_vars($questionID)['question_id'];


            //Creating a student helper object
			$studentOBJ = new Student();

			//Gabbing all the students inside of this class
			$students = $studentOBJ->getStudents($this->getClass()['class_id']);

			if( $students ){
				//For each student update the question progress to a default value
				foreach($students as $student){

		            //Convert the std object to an array
		            $student = get_object_vars($student);


	            	//Creating a default progress level
					$defaultProgress = array(
		            	'question_id' =>  $questionID,
		            	'level_id' => $fields['level_id'],
		            	'answer' => -1,
		            	'student_id' => $student['student_id'],
		            	'attempts' => 0
		            );

		       
					 //Attempting to insert question progress information into the database for each student.
					if(!$this->_db->insert('question_progress', $defaultProgress)) {
						throw new Exception('There was a problem inserting default progress for one of the students');
					}
				}
			}
		}
		
		//Returns all of the questions in a certain level
		public function getQuestions($levelID = null){

			//Grabbing the question
			$data = $this->_db->get('question', array('level_id', '=', $levelID));
			
			//Getting array of stf objects
			$data = $data->results();

			//Creating a question array
			$questions = array();

			
			//Appending each data result to the array
			foreach($data as $question){

				//Convert the std object to an array of question info
                $question = get_object_vars($question);
         		
         		//Pushing the question array to the array of questions
                array_push($questions, $question);	
			}
			

			return $questions;
		}


		//Update user table
		public function update($fields = array(), $id = null) {

			//Update the currents users id if none is passed in
			if(!$id && $this->isLoggedIn()) {
				$id = $this->data()->id;
			}


			if(!$this->_db->update('teacher', $id, 'id', $fields)) {
				throw new exception('There was a problem updating.');
			}
		}

		//Ability to create a user
		public function create($fields = array()) {
			if(!$this->_db->insert('teacher', $fields)) {
				throw new Exception('There was a problem creating an account.');

			}
		}

		//Find user by its username or id
		public function find($user = null) {
			if($user) {
				$field = (is_numeric($user)) ? 'id' : 'username';
				$data = $this->_db->get('teacher', array($field, '=', $user));

				if($data->count()) {
					$this->_data = $data->first();
					return true;
				}
			}
		}

		//Ability to login to data base
		public function login($username = null, $password = null, $remember = false) {

			//Check if a username and password hasn't been defined
			if(!$username && $password && $this->exists()) {
				//C
				Session::put($this->_sessionName, $this->data()->id);
			} else {

				//$user == 1 if $username is found in the database
				$user = $this->find($username);
			


			//If the user exists
			if($user) {
				
					
					if($this->data()->password === Hash::make($password, $this->data()->salt)) {
					
						Session::put($this->_sessionName, $this->data()->id);

						//If the user wants to be rememered
						if($remember) {

							//Generate hash
							$hash = Hash::unique();
							$hashCheck = $this->_db->get('teacher_session', array('teacher_id','=',$this->data()->id));

							if(!$hashCheck->count()) {
								$this->_db->insert('teacher_session',array(
									'teacher_id' => $this->data()->id,
									'hash' => $hash
									));
							} else {
								$hash = $hashCheck->first()->hash;
							}

							//Storinng the cookie
							Cookie::put($this->_cookieName, $hash, Config::get('remember/cookie_expiry'));
						}

						return true;
					}
					//if($this->data()->password === Hash::make($password, $this->data()->salt)) 
				}

			}
			return false;
		}

		//Checking if a user is in a certian group
		public function hasPermission($key) {
			$group = $this->_db->get('groups', array('id', '=', $this->data()->group));

			if($group->count()) {
				//Converting JSOSN to array
				$permissions = json_decode($group->first()->permissions, true);
	

				if($permissions[$key] === 1) {
						return true;
				}
			}
			return false;
		}

		public function exists(){
			return (!empty($this->_data)) ? true : false;
		}

		public function logout() {

			//Delete current login id
			if(!$this->_db->delete('teacher_session', array('teacher_id', '=', $this->data()->id))){
				Redirect::to("includes/errors/logoutError.php");

			}

			//Delete session and cookie
			Session::delete($this->_sessionName);
			Cookie::delete($this->_cookieName);

		}

		public function data() {
			return $this->_data;
		}

		public function isLoggedIn() {
			return $this->_isLoggedIn;
		}

	}//End of class
?>