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

		
		

	}//End of class
?>