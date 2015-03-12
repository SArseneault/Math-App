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
			if(!$this->_db->insert('level', $fields)) {
				throw new Exception('There was a problem creating a level.');
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
				
					//Trim the hash by 14 before checking
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