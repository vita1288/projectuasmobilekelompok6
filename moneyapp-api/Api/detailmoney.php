<?php

require "Database.php";
	
	$response = array();

	$sql = mysqli_query($connect, "SELECT a.*, b.username FROM moneytransaction a LEFT JOIN user b on a.id_user = b.id_user ORDER BY a.id_user DESC");
	while ($a = mysqli_fetch_array($sql)) {
		# code...
		$b['id_money'] = $a['id_money'];
		$b['image'] = $a['image'];
		$b['category'] = $a['category'];
		$b['quantity'] = $a['quantity'];
		$b['details'] = $a['details'];
		$b['date'] = $a['date'];
		$b['id_user'] = $a['id_user'];
		$b['username'] = $a['username'];

		array_push($response, $b);
		
	}

	echo json_encode($response);
?>