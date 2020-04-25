<?php
include ("detail.php"); 



$committeeMemberStudentID = $_POST['committeeMemberAdd'];

$q  = "INSERT INTO committeeMembers (";
$q .= "studentNumber";
$q .= ") VALUES (";
$q .= "'$committeeMemberStudentID')";

$result = $db->query($q);
header("Location:navigationBar.php");
echo 'success!';
?>
