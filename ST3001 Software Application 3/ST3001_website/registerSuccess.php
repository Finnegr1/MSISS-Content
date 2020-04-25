<?php
include('navigationBar.php');
session_start();
$eventInfo = $_POST['eventRegistered'];
	include('detail.php');
	$query = "Select * from events where eventID = ".$_SESSION['eventID'];
	$result = $db->query($query);
	$row = mysqli_fetch_assoc($result);
	
	echo 'You have booked '.$_SESSION['placesBooked'].' place(s) for ';
	echo $row['eventName_db'].'</br>';
	echo 'Date: '.$row['eventDate_db'].'</br>';
	echo 'Time: '.$row['eventTime_db'].'</br>';
	echo 'Location: '.$row['eventLocation_db'].'</br>';
	exit; 
?>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Untitled 1</title>
</head>

<body>

<p>You have successfully booked </p>

</body>

</html>
