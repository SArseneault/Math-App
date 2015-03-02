<?php
	///////////Sanitize when going in an out of database///////////////

	
	function escape($string){
		return htmlentities($string, ENT_QUOTES, 'UTF-8');
	}

?>