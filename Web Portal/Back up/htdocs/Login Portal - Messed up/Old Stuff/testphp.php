<html>

	<head>
		<title>Information Gathered</title>
	</head>

	<body>


	<form action="testphp.php" method="POST" enctype="multipart/form-data">
		File:
		<input type="file" name="image"> <input type="submit" value="Upload">
	</form>
	
	<?php


		//connect to database
		include 'connect.php';

		//file properites
		//You can use echo to show the file name
		$file = $_FILES['image']['tmp_name'];


		if ( !isset($file) )
			echo "Please select an image.";
		else
		{
			$image = addslashes(file_get_contents($_FILES['image']['tmp_name']));
			$image_name = addslashes($_FILES['image']['name']);
			$image_size = getimagesize($_FILES['image']['tmp_name']);


			//Checks if the file is an image
			//If the file is an image then push it into the data base
			if ($image_size==FALSE)
				echo "That's not an image.";
			else
			{
				
				//Attemps to push image into the table                     snap_ID   name   image
				if ( !$insert = mysql_query("INSERT INTO snapshot VALUES ('','$image_name','$image')") )
					echo "There was a problem uploading the image.";
				else
				{
					$lastid = mysql_insert_id();
		
					echo "Image uploaded.
					<p /> Your Image:
					<p /><img src=getImage.php?id=$lastid>";
				}

			}

		}

	?>
	<form action="frontpage.html" method="POST" enctype="multipart/form-data">
		Go Back to Front Page
		<input type="submit" value="Go">
	</form>


	</body>
</html>
