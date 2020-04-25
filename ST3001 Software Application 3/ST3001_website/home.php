
<head>
<meta content="en-ie" http-equiv="Content-Language">
</head>

<?php
include ("navigationBar.php"); 
include('detail.php');
session_start();

$q = "Select * from memberships where studentID_db = ".$_SESSION['logInSID'];
$result = $db->query($q);
$row = mysqli_fetch_assoc($result);

 echo 'Welcome ' .$row['firstName_db'].' '.$row['lastName_db']. '<br/>Member ID: '.$_SESSION['logInMID']. '<br/>';
?>


<p>
<form action="logOut.php" method="post">
	<input name="logout" type="submit" value="Log out"></form>
Your Events:</p>
<?php
include('detail.php');
$q = 'select events.eventName_db, eventsRegistered.placesBooked from eventsRegistered 
	inner join events on eventsRegistered.eventID=events.eventID where eventsRegistered.memberID = '.$_SESSION['logInMID'];
$result = $db->query($q);
$num_results = mysqli_num_rows($result);
echo '<table border ="1" style="width: 25%">';
echo "<tr>";
   echo "<td>Event</td>";
    echo "<td>Places booked</td>";
    echo "</tr>";
while($row = mysqli_fetch_row($result))
{
    echo "<tr>";

    echo "<td>$row[0]</td>";
    echo "<td>$row[1]</td>";

    echo "</tr>";
}
echo '</table>';
?>

<p>
Events upcoming this month:

</p>

<p>&nbsp;</p>


<?php
$q2 = 'select * from events where year(curdate()) = year(eventDate_db) and month(curdate()) = month(eventDate_db)';
$result2 = $db->query($q2);
$num_results = mysqli_num_rows($result2);
echo '<table border ="1" style="width: 25%">';
echo "<tr>";
   echo "<td>Event</td>";
    echo "<td>Date</td>";
    echo "<td>Time</td>";

      echo "</tr>";
while($row = mysqli_fetch_row($result2))
{
    echo "<tr>";
    echo "<td>$row[0]</td>";
    echo "<td>$row[1]</td>";
    echo "<td>$row[2]</td>";
    echo "</tr>";
}
echo '</table>';


?>

