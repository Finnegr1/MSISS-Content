<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-ie" http-equiv="Content-Language" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Untitled 1</title>
</head>

<body>

<form action="" method="post" id="revenue">
	<table style="width: 56%">
		<tr>
			<td style="width: 213px">price</td>
			<td><input name="price" id="price" onchange="bal()" /></td>
		</tr>
		<tr>
			<td style="width: 213px">number of places</td>
			<td><input name="places" id="places" onchange="bal()" /></td>
		</tr>
		<tr>
			<td colspan="2"><div id="demo"></div>"</td>
		</tr>
	</table>
</form>

	<script>


function bal(mybal){
var theForm = document.forms["revenue"]
//Get a reference to the TextBox
var paid = theForm.elements["price"]
var paid2 = parseInt(paid.value)
var quantity = theForm.elements["places"]
var quantity2 = parseInt(quantity.value)
var bal = paid2*quantity2
msg = "Total revenue €"+bal
return msg
}
document.getElementById("demo").innerHTML = bal(); 
</script>

</body>

</html>
