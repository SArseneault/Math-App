<?php
	//////////////////This will be a database wrapper/////////////////////

	class DB {

		private static $_instance = null;
		private $_pdo,			    //Storing instantiated pdo object
				$_query,			//Storing last query
				$_error = false,	//Storing error from query
				$_results,			//Storing results sets
				$_count = 0;		//How many elements are in results
		
		//Conecting to database
		private function __construct() {
			echo "Trying...</br>";
			try {
				$this->_pdo = new PDO('mysql:host=' . Config::get('mysql/host') . ';dbname=' . Config::get('mysql/db'), Config::get('mysql/username'), Config::get('mysql/password'));
				echo "Connected :)";
			} catch (PDOException $e) { //Catching the PDO error
				echo "Not Connected :/";
				die($e->getMessage());
			}
		}

		//Checks if we already instantiated our object
		public static function getInstance() {
			if( !isset(self::$_instance) ) {

				self::$_instance = new DB();
			}
			
			return self::$_instance;
		}

		//Public function to send queries
		public function query($sql, $params = array()){
			$this->_error = false; //Reset the error back to false 

			if($this->_query = $this->_pdo->prepare($sql)){ //Storing and checking if the query is good
				//Checking if the parameters exist
				$x = 1;
				if(count($params)) {
					foreach($params as $param) {
						$this->_query->bindValue($x, $param); //bind the value at x to paramter defined by array('param')
						$x++;
					}
				}
				if($this->_query->execute()){//If the query executed, then store the result set
					$this->_results = $this->_query->fetchALL(PDO::FETCH_OBJ);
					$this->_count = $this->_query->rowCount();
				}
				else{ //Store the error
					$this->_error = true;
					//echo 'Query did not execute';
				}
			}
			return $this;
		}

		//Action will be used to build the get and delete functions for querying the DB
		//EXAMPLE:			   SELECT *     teachers    [username, =, ALex]
		public function action($action, $table, $where = array() ){
			if(count($where) === 3){ //3 because Field, Operator, and Value will be passed in
					$operators = array('=', '>', '<', '>=', '<=');

					$field 		= $where[0];
					$operator 	= $where[1];
					$value 		= $where[2];

					if(in_array($operator, $operators)) {
					  //EXAMPLE:
					  //$sql = "SELECT * FROM teacher WHERE username = 'Alex"
						$sql = "{$action} FROM {$table} WHERE {$field} {$operator} ?";

						if( !$this->query($sql, array($value)) ) {//Perform the query
							return $this;
						}
					}
			}
			return false;
		}

		//Grabbing from table in database. EX: teachers [username, =, ALex]
		public function get($table, $where) {
			return $this->action('SELECT *', $table, $where);
		}

		//Deleting from table in database
		public function delete($table, $where) {
			return $this->action('DELETE *', $table, $where);
		}

		public function insert($table, $fields = array()) {
			if(count($fields)) {
				$keys = array_keys($fields);
				$values = '';
				$x = 1;

				foreach($fields as $field) {
					$values .= '?';

					if($x < count($fields)) {
						$values .= ', ';
					}
					$x++;
				}


				$sql = "INSERT INTO teacher (`" . implode('` , `', $keys) . "`) VALUES ({$values})";	

				if(!$this->query($sql, $fields)->error()) {
					return true;
				}

				//echo "</br>,$sql;		
			}	
			return false;
		}

		//Updating the database
		public function update($table, $id, $fields){
			$set = '';
			$x = 1;

			foreach($fields as $name => $value) {
				$set .= "{$name} = ?";
				if($x < count($fields)) {
					$set .= ', ';
				}
				$x++;
			}
			//$sql = "UPDATE teacher SET password = 'newpass' WHERE id = 3";
			$sql = "UPDATE {$table} SET {$set} WHERE id = {$id}";
			
			//echo $sql; //display the query

			if(!$this->query($sql, $fields)->error()) { //If the query works return true
				return true;
			}

			return false;
		}

		//Return the result set of the query
		public function results() {
			return $this->_results;
		}

		//Returning the first result of the query
		public function first() {
			return $this->results()[0];
		}


		//Return the error
		public function error() {
			return $this->_error;
		}

		public function count() {
			return $this->_count;
		}


	}//End of class



?>