<?php
	class studentToken {
		public static function generate() {
			return Session::put(Config::get('studentsession/token_name'), md5(uniqid()));
		}

		//Pass in a token to check if the token has been applied to the session
		public static function check($token) { 
			$tokenName = Config::get('studentsession/token_name');

			if(Session::exists($tokenName) && $token === Session::get($tokenName)) {
				return true;
			}

			return false;
		}

		public static function delete($token) { 
			$tokenName = Config::get('studentsession/token_name');

			if(Session::exists($tokenName) && $token === Session::get($tokenName)) {
				Session::delete($tokenName);
				return true;
			}

			return false;
		}

	}
?>