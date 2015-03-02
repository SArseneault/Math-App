<?php
	class User {
		private $_db,
				$_data,
				$_sessionName;

		//Default constructor connects to database
		public function __construct($user = null) {
			$this->_db = DB::getInstance();
			$this->_sessionName = Config::get('session/session_name');
		}

		//Ability to create a user
		public function create($fields = array()) {
			if(!$this->_db->insert('teacher', $fields)) {
				throw new Exception('There was a problem creating an account.');

			}
		}

		//Find user by its id
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
		public function login($username = null, $password = null) {

			//$user == 1 if $username is found in the database
			$user = $this->find($username);
			
			//If the user exists
			if($user) {
				
				//If the password matches the hashed/salted password
				$trimHash = Hash::make($password, $this->data()->salt);
				$trimHash = substr ($trimHash ,0,-14);
				if($this->data()->password === $trimHash){
				
					Session::put($this->_sessionName, $this->data()->id);
					return true;
				}
				//if($this->data()->password === Hash::make($password, $this->data()->salt)) 
			}

			return false;
		}

		public function data() {
			return $this->_data;
		}

	}//End of class
?>