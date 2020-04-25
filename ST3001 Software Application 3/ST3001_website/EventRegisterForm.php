<?php
session_start();
if(empty($_SESSION['logInSID']) OR empty($_SESSION['logInMID'])){
		header("Location: index.html");
		exit;
		}
?>

<?php
include('../webnoedit/navigationBar.php');

?>

<?php
include ('detail.php');
$query = "select * from events where eventDate_db >= curdate()";
$eventsTable = $db->query($query);
$num_results = mysqli_num_rows($eventsTable);
?>

<?php

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Register Event</title>
<style type="text/css">
.auto-style1 {
	margin-left: 0px;
}
.auto-style2 {
	text-align: center;
}
</style>
</head>

<body>
<br />
<form action="eventRegisterLink.php" method="post" id="events" style="height: 97px; width: 851px">
	<div class="auto-style2">
	<table style="width: 100%">
		<tr>
			<td style="width: 297px; height: 38px;">Select an event:</td>
			<td style="width: 618px; height: 38px;" class="auto-style2">
			<select name="eventRegistered" style="width: 399px" class="auto-style1">
			<option value= "select">--Select an Event--</option>
			<?php
				for($i = 0;$i<$num_results;$i++)
				{
					$row = mysqli_fetch_assoc($eventsTable);
					$cap = $row['eventCap_db'];
					$q = 'select sum(placesBooked) as sum from eventsRegistered where '.$row['eventID'].'= eventsRegistered.eventID';
					$result2 = $db->query($q);
					$row2 = mysqli_fetch_assoc($result2);
					$sum = $row2['sum'];
					if(!($sum>=$cap)){
						echo '<<option value ="'.$row['eventID'].'">'.$row['eventName_db'].'</option>';
					}
					else
					{
						echo '<<option value ="'.$row['eventID'].'">'.$row['eventName_db'].'(sold out)</option>';
					}
				}
			?>
			</select> <input name="eventInfo" type="submit" value="info"/> </td>
		</tr>
		<tr>
			<td style="width: 297px">Number of places:</td>
			<td style="width: 618px" class="auto-style2">
			<input name="numPlaces" id="numPlaces" style="width: 31px" type="text" onchange="total()"/></td>
		</tr>
		<tr>
			<td class="auto-style2" colspan="2">
	<input class="auto-style1" name="registerEvent" style="width: 177px" type="submit" value="Register" /></td>
		</tr>
	</table>
	<br />
	</div>
</form>
<?php
include('detail.php');
	$query = "Select * from events where eventID = ".$_SESSION['eventID'];
	$result = $db->query($query);
	$row = mysqli_fetch_assoc($result);
	
	
?>

</body>

</html>

