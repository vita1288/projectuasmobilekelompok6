<?php

require 'Database.php';
	
	if ($_SERVER['REQUEST_METHOD'] == "POST") {
		$response 	= array();
		$username 	= $_POST['username'];
		$email 		= $_POST['email'];
		$password 	= md5($_POST['password']);

		$check = "SELECT * FROM user WHERE email='$email'";
		$result = mysqli_fetch_array(mysqli_query($connect, $check));

		if (isset($result)) {
			# code...
			$response['value'] = 2;
			$response['message'] = "Email already register";
			echo json_encode($response);
		} else {
			$insert = "INSERT INTO user VALUE(NULL,'$username','$email','$password',NOW())";
			if (mysqli_query($connect,$insert)) {
				$response['value'] = 1;
				$response['message'] = "Register Success !";
				echo json_encode($response);
			} else {
				$response['value'] = 0;
				$response['message'] = "Register Failed";
				echo json_encode($response);
			}
		}
	}
?>
