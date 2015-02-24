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
					$user = new User();

					$salt = Hash::salt(32);


					try{
						$user->create(array(
							'name' => Input::get('name'),
							'username' => Input::get('username'),
							'password' => Hash::make(Input::get('password'), $salt),
							'salt' => $salt,
							'joined' => date('Y-m-d H:i:s')
						));

						//Flash message and redirect
						Session::flash('success', 'You have been registered and can now login');
						//Redirect::to("index.php");

					} catch(Exception $e) {
						die($e->getMessage()); //Eventaully redirect user to a error page
					}
					
					
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
		<input type="text" name="username" id="username" value="<?php echo escape(Input::get('username')); ?>">
	</div>

	<div class="password">
		<label for="password">Choose a password</label>
		<input type="password" name="password" id="password" autocomplete="off">
	</div>

	<div class="field">
		<label for="password_again">Re-enter your password</label>
		<input type="password" name="password_again" id="password_again" autocomplete="off">
	</div>

	<div class="field">
		<label for="name">Enter your name</label>
		<input type="text" name="name" value="<?php echo escape(Input::get('name')); ?>" id="name">
	</div>

	<!-- Grabbing token from form-->
	<input type="hidden" name="token" value="<?php echo Token::generate(); ?>">
	<input type="submit" value="Register">
</form>


