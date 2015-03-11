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

			print_r($fields);

			if(!$this->_db->insert('student', $fields)) {
				throw new Exception('There was a problem creating a student.');

			}
		}

		//Grabs the list of students by their class id
		public function getStudents($classID){

			if($classID){
			 $data = $this->_db->get('student', array('class_id', '=', $classID));

				if($data->count()) {
					//Getting array of stf objects
					$data = $data->results();


					return $data;
				}
				
				
				}
			else {
				return null;
			}
		}

		

	}//End of class
?>