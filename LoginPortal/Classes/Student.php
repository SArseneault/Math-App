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


		}
		

	}//End of class
?>