<?php

require "Database.php";
	
	if ($_SERVER['REQUEST_METHOD']=="POST") {
		$response = array();
		$id_money = $_POST['id_money'];

			$delete = "DELETE FROM moneytransaction WHERE id_money ='$id_money'";
			if (mysqli_query($connect, $delete)) {
				# code...
				$response['value']=1;
				$response['message']="Berhasil di hapus";
				echo json_encode($response);
			} else {
				# code...
				$response['value']=0;
				$response['message']="Gagal di hapus";
				echo json_encode($response);
			}
		}
	
?> 