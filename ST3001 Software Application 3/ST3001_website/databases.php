<?php
 include('navigationBar.php');
include('detail.php');
?>
<p>Members Table:</p>
<?php
$q2 = 'select * from memberships';
$result2 = $db->query($q2);
$num_results = mysqli_num_rows($result2);
echo '<table border ="1" style="width: 30%">';
echo "<tr>";
    echo "<td>Membership ID</td>";
    echo "<td>Student ID</td>";
    echo "<td>First Name</td>";
	echo "<td>Last name</td>";
	echo "<td>E-mail</td>";
	echo "<td>Course</td>";
	echo "<td>Committee member</td>";


      echo "</tr>";
while($row = mysqli_fetch_row($result2))
{
    echo "<tr>";
    echo "<td>$row[0]</td>";
    echo "<td>$row[1]</td>";
    echo "<td>$row[2]</td>";
    echo "<td>$row[3]</td>";
    echo "<td>$row[4]</td>";
    echo "<td>$row[5]</td>";
    if($row[6] == 1){
    	echo "<td>yes</td>";
    }
    else{
    	echo "<td>no</td>";
    }
    echo "</tr>";
}
echo '</table>';
?>

<p>Events Table:</p>

<?php
$q2 = 'select * from events';
$result2 = $db->query($q2);
$num_results = mysqli_num_rows($result2);
echo '<table border ="1" style="width: 50%">';
echo "<tr>";
    echo "<td>Event ID</td>";
    echo "<td>Event Name</td>";
    echo "<td>Date</td>";
	echo "<td>Time</td>";
	echo "<td>Location</td>";
	echo "<td>Description</td>";
	echo "<td>Capacity</td>";
	echo "<td>Price</td>";
	echo "<td>Creators ID</td>";


      echo "</tr>";
while($row = mysqli_fetch_row($result2))
{
    echo "<tr>";
    echo "<td>$row[0]</td>";
    echo "<td>$row[1]</td>";
    echo "<td>$row[2]</td>";
    echo "<td>$row[3]</td>";
    echo "<td>$row[4]</td>";
    echo "<td>$row[5]</td>";
    echo "<td>$row[6]</td>";
    echo "<td>$row[7]</td>";
	echo "<td>$row[8]</td>";


        echo "</tr>";
}
echo '</table>';
?>

<p>Events Registered Table:</p>

<?php
$q2 = 'select * from eventsRegistered';
$result2 = $db->query($q2);
$num_results = mysqli_num_rows($result2);
echo '<table border ="1" style="width: 25%">';
echo "<tr>";
    echo "<td>Event Register ID</td>";
    echo "<td>Event ID</td>";
    echo "<td>Member ID</td>";
	echo "<td>Places booked</td>";

      echo "</tr>";
while($row = mysqli_fetch_row($result2))
{
    echo "<tr>";
    echo "<td>$row[0]</td>";
    echo "<td>$row[1]</td>";
    echo "<td>$row[2]</td>";
    echo "<td>$row[3]</td>";


        echo "</tr>";
}
echo '</table>';
?>

<p>Events Registered Table:</p>

<?php
$q2 = 'select * from committeeMembers';
$result2 = $db->query($q2);
$num_results = mysqli_num_rows($result2);
echo '<table border ="1" style="width: 25%">';
echo "<tr>";
    echo "<td>Student ID</td>";
    echo "<td>Commitee ID</td>";

      echo "</tr>";
while($row = mysqli_fetch_row($result2))
{
    echo "<tr>";
    echo "<td>$row[0]</td>";
    echo "<td>$row[1]</td>";


        echo "</tr>";
}
echo '</table>';
?>



