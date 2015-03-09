<?php
	class SClass {
		private $_db,
				$_data;

		//Default constructor connects to database
		public function __construct($teacher = null) {
			$this->_db = DB::getInstance();

			//Checking if the teacher exsits
			if($teacher) {
			
				$this->findTeacher($teacher);

			}

		}
	

		//Update user table
		public function update($fields = array(), $id = null) {

			//Update the currents users id if none is passed in
			if(!$id && $this->isLoggedIn()) {
				$id = $this->data()->id;
			}


			if(!$this->_db->update('teacher',$id, $fields)) {
				throw new exception('There was a problem updating.');
			}
		}

		//Ability to create a class
		public function create($fields = array()) {
			if(!$this->_db->insert('class', $fields)) {
				throw new Exception('There was a problem creating a class.');

			}
		}

		//Find teacher by their id
		public function findTeacher($teacher = null) {
			if($teacher) {
				$field = (is_numeric($teacher)) ? 'class_id' : 'class_name';
				$data = $this->_db->get('class', array($field, '=', $teacher));

				if($data->count()) {
					$this->_data = $data->first();
					return true;
				}
			}
		}

		//Ability to login to data base
		public function login($classname= null, $password = null) {

				//$sclass== 1 if $classname is found in the database
				$sclass = $this->find($classname);
			


			//If the user exists
			if($user) {
				
					//If the password matches the hashed/salted password
					$trimHash = Hash::make($password, $this->data()->salt);
					$trimHash = substr ($trimHash ,0,-14);
					if($this->data()->password === $trimHash){
					
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
			return false;


		}

		

		public function exists(){
			return (!empty($this->_data)) ? true : false;
		}

		public function logout() {

			//Delete current login id
			$this->_db->delete('teacher_session', array('teacher_id', '=', $this->data()->id));

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