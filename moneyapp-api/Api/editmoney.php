 <?php

require "Database.php";
	
	if ($_SERVER['REQUEST_METHOD']=="POST") {
		$response = array();
		$category = $_POST['category'];
		$quantity = $_POST['quantity'];
		$details = $_POST['details'];
		$id_money = $_POST['id_money'];

		$image = date('dmYHis').str_replace(" ","", basename($_FILES['image']['name']));
		$imagePath = "upload/".$image;
		move_uploaded_file($_FILES['image']['tmp_name'],$imagePath);

		

			$insert = "UPDATE moneytransaction SET image = '$image', category = '$category', quantity = '$quantity', details ='$details' WHERE id_money='$id_money'";
			if (mysqli_query($connect, $insert)) {
				# code...
				$response['value']=1;
				$response['message']="Berhasil di update";
				echo json_encode($response);
			} else {
				# code...
				$response['value']=0;
				$response['message']="Gagal di di update";
				echo json_encode($response);
			}
		}
?> 