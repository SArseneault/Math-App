<?php
											/////Includes forms and validates form fields. Does NOT actually register the teachers/////
	require_once 'core/init.php';

	//var_dump(Token::check(Input::get('token')));

	//Grabbing data from the forms
	if( Input::exists() ){
		if(Token::check(Input::get('token'))) {

			$validate = new Validate();
			$validation = $validate->check($_POST, array(
				'username' => array(
					'required' => true,
					'min' => 2,
					'max' => 20,
					'unique' => 'teacher' //Unique to the teacher table
				),
				'password' => array(
					'required' => true,
					'min' => 6
				),
				'password_again' => array(
					'required' => true,
					'matches' => 'password'
				),
				'name' => array(
					'required' => true,
					'min' => 2,
					'max' => 50
				)
			));

			if($validation->passed()) {
					Session::flash('success', 'You registered successfull!');
					header('Location: index.php');
				} else {
					foreach($validation->errors() as $error) {
						echo $error, '<br>';
					}
				}
		}
	}


?>




<form action="" method="post">
	<!-- Each field in a div wrapper -->
	<div class="field">
		<label for="username">Username</Label>
		<input type="text" name="username" id="username" value="<?php echo escape(Input::get('username')); ?>" autocomplete="off">
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

	<!-- Grabbing token from form-->
	<input type="hidden" name="token" value="<?php echo Token::generate(); ?>">
	<input type="submit" value="Register">
</form>


