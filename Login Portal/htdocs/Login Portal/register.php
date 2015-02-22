<?php
											/////Includes forms and validates form fields. Does NOT actually register the teachers/////
	require_once 'core/init.php';

	if( Input::exists() ){
		Input::get('username');
	}


?>




<form action="" method="post">
	<!-- Each field in a div wrapper -->
	<div class="field">
		<label for="username">Username</Label>
		<input type="text" name="username" id="username" value="" autocomplete="off">
	</div>

	<div class="password">
		<label for="password">Choose a password</label>
		<input type="password" name="password" id="password">
	</div>

	<div class="field">
		<label for="password_again">Re-enter your password</label>
		<input type="password" name="password_again" id="password_again">
	</div>

	<div class="field">
		<label for="name">Enter your name</label>
		<input type="text" name="name" value="<?php echo escape(Input::get('name')); ?>" id="name">
	</div>

	<input type="hidden" name="token" value="<?php echo Token::generate(); ?>">
	<input type="submit" value="Register">
</form>


