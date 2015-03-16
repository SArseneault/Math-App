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