<?php
session_start();
if(empty($_SESSION['logInSID']) OR empty($_SESSION['logInMID'])){
		echo 'You have not entered login details, please try again.';
		header("Location: index.html");
		exit;
		}
?>
<?php
	include('detail.php');
	$query = "SELECT * FROM memberships where membershipID = " .$_SESSION['logInMID'];
	$result = $db->query($query);
	$row = mysqli_fetch_assoc($result);


?>






<?php
include('navigationBar.php');
?>
<?php
if($row['committee_db'] == 1){
echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-ie" http-equiv="Content-Language" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Name of event</title>
<style type="text/css">
.auto-style1 {
	text-align: left;
}
.auto-style3 {
	margin-left: 34px;
}
.auto-style4 {
	text-align: center;
}
</style>
</head>

<body>

<form   action="createEventLink.php" method="post" id="createEvent">
	<table style="width: 40%">
		<tr>
			<td style="width: 130px; height: 50px;">Event Name:</td>
			<td style="height: 50px">
			<input name="eventName" type="text" style="width: 100%" required/></td>
		</tr>
		<tr>
			<td style="width: 130px">Date:</td>
			<td><input name="eventDate" type="date" style="width: 100%" required/></td>
		</tr>
		<tr>
			<td style="width: 130px">Time:</td>
			<td><input name="eventTime" type="time" style="width: 100%" required/></td>
		</tr>
		<tr>
			<td style="width: 130px">Location:</td>
			<td><input name="eventLocation" type="text" style="width: 100%" required/></td>
		</tr>
		<tr>
			<td style="width: 128px" class="auto-style1">Event Description:</td>
			<td>
			<input name="eventDesc" style="width: 100%" type="text" /></td>
		</tr>
		<tr>
			<td style="width: 130px">Event Capacity:</td>
			<td><input name="eventCap" id="cap" style="width: 100%" onchange="total()" required /></td>
		</tr>
		<tr>
			<td style="width: 130px">Price per person:</td>
			<td><input name="eventPrice" id="price" style="width: 100%" onchange="total()" required /></td>
		</tr>
		<tr>
			<td style="width: 130px">Total </td>
			<td><div id="total"></div></td>
		</tr>
		<tr>
			<td style="width: 130px"><input class="auto-style3" name="createEvent" type="submit" value="Create"  /></td>
			<td class="auto-style4">
			<input name="Reset1" type="reset" value="reset"/>&nbsp;</td>
		</tr>
	</table>
	</form>
	
	
	
<script>
function bal(mybal){
var theForm = document.forms["createEvent"]
//Get a reference to the TextBox
var cap = theForm.elements["cap"]
var cap2 = parseInt(cap.value)
var price = theForm.elements["price"]
var price2 = parseInt(price.value)
var total = cap2*price2
msg = "€"+total
return cap2
}
document.getElementById("total").innerHTML = bal(); 
	 </script>









</body>

</html>';
}
else
{
echo 'You are not a valid committee member! Please check your details.';
}
?>

