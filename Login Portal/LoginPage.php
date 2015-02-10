<?php
		echo "<p>Data processed...</br></br></>";

		$userName = "UserName";
		$password = "Password";

		$userName = $_POST['username'];
		$password = $_POST['password'];

	 	if($userName == "Sam" and $password == "sam123"){
			echo "Welcome ",$userName,"! </br>";
			echo "Your password is: ",$password."</br>";
			
			?>

			<html>
			<body>
				<form action="testphp.php" method="post">
						<table border="0">
						Go to photo upload page:
						<tr>
							<td colspan="2" align="center"><input type="submit" value="Go"/></td>
						</tr>

						</table>

			</body>
			</html>

			<?php
		}
		else
		{
			echo "You are not a registered user!";
		}

		
		//Defining a variable 
		//define('PI',3.1415926);
		//echo "The value of PI is: ", PI;
	?>
