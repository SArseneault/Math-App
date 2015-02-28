<?php
	class User {
		private $_db;

		public function __construct($user = null) {
			$this->_db = DB::getInstance();
		}

		//Ability to create a user
		public function create($fields) {
			if(!$this->_db->insert('teacher', $fields)) {
				throw new Exception('There was a problem creating an account.');

			}
		}
	}
?>