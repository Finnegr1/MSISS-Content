

<!DOCTYPE html>
<html>
<title>Bagel Society Homepage</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="w3.css">
<style>
body {font-family: "Times New Roman", Georgia, Serif;}
h1,h2,h3,h4,h5,h6 {
    font-family: "Playfair Display";
    letter-spacing: 5px;
}
</style>
<body>


<!-- Navbar (sit on top) -->
<div class="w3-top">
  <div class="w3-bar w3-white w3-padding w3-card" style="letter-spacing:4px;">
    <a href="home.php" class="w3-bar-item w3-button">TCD Bagel Society</a>
    <!-- Right-sided navbar links. Hide them on small screens -->
    <div class="w3-right w3-hide-small">
      <a href="membershipForm.php" class="w3-bar-item w3-button">Register for Bagel Soc</a>
      <a href="EventRegisterForm.php" class="w3-bar-item w3-button">Register for Event</a>
      <a href="createEvent.php" class="w3-bar-item w3-button">Create Event</a>
  
  <?php session_start();
  if($_SESSION['committee']==1){
  		echo  '<a href="databases.php" class="w3-bar-item w3-button">Databases</a>';
      	echo  '<a href="addCommittee.php" class="w3-bar-item w3-button">Committee</a>';

  	}
 ?>
 
      <a href="About.php" class="w3-bar-item w3-button">About</a>
	</div>
  </div>
</div>

<header class="w3-display-container w3-content w3-wide" style="max-width:1200px;min-width:375px" id="home">
  <img class="w3-image" src="bagel3.jpg" alt="Bagel Breakfast" width="800" height="440">
  <div class="w3-display-bottomleft w3-padding-large w3-opacity">
    <h1 class="w3-xxlarge">Bagel Soc</h1>
  </div>
</header>

</body>
</html>
