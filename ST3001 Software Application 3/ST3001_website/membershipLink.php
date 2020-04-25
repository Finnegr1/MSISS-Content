<?php


include ("detail.php"); 


$studentIDInput = $_POST['studentIDInput'];
$firstNameInput = $_POST['firstNameInput'];
$lastNameInput = $_POST['lastNameInput'];
$emailInput = $_POST['emailInput'];
$courseInput = $_POST['courseInput'];
$committee = $_POST['committee'];

if($committee==1){
$query = "Select * from committeeMembers where studentID = ".$studentIDInput ;
$result2 = $db->query($query);
$num_results = mysqli_num_rows($result2);
if($num_results == 0){
			include('membershipForm.php');
			echo '<font color = "red">*You are not down as a valid committee member!*</font>';
			exit;
		}
}


$q  = "INSERT INTO memberships (";
$q .= "studentID_db, firstName_db, lastName_db,email_db,course_db,committee_db";
$q .= ") VALUES (";
$q .= "'$studentIDInput', '$firstNameInput', '$lastNameInput','$emailInput ','$courseInput','$committee')";

$result = $db->query($q);

$query = "Select * from memberships where studentID_db = ".$studentIDInput ;
$result2 = $db->query($query);
$row = mysqli_fetch_assoc($result2);
$memberID = $row['membershipID'];
session_start();
if($_SESSION['logInMID']==null){
$_SESSION['logInMID'] =  $memberID;
$_SESSION['logInSID'] = $studentIDInput;
$_SESSION['committee'] = $committee;
}

header('Location: home.php');
?>


