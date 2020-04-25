<?php

$host = "localhost";

$database = "finnegr1_db";

$user = "finnegr1";

$password = "eeT9reNg";




@ $db = mysqli_connect($host, $user, $password, $database);

$db->select_db($database);


if (mysqli_connect_errno())
{
echo 'Error connecting to the db.';
exit;
}


?>


