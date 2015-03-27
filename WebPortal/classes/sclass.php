<?php
	class SClass {
		private $_db,
				$_data;

		//Default constructor connects to database
		public function __construct() {
			$this->_db = DB::getInstance();

		}

		//Ability to create a class
		public function create($fields = array()) {
			if(!$this->_db->insert('class', $fields)) {
				throw new Exception('There was a problem creating a class.');

			}
		}


		//Ability to login to a class
		public function login($classname = null, $password = null) {

			//$sclass == 1 if $classname is found in the database
			$sclass = $this->find($classname);
			

			//If the user exists
			if($sclass) {
				
					//If the passwords match return true
					if($this->data()->class_password === Hash::make($password, $this->data()->salt)){
					

						return true;
					}
					
				}

			return false;
		}

		
		//Delete a class by its id
		public function deleteClass($classID) {

			

			//Grabbing level data
			$leveldata = $this->_db->get('level', array('class_id', '=', $classID));
			$leveldata = $leveldata->results();
			foreach($leveldata as $level){

				//Convert the std object to an array
	        	$level = get_object_vars($level);

	        	//Remove all the level prog associated with this class
				if(!$this->_db->delete('level_progress', array('level_id', '=', $level['level_id']))){
				throw new Exception('There was a problem deleting one of these level progress.');
				}
			}

			//Remove all the levels associated with this class
			if(!$this->_db->delete('level', array('class_id', '=', $classID))){
				throw new Exception('There was a problem deleting one of these levels.');
			}

			

			//Grabbing the question data
			$questiondata = $this->_db->get('question', array('class_id', '=', $classID));
			$questiondata = $questiondata->results();
			foreach($questiondata as $question){

				//Convert the std object to an array
	        	$question = get_object_vars($question);

	        	//Remove all the question prog associated with this class
				if(!$this->_db->delete('question_progress', array('question_id', '=', $question['question_id']))){
				throw new Exception('There was a problem deleting one of these question progress.');
				}
			}


		
			//Remove all the questions associated with this class
			if(!$this->_db->delete('question', array('class_id', '=', $classID))){
				throw new Exception('There was a problem deleting one of these questions.');
			}

			//Remove all the studetns associtated with this class
			if(!$this->_db->delete('student', array('class_id', '=', $classID))){
				throw new Exception('There was a problem deleting one of these students.');
			}

			//Remove the actual class
			if(!$this->_db->delete('class', array('class_id', '=', $classID))){
				throw new Exception('There was a problem deleting this class.');
			}

		}



		//Find class by its classname or id
		public function find($sclass = null) {

			if($sclass) {
				$field = (is_numeric($sclass)) ? 'class_id' : 'class_name';
				$data = $this->_db->get('class', array($field, '=', $sclass));



				if($data->count()) {
					$this->_data = $data->first();

					return true;
				}
			}
		}

		public function data() {
			return $this->_data;
		}
		

	}//End of class
?>