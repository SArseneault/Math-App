<?php
	class Token {
		public static function generate() {
			return Session::put(Config::get('session/token_name'), md5(uniqid()));
		}

		//Checking the token in the form with the token in the session
		// If they match then delete it and return true
		public static function check($token) { 
			$tokenName = Config::get('session/token_name');

			if(Session::exists($tokenName) && $token === Session::get($tokenName)) {
				Session::delete($tokenName);
				return true;
			}

			return false;
		}
	}
?>