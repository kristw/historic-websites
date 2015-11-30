<?php 

	$stud = file("webboard/$number.txt");
	$disp = split("\t",$stud[0]);
	$topic = $disp[0];
	$name= $disp[1];
	$comment = $disp[3];
	$dattime = split(",",$disp[2]);
	$time = $dattime[0];
	$time = chop($time);
	$date = $dattime[1];
	$pict = $disp[4];
	$email = $disp[6];
	$pip = $disp[5];

	$count = file("webboard/num$number.txt");
	$count[0] = eregi_replace("\n","",$count[0]);
	$count[1] = eregi_replace("\n","",$count[1]);
	$count[2] = eregi_replace("\n","",$count[2]);
	$count[0]++;
	$fa = fopen("webboard/num$number.txt","w");
	$tocount = $count[0]."\n".$count[1]."\n".$count[2];
	fputs($fa,$tocount);
	fclose($fa);

?>

<html>
<head>
<title>
	SmileY HomE Webboard - 
	<?php 
	// แสดง title เป็นชื่อ topic
	echo $topic; 
	?>

</title>
<meta http-equiv="Content-Type" content="text/html; charset=windows-874">
<style type="text/css">
<!--
.style6 {color: #FF3D86}
-->
</style>
</head>
<style>


body {  margin: 0px  0px; padding: 0px  0px;background-attachment: fixed; background-repeat : repeat-y ;background-position : right ;}

</style>
<style type="text/css">
<!--
A:link, A:visited { text-decoration: none; color:saddlebrown}
A:hover { text-decoration: none; color : #0099ff}

.mhand { cursor:hand;}
-->
</style>
<style>
.input {  font: 15px ms sans serif; color: #FF3D86;
font-family : ms sans serif ; font-size :2;
BORDER-BOTTOM: #FF3D86 solid thin;
BORDER-LEFT: #FF3D86 solid thin;
BORDER-RIGHT:#FF3D86 solid thin;
BORDER-TOP: #FF3D86 solid thin; 
border-width : 1 ;
width : 350;
background: #ffffff }
.input1 {	font: 15px ms sans serif;
	color: #FF3D86;
	font-family : ms sans serif;
	font-size :2;
	width : 350;
	background: #ffffff;
	border: 1 solid #FF3D86;
}
.style4 {	font-size: xx-small;
	color: #3399FF;
}
.unnamed1 {	font-size: 8pt;
}
.style5 {
	color: #0099FF;
	font-weight: bold;
}
.style7 {color: #FF3D86; font-weight: bold; }
</style>
<link rel=stylesheet href="scroll.css" type="text/css">
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<?php

// display ตัวเลข 

$numpic = strval($number);

// display ตัวเลข


?>


<div align="center"><img src="../brdhead_pink.gif" width="1018" height="200">
  <br>
</div>
<table width="100%" border=0 cellpadding="0" cellspacing="0">
  <tr> 
    <td bgcolor="#FFE6F2"><div align="center" class="style5 style6"><font size="3" face="Microsoft Sans Serif" color="#FF3D86">
		<?php 
		// แสดง topic
		echo $topic;
		?>
    </font></div></td>
  </tr>
</table><br>
<table width="95%" border="1" align="center" cellpadding="2" cellspacing="2" bordercolor="#FFFFFF">
  <tr bordercolor="#eeeeee" bgcolor="#eeeeee"> 
    <td bordercolor="#FEF4DE" bgcolor="#FFE6F2"><span style="color: #FF3D86"><font size="1" face="Verdana" style="font-size:8pt"><strong><font face="Microsoft Sans Serif">&gt;&gt;</font> 
      Details</strong></font></span></td>
  </tr>
  <tr> 
    <td height="79" bordercolor="#FFE6F2"><font color="#CC6600" size="2" face="Microsoft Sans Serif"><br>
      </font> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><span class="style6">
		  <font size="2" face="Microsoft Sans Serif">  
			<?php if($pict != ""){echo "<img src='webboard/".$pict."'><br><br>";}
				?>
			<?php 
			// แสดง detail
			echo $comment ;
			?>
          </font> </span></td>
        </tr>
      </table>
    <br> </td>
  </tr>
  <tr> 
    <td bordercolor="#FFE6F2" bgcolor="#FFE6F2"><div align="right"><font  style="font-size:8pt" color="#666666" face="Microsoft Sans Serif"><strong>*by</strong> 
        : 
		<?php 
		// แสดงชื่อคนตั้งกระทู้
		$email = chop($email);
		if ($email != ""){
			echo "<a href='mailto:".$email."'>";
			echo $name;
			echo "</a>";
		}
		else{
			echo $name;
		}
		?>
		&nbsp;&nbsp; <strong>*time</strong> : 
		<?php 
		echo $date;
		?>
		&nbsp;
		<?php
		echo $time;
		?>

<?php
//insert ip showing code
?>
		&nbsp;&nbsp;<strong>*ip</strong> :

<?php
		echo $pip;

//end ip showing code
?>


	&nbsp;&nbsp;&nbsp;</font></div></td>
  </tr>
</table>

<!-- zone ของ reply -->
<?php
		$rep = file("webboard/$number.txt");

		for($i=1;$i<sizeof($rep);$i++):
		$repl = split("\t",$rep[$i]);
		$rpname = $repl[0];
		$rpdattime = split(",",$repl[1]);
		$rptime = $rpdattime[0];
		$rptime = chop($rptime);
		$rpdate = $rpdattime[1];
		$rpcomment = $repl[2];
		$rppict = $repl[3];
		$rpemail = $repl[5];
		$rpip = $repl[4];
?>

<table width="95%" border="1" align="center" cellpadding="2" cellspacing="2" bordercolor="#FFFFFF">
  <tr bordercolor="#FFE6F2" bgcolor="#FFE6F2"> 
    <td colspan="2"><span style="color: #FF3D86"><font size="1" face="Verdana" style="font-size:8pt"><strong><font face="Microsoft Sans Serif">::</font> 
      Reply No. <?php echo $i;?> </strong></font></span></td>
  </tr>
  <tr bordercolor="#FFE6F2" bgcolor="#FFFFFF"> 
    <td height="79" colspan="2"><font color="#CC6600" size="2" face="Microsoft Sans Serif"><br>
      </font> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><span class="style6">
		  
		  <font size="2" face="Microsoft Sans Serif">
		  <?php if($rppict != ""){echo "<img src='webboard/".$rppict."'><br><br>";}
				?>
		  
		  
		  <?php echo $rpcomment;?></font></span></td>
        </tr>
      </table>
    <br> </td>
  </tr>
  <tr> 
    <td bordercolor="#FFE6F2"><div align="center"><font  style="font-size:8pt" color="#666666" face="Microsoft Sans Serif"><img src="brdhead/sq.gif" width="10" height="10">&nbsp;<img src="brdhead/sq.gif" width="10" height="10"></font></div></td>
    <td bordercolor="#FFE6F2" bgcolor="#FFE6F2"><div align="right"><font  style="font-size:8pt" color="#666666" face="Microsoft Sans Serif"><strong>*by</strong> 
        : 		<?php 
		// แสดงชื่อคนตอบกระทู้
		$rpemail = chop($rpemail);
		if ($rpemail != ""){
			echo "<a href='mailto:".$rpemail."'>";
			echo $rpname;
			echo "</a>";
		}
		else{
			echo $rpname;
		}
		?>
		&nbsp;&nbsp; <strong>*time</strong> : 
		<?php 
		echo $rpdate;
		?>
		&nbsp;
		<?php
		echo $rptime;
		?>

<?php
//insert ip showing code
?>
		&nbsp;&nbsp;<strong>*ip</strong> :

<?php
		echo $rpip;

//end ip showing code
?>

&nbsp;&nbsp;&nbsp;</font></div></td>
  </tr>
</table>
<?php endfor;?>
<!-- zone ของ reply -->
<!-- จากนี้ลงไปเป็นแบบฟอร์มสำหรับ reply -->




<table width="95%" border="1" align="center" cellpadding="2" cellspacing="2" bordercolor="#FFFFFF">
  <tr bordercolor="#FFCC99"> 
    <td height="79" bordercolor="#FF97C9" bgcolor="#FFFFFF"><font color="#CC6600" size="2" face="Microsoft Sans Serif"><br> 
      </font>
      <form method=post action="webboard.php?action=reply" name="boardrep" enctype="multipart/form-data">
        <input type=hidden name=number value=<?php echo $number;?>>
        <center>
          <img src="replynew.gif" width="241" height="41"> <br>
          <table width="400" border="0" cellspacing="1" cellpadding="0">
            <tr>
              <td width="20" valign="middle" class="unnamed1">&nbsp;</td>
              <td width="187" valign="bottom" bgcolor="#FFFFFF"><div align="center"><span class="unnamed1"><span class="style7"><font face="Verdana">Name</font></span></span></div></td>
              <td width="22" valign="middle" class="unnamed1">&nbsp;</td>
              <td width="185" valign="bottom" bgcolor="#FFFFFF"><div align="center"><span class="unnamed1"><span class="style7"><font face="Verdana">E-mail</font></span></span></div></td>
              <td width="20" valign="middle" class="unnamed1">&nbsp;</td>
            </tr>
            <tr>
              <td valign="middle" class="unnamed1"><div align="center"><span class="style4"><font face="Verdana">.:</font></span></div></td>
              <td valign="top"><div align="center">
                  <input name="name" type="text" class=input1 id="name"  style="width:150">
              </div></td>
              <td valign="middle" class="unnamed1">&nbsp;</td>
              <td valign="top"><div align="center">
                  <input name="email" type="text" class=input1 id="email" style="width:150">
              </div></td>
              <td valign="middle" class="unnamed1"><div align="center"><span class="style4"><font face="Verdana">:.</font></span></div></td>
            </tr>
            <tr>
              <td valign="middle" class="unnamed1">&nbsp;</td>
              <td colspan="3" valign="bottom" bgcolor="#FFFFFF"><div align="center"><span class="unnamed1"><span class="style7"><font face="Verdana">Picture</font></span></span></div></td>
              <td valign="middle" class="unnamed1">&nbsp;</td>
            </tr>
            <tr>
              <td valign="middle" class="unnamed1"><div align="center"><span class="style4"><font face="Verdana">.:</font></span></div></td>
              <td colspan="3">
                <div align="center">
                  <input type="file" name="picture2" class=input1>
              </div></td>
              <td valign="middle" class="unnamed1"><div align="center"><span class="style4"><font face="Verdana">:.</font></span></div></td>
            </tr>
            <tr>
              <td valign="middle" class="unnamed1">&nbsp;</td>
              <td colspan="3" valign="bottom" bgcolor="#FFFFFF"><div align="center"><span class="unnamed1"><span class="style7"><font face="Verdana">Message</font></span></span></div></td>
              <td valign="middle" class="unnamed1">&nbsp;</td>
            </tr>
            <tr>
              <td valign="middle" class="unnamed1"><div align="center"><span class="style4"><font face="Verdana">::</font></span></div></td>
              <td colspan="3"><div align="center">
                  <textarea name="comment" rows="7" class="input1" id="comment"></textarea>
              </div></td>
              <td valign="middle" class="unnamed1"><div align="center"><span class="style4"><font face="Verdana">::</font></span></div></td>
            </tr>
            <tr>
              <td><div align="center"></div></td>
              <td colspan="3"><div align="center"><img src="reply.gif" width="85" height="18" onClick="if(checkclick==0){var chcknum=0; if(boardrep.name.value ==''){chcknum=1;} if(boardrep.comment.value==''){chcknum=2;} if(chcknum == 0){checkclick++;boardrep.submit();}else{alert('คุณกรอกข้อมูลไม่ครบครับ');checkclick=0;} }">&nbsp;<img src="clear.gif" width="85" height="18" onclick="boardform.reset()"></div></td>
              <td>&nbsp;</td>
              <SCRIPT LANGUAGE="JavaScript">
<!--
	var checkclick = 0;
//-->
      </SCRIPT>
            </tr>
          </table>
        </center>
    </form>  </td>
  </tr>
</table>
<br>
</body>
</html>

