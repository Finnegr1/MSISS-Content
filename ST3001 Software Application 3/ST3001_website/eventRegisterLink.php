
<head>
<meta content="en-ie" http-equiv="Content-Language">
</head>

<?php
include ("detail.php"); 
session_start();
if($_POST['eventInfo']=='info'){
	$eventInfo = $_POST['eventRegistered'];
	include('EventRegisterForm.php');
	
	$query = "Select * from events where eventID = ".$eventInfo ;
	$result = $db->query($query);
	$row = mysqli_fetch_assoc($result);
	
	$cap = $row['eventCap_db'];
	$q = 'select sum(placesBooked) as sum from eventsRegistered where '.$row['eventID'].'= eventsRegistered.eventID';
	$result2 = $db->query($q);
	$row2 = mysqli_fetch_assoc($result2);
	$spaces = ($cap-$row2['sum']);
		
	
	echo 'Event name: '.$row['eventName_db'].'</br>';
	echo 'Date: '.$row['eventDate_db'].'</br>';
	echo 'Time: '.$row['eventTime_db'].'</br>';
	echo 'Location: '.$row['eventLocation_db'].'</br>';
	echo 'Event description: '.$row['eventDesc_db'].'</br>';
	echo 'Price per ticket: ' .$row['eventPrice_db'].'</br>';
	echo 'Spaces left: ' .$spaces.'</br>';

	exit; 
}
else{

	$eventID = $_POST['eventRegistered'];
	IF($eventID == "select"){
			include('EventRegisterForm.php');
			echo '<font color = "red">*Please select an event*</font>';
			exit;
		}
		IF($_POST['numPlaces'] <= 0){
			include('EventRegisterForm.php');
			echo '<font color = "red">*Please select a number of tickets*</font>';
			exit;
		
		}

		$query = "Select * from events where eventID = ".$eventInfo ;
		$result1 = $db->query($query);
		$row = mysqli_fetch_assoc($result1);
		$cap = $row['eventCap_db'];
		$q = 'select sum(placesBooked) as sum from eventsRegistered where '.$row['eventID'].'= eventsRegistered.eventID';
		$result2 = $db->query($q);
		$row2 = mysqli_fetch_assoc($result2);
		$sum = $row2['sum'];
		$sum2 = $sum + $_POST['numPlaces'];
		$total = $cap-$sum2;
		if(total<0){
			include('EventRegisterForm.php');
			echo '<font color = "red">*Unfortunately there are not enough spaces remaining for your booking.*</font>';
			exit;
		}


	$memberID = $_SESSION['logInMID'];
	$placesBooked = $_POST['numPlaces'];
	
	$q  = "INSERT INTO eventsRegistered (";
	$q .= "eventID,memberID,placesBooked";
	$q .= ") VALUES (";
	$q .= "'$eventID','$memberID','$placesBooked')";
	
	$result = $db->query($q);
	$_SESSION['eventID'] = $eventID;
	$_SESSION['placesBooked'] = $placesBooked;
	header("Location: registerSuccess.php");
}
?>

