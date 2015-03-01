<?php
		echo "<p>Data processed...</br></br></>";

		//connect to database
		include 'connect.php';


		//Passed credentials from frontpage.html
		$UN = $_POST['username'];
		$PASS = $_POST['password'];


		$userName = $UN;
		$password = $PASS;
		//Grab teacher credentials
		//$userName = addslashes( $_REQUEST[$UN] );

		//Querys username and password
		//(Fetches an associative array) Gaining access to all columns of the table
		//Turns $image into an array and grabs the photo. (Specified we want the StudentPhoto column)
		/*$userName = mysql_query("SELECT * FROM teacher WHERE username=$UN");
		$userName = mysql_fetch_assoc($userName);
		$userName = $userName['username'];

		$password = mysql_query("SELECT * FROM teacher WHERE password=$PASS");
		$password = mysql_fetch_assoc($password);
		$password = $password['password'];


		echo "USERNAME: ", $userName," </br>";
		echo "PASSWORD: ", $password," </br>";*/



		//Attemps to push teacher credentials into the table     id name
		if ( !$insert = mysql_query("INSERT INTO teacher VALUES ('','','$userName','$password')") )
			echo "There was a problem uploading the image.";
		else
		{
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

		}


		//Defining a variable 
		//define('PI',3.1415926);
		//echo "The value of PI is: ", PI;
	?>
