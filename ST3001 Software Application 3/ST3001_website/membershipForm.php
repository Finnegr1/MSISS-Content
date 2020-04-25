<?php
	include('../website/navigationBar.php');
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-ie" http-equiv="Content-Language" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Untitled 1</title>
<style type="text/css">
.auto-style1 {
	margin-left: 278px;
}
.auto-style2 {
	margin-left: 109px;
}
.auto-style3 {
	margin-left: 251px;
}
</style>
</head>

<body style="height: 179px; width: 1003px">
<br />
<form action="membershipLink.php" method="post" style="width: 1001px; height: 238px">
	<table style="width: 38%" class="auto-style3">
		<tr>
			<td style="width: 248px; height: 26px;">Student ID</td>
			<td style="height: 26px"><input name="studentIDInput" style="width: 175px" type="text" required /></td>
		</tr>
		<tr>
			<td style="width: 248px">First Name</td>
			<td><input name="firstNameInput" style="width: 175px" type="text" required /></td>
		</tr>
		<tr>
			<td style="width: 248px">Last Name</td>
			<td><input name="lastNameInput" style="width: 175px" type="text"required  /></td>
		</tr>
		<tr>
			<td style="width: 248px">E-mail</td>
			<td><input name="emailInput" style="width: 175px" type="text" required /></td>
		</tr>
		<tr>
			<td style="width: 248px">Course</td>
			<td><input name="courseInput" style="width: 175px" type="text" required /></td>
		</tr>
		<tr>
			<td style="width: 248px">Committee member</td>
			<td>Yes <input name="committee" type="radio" value="1" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			No
			<input checked="checked" name="committee" type="radio" value="0" /></td>
		</tr>
	</table>

	<input class="auto-style1" name="registerButton" style="width: 115px" type="submit" value="Register" /><input class="auto-style2" name="Reset1" style="width: 111px" type="reset" value="reset" /></form>

</body>

</html>
