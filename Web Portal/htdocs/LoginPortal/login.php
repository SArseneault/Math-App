<?php
	require_once 'core/init.php';

	if(Input::exists()) {
		if(Token::check(Input::get('token'))) {
			$validate = new validate();
			$validation = $validate->check($_POST, array(
				'username' => array('required' => true),
				'password' => array('required' => true)
			));

			if($validation->passed()) {
				$user = new User();
				$login = $user->login(Input::get('username'), Input::get('password'));
				
				if($login) {
					echo 'You have successfully logged in!';
				} else {
					echo '<p>Sorry, logging in failed.</p>';
				}


			} else {
				foreach($validation->errors() as $error) {
					echo $error, '<br>';
				}
			}
		}
	}
?>




<!-- Add fields for login page-->
<form action="" method="post">
	<div class="field">
		<label for="username">Username</label>
		<input type="text" name="username" id="username" autocomplete="off">
	</div>

	<div class="field">
		<label for="password">Password</label>
		<input type="password" name="password" id="password" autcomplete="off">
	</div>


	<input type="hidden" name="token" value="<?php echo Token::generate(); ?>">
	<input type="submit" value="Log in">


</form>