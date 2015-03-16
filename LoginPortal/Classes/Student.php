<?php
	class Student {
		private $_db,
				$_data;

		//Default constructor connects to database
		public function __construct() {
			$this->_db = DB::getInstance();

		}

		//Ability to create a student
		public function create($fields = array()) {

			//Attempting to insert the new student into the database
			if(!$this->_db->insert('student', $fields)) {
				throw new Exception('There was a problem creating a student.');

			}

			//Grabbing the student id
			$studentID = $this->_db->query('SELECT * FROM student WHERE class_id = ? AND username = ?', array(
				$fields['class_id'],
				$fields['username']
				));
	
			
			//Getting std object
			$studentID = $studentID->first();

			//Convert the std object to an array
	       $studentID = get_object_vars($studentID)['student_id'];

			//Grabbing the level data
			$leveldata = $this->_db->get('level', array('class_id', '=', $fields['class_id']));
			
			//Getting array of std objects
			$leveldata = $leveldata->results();



			//Looping through each level
			foreach($leveldata as $level){

				 //Convert the std object to an array
	            $level = get_object_vars($level);

            	//Creating a default progress level
				$defaultProgress = array(
	            	'student_id' =>  $studentID,
	            	'level_id' => $level['level_id'],
	            	'status' => 0,
	            	'elapsed_time' => '00:00:00',
	            	'attempts' => 0 
	            );

	       

				//Attempt to insert default data for the progress level
				if(!$this->_db->insert('level_progress', $defaultProgress)) {
					throw new Exception('There was a problem inserting default progress for one of the students');
				}

			}


			//Grabbing the question data
			$questiondata = $this->_db->get('question', array('class_id', '=', $fields['class_id']));
			
			//Getting array of std objects
			$questiondata = $questiondata->results();

			//Looping through each question
			foreach($questiondata as $question){

				//Convert the std object to an array
	            $question = get_object_vars($question);

				//Creating a default progress level
					$defaultProgress = array(
		            	'question_id' =>  $question['question_id'],
		            	'level_id' => $question['level_id'],
		            	'answer' => -1,
		            	'student_id' => $studentID,
		            	'attemps' => 0
		            );

		       
					 //Attempting to insert question progress information into the database for each student.
					if(!$this->_db->insert('question_progress', $defaultProgress)) {
						throw new Exception('There was a problem inserting default progress for one of the students');
					}

			}


		}


		//Ability to login to a class
		public function login($username = null, $password = null) {

			//$student == 1 if $username is found in the database
			$student = $this->find($username);
			

			//If the user exists
			if($student) {

				
					//If the passwords match return true
					if($this->data()->password === Hash::make($password, $this->data()->salt)) {
 
						return true;
					}
					
				}

			return false;
		}


		//Find student by their username or id
		public function find($student = null) {

			if($student) {
				$field = (is_numeric($student)) ? 'student_id' : 'username';
				$data = $this->_db->get('student', array($field, '=', $student));



				if($data->count()) {
					$this->_data = $data->first();

					return true;
				}
			}
		}

		public function data() {
			return $this->_data;
		}


		//Grabs the list of students by their class id
		public function getStudents($classID){
			
			
		 $data = $this->_db->get('student', array('class_id', '=', $classID));
				
			if($data->count()) {

				//Getting array of st objects
				$data = $data->results();

				return $data;
			}
			
				
		}

		//Get level progress for the student
		public function getLevelProgress($studentID) {

				$data = $this->_db->get('level_progress', array('student_id', '=', $studentID));
					
				if($data->count()) {

					//Getting array of st objects
					$data = $data->results();

				

					return $data;
				} else {
					return null;
				}


		}

		//Removing a student by id
		public function removeStudent($studentID) {

			//Deleting the student
			if(!$this->_db->delete('student', array('student_id', '=', $studentID))){
				throw new Exception('There was a problem deleting this student.');
			}


			//Removing the students level progress
			if(!$this->_db->delete('level_progress', array('student_id', '=', $studentID))){
				throw new Exception('There was a problem deleting the level progress for this student.');
			}


			//Removing the students question progress
			if(!$this->_db->delete('question_progress', array('student_id', '=', $studentID))){
				throw new Exception('There was a problem deleting the question progress for this student.');
			}


		}
		

	}//End of class
?>