<?php

	class Validate {
		private $_passed = false,
				$_errors = array(),
				$_db = null;

		public function __construct() {
			$this->_db = DB::getInstance();
		}

		public function check($source, $items = array()) {
			foreach($items as $item => $rules ) { //Loop through each item from the form
				foreach($rules as $rule => $rule_value) {
					//echo "{$item} {$rule} must be {$rule_value}<br>"; //Displays the item and rules from register.php

					$value = $source[$item];
					$item = escape($item); //Sanitizing each item

					//echo $value; //Displays value of each field

					if($rule == 'required' && empty($value)) {
						$this->addError("{$item} is required");
					} else if(!empty($value)) {
						switch($rule) {
							case 'min':
								if(strlen($value) < $rule_value) {
									$this->addError("{$item} must be a minimum of {$rule_value} characters.");
								}
							break;
							case 'max':
								if(strlen($value) > $rule_value) {
									$this->addError("{$item} must be a maximum of {$rule_value} characters.");
								}
							break;
							case 'matches':
								if($value != $source[$rule_value]) {
									$this->addError("{$rule_value} must match {$item}.");
								}
							break;
							case 'unique':
								$check = $this->_db->get($rule_value, array($item, '=', $value));
								if($check->count()) {
									$this->addError("{$item} already exists");
								}
							break;
							
						}

					}
				}
			}

			if(empty($this->_errors)) {
				$this->_passed = true;
			}

			return $this;
		}

		public function addError($error) {
			$this->_errors[] = $error;
		}

		public function errors() {
			return $this->_errors;
		}

		public function passed() {
			return $this->_passed;
		}

	}// End of class