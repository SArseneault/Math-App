<?php
									////Purpose of security//////
	class Hash {
		//Make a hash    NOTE: a salt it improves a securty of a hash by adding a randomly generated string of data to the end of password
		public static function make($string, $salt = '') {
			#hashing with sha256
			return hash('sha256', $string . $salt);
		}
		//Make a salt
		public static function salt($length) {
			return mcrypt_create_iv($length);
		}

		public static function unique() {
			return self::make(uniqid());
		}
	}	

	/* What hashing with salt does:
	'password' = '12345'
	'passwordFKHSDFKJHSDFKJH' = 999
	'passwordSFsdfdsofh9' = 555
	*/
?>