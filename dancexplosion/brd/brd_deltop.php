<?php


if($action == "form"):


?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> Request Topic Deletion </TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=windows-874">
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<link rel=stylesheet href="scroll.css" type="text/css">
<style>
.input {  font: 15px ms sans serif; color: #400000;
font-family : ms sans serif ; font-size :2;
BORDER-BOTTOM: #ff9900 solid thin;
BORDER-LEFT: #ff9900 solid thin;
BORDER-RIGHT:#ff9900 solid thin;
BORDER-TOP: #ff9900 solid thin; 
border-width : 1 ;
width : 350;
background: #ffffff }
</style>

<BODY BGCOLOR="#F5f5f5">

<img src="deltop.gif">

<form method=post action="brd_deltop.php?action=send" name="boardform">

<center><table width="85%" border="0" cellspacing="1" cellpadding="0">
  <tr> 
    <td width="70" valign="top"><font color="#FF9900" size="2" face="Verdana">numtopic</font></td>
    <td width="15" valign="top"><font color="#FF9900" size="2" face="Verdana">:</font></td>
    <td><input type="text" name="numtopic" class=input size=5></td>
  </tr>
  <tr> 
    <td width="70" valign="top"><font color="#FF9900" size="2" face="Verdana">name</font></td>
    <td width="15" valign="top"><font color="#FF9900" size="2" face="Verdana">:</font></td>
    <td><input type="text" name="name" class=input></td>
  </tr>
  <tr> 
    <td width="70" valign="top"><font color="#FF9900" size="2" face="Verdana">e-mail</font></td>
    <td width="15" valign="top"><font color="#FF9900" size="2" face="Verdana">:</font></td>
    <td><input type="text" name="email" class=input></td>
  </tr>
  <tr> 
    <td valign="top"><font color="#FF9900" size="2" face="Verdana">reason</font></td>
    <td width="15" valign="top"><font color="#FF9900" size="2" face="Verdana">:</font></td>
    <td><textarea name="reason" rows="7" class="input"></textarea></td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
	  <td></td>

<SCRIPT LANGUAGE="JavaScript">
<!--
	var checkclick = 0;
//-->
</SCRIPT>

	  <td><img src="submit.gif" width="134" height="19" onClick="if(checkclick==0){var chcknum=0; if(numtopic.value ==''){chcknum++;}if(reason.value==''){chcknum++;}if(chcknum == 0){checkclick++;boardform.submit();}else{alert('คุณกรอกข้อมูลไม่ครบครับ');checkclick=0;} }">&nbsp;<img src="clear.gif" width="134" height="19" onclick="boardform.reset()"></td>
  </tr>
</table>
</center></form>

</BODY>
</HTML>

<?php

endif;

if($action == "send"){
	$name = stripslashes($name);
	$email = stripslashes($email);
	$numtopic = stripslashes($numtopic);
	$reason = stripslashes($reason);

	$emailto = "muu_acspsx@yahoo.ie";
	$subject = "delete webboard topic : $numtopic";
	$header = "From : $email \n";
	$message = "delete webboard topic\n\n";
	$message .="name  =  $name\n";
	$message .= "email = $email \n";
	$message .= "numtopic = $numtopic \n";
	$message .= "reason = $reason \n";
	if(	mail($emailto,$subject,$message,$header)){
	echo "<html><body onload=\"alert('ส่งข้อมูลเรียบร้อยแล้วครับ ขอบคุณที่ใช้บริการครับ');window.location='brd_index.html'\"></body></html>";
	}
	else{
	echo "<html><body onload=\"alert('ส่งข้อมูลไม่สำเร็จครับ กรุณาลองส่งใหม่');window.location='brd_deltop.php?action=form'\"></body></html>";
	}
}


?>