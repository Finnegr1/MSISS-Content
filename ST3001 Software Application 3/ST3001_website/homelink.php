<?php
include ('detail.php');
	session_start();
	$query = "SELECT * FROM memberships where membershipID = " .$_POST['membershipID'];
	$result = $db->query($query);
	$num_results = mysqli_num_rows($result);
	
	if($num_results == 0){
		
		include("signIn.php");
		echo '<font color = "red">*Member ID not found, please try again. Or <a href="membershipForm.php">Register as a New Member.</a>*</font>';
		exit;
	}
	
	$row = mysqli_fetch_assoc($result);
	$studentID_db = $row['studentID_db'];
	
	if(!($studentID_db == $_POST['studentID'])){
		
		include("signIn.php");
		echo '<font color = "red">*Student number not found, please try again. Or <a href="membershipForm.php">register as a new member.</a>*</font>';
		exit;
	}

	
	
	$_SESSION['logInMID'] =  $_POST['membershipID'];
	$_SESSION['logInSID'] = $_POST['studentID'];
	$_SESSION['committee'] = $row['committee_db'];
		
		if(empty($_SESSION['logInSID']) OR empty($_SESSION['logInMID'])){
			include("signIn.php");
			echo '<font color = "red">*Some fields are missing, please re-enter your info and try again.*</font>';
			exit;
		}
		else{
			header("Location: home.php");
			echo '';
		}
?>
