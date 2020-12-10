<?php

require "Database.php";
	
	if ($_SERVER['REQUEST_METHOD']=="POST") {
		$response = array();
		$category = $_POST['category'];
		$quantity = $_POST['quantity'];
		$details = $_POST['details'];
		$details = $_POST['details'];
		$id_user = $_POST['id_user'];

		$image = date('dmYHis').str_replace(" ","", basename($_FILES['image']['name']));
		$imagePath = "upload/".$image;
		move_uploaded_file($_FILES['image']['tmp_name'],$imagePath);



			$insert = "INSERT INTO moneytransaction VALUE(NULL,'$image', '$category','$quantity','$details',NOW(),'$id_user')";
			if (mysqli_query($connect, $insert)) {
				# code...
				$response['value']=1;
				$response['message']="Berhasil di tambahkan";
				echo json_encode($response);
			} else {
				# code...
				$response['value']=0;
				$response['message']="Gagal di ditambahkan";
				echo json_encode($response);
			}
		}
	
?> 