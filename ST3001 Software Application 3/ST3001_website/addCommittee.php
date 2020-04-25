
<?php
include('navigationBar.php')
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-ie" http-equiv="Content-Language" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Add Committee Member</title>
<style type="text/css">
.auto-style1 {
	text-align: left;
}
.auto-style2 {
	text-align: center;
}
</style>
</head>

<body>

<p>
&nbsp;</p>
<form action="committeeAddDB.php" method="post">
	<div class="auto-style1">
<table style="width: 26%">
	<tr>
		<td style="width: 209px">Student ID</td>
		<td>
		
			<input name="committeeMemberAdd" type="text" style="width: 160px" />
		</td>
	</tr>
	<tr>
		<td class="auto-style2" colspan="2">
<input name="Submit1" type="submit" value="submit" /></td>
	</tr>
</table>
&nbsp;</div>
</form>

<p>&nbsp;</p>


</body>

</html>
