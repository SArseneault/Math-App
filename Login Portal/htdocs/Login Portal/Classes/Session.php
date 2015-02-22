<?php

	class Session {
		public static function exists($name) {
			return (isset($_SESSION[$name])) ? true : false;
 		}
		public static function put($name, $value) {
			return $_SESSION[$name] = $value;
		}
	}

?>