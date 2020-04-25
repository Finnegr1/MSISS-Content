<?php
session_start();
if(empty($_SESSION['logInSID']) OR empty($_SESSION['logInMID'])){
		header("Location: index.html");
		exit;
		}
?>

<?php
include('navigationBar.php');

?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>About Bagel Soc</title>
</head>

<body>

<div class="w3-row w3-padding-64" id="about">
    <div class="w3-col m6 w3-padding-large w3-hide-small">
     <img src="bagel2.jpg" class="w3-round w3-image w3-opacity-min" alt="Table Setting" width="300" height="375"/>
    </div>

    <div class="w3-col m6 w3-padding-large">
      <h1 class="w3-center">About Bagel Soc</h1>
      <br></br>
      <h5 class="w3-center">Founded in 2007</h5>
      <p class="w3-large">The TCD Bagel Society was founded in Trinity College by Mr. Tim Raisin, a passionate bagel enthusiast. His goal was to unite all Trinity students who shared his love for bagels.</p>      
      <p class="w3-large w3-text-grey w3-hide-medium">In the years since its foundation, the members of Bagel Soc have travelled internationally to get a taste of some of the best bagels in the world. The highlight of the Bagel Soc's calendar is the annual Bagel Ball, an event which should not be missed!</p>
    </div>
  </div>


</body>

</html>
