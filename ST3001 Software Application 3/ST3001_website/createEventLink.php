
<?php

include ("detail.php"); 
session_start();
echo  $_SESSION['logInMID'];


$eventName = $_POST['eventName'];
$eventDate = $_POST['eventDate'];
$eventTime = $_POST['eventTime'];
$eventLocation = $_POST['eventLocation'];
$eventDesc = $_POST['eventDesc'];
$eventCap = $_POST['eventCap'];
$eventPrice = $_POST['eventPrice'];
$creatorID = $_SESSION['logInMID'];

$q  = "INSERT INTO events (";
$q .= "eventName_db, eventDate_db, eventTime_db,eventLocation_db,eventDesc_db,eventCap_db,eventPrice_db,creatorID ";
$q .= ") VALUES (";
$q .= "'$eventName ', '$eventDate ', '$eventTime ','$eventLocation ','$eventDesc ','$eventCap ','$eventPrice','$creatorID')";

$result = $db->query($q);
header("Location: home.php");

?>

