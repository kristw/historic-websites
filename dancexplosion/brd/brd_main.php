<html>
<head>
<title>CU -DanceXplosioN- Dancing Contest#1</title>
 <meta http-equiv="Content-Type" content="text/html; charset=windows-874">
<style type="text/css">
<!--
.style1 {
	font-family: verdana;
	font-size: 8pt;
}
.style3 {font-family: verdana}
.style4 {
	font-size: 8pt;
	color: #FF3D86;
}
.style6 {font-family: verdana; font-size: 8pt; color: #3399FF; }
-->
</style>
<link rel=stylesheet href="scroll.css" type="text/css">
<style type="text/css">
<!--
A:link, A:visited { text-decoration: none; color:#00aaFF}
A:hover { text-decoration: none; color : orange}
body{ scrollbar : no}
.mhand { cursor:hand;}
-->
</style>

<STYLE type="text/css"> 
<!-- 
BODY {
scrollbar-face-color:#FF3D86; 
scrollbar-highlight-color:#FF3D86; 
scrollbar-3dlight-color:#FFFFFF; 
scrollbar-darkshadow-color:#FFFFFF; 
scrollbar-shadow-color:#FFFFFF; 
scrollbar-arrow-color:#ffffff; 
scrollbar-track-color:#ffffff; 
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
} 
.line {
	border-top: 1px solid #6699FF;
	border-right: 0px solid #6699FF;
	border-bottom: 0px solid #6699FF;
	border-left: 0px solid #6699FF;
}
.style17 {
	font-size: 10px;
	font-weight: bold;
	color: #003CFF;
}
.style20 {color: #FF3D86}
--> 
</STYLE> 
</head>

<body>
<center>
  <img src="../brdhead_pink.gif" width="1018" height="200">  
  <br>
  <span class="style3 style17"><span class="style20">. :</span> <a href="brd_postnew.html">POST NEW TOPIC</a><span class="style20"> : . </span></span><br>
  <br>
  <table width="764"  border="0" cellpadding="5" cellspacing="0" bordercolor="#FFFFFF">
    <tr bordercolor="#3333FF" bgcolor="#3399FF">
      <th width="52" bgcolor="#FFBBD5" scope="col"><div align="center" class="style20"><span class="style1">: No. : </span></div></th>
      <th bgcolor="#FFE6F2" scope="col"><div align="center" class="style20"><span class="style1">: TopiC : </span></div></th>
      <th width="100" bgcolor="#FFBBD5" scope="col"><div align="center" class="style20"><span class="style1">: Name : </span></div></th>
      <th width="20" bgcolor="#FFE6F2" scope="col"><div align="center" class="style3 style4">v</div></th>
      <th width="20" bgcolor="#FFBBD5" scope="col"><div align="center" class="style6 style20">r</div></th>
      <th width="120" bgcolor="#FFE6F2" scope="col"><span class="style6 style20">: Date : </span></th>
      <th width="130" bgcolor="#FFBBD5" scope="col"><span class="style6 style20">: Update : </span></th>
    </tr>
    <?php 

//test

	if($start&&$end){$chkvar=1;}
	else{$chkvar=0;}
		$maxmes = 120;
		$pagecount = 0;

	$stud=file("topic.txt");
		
	if($chkvar==0){
		$star=sizeof($stud)%$maxmes;	
		if($star==0){
			$start2 = sizeof($stud)-$maxmes+1;
			$end2 = sizeof($stud);
		}
		else{
			$start2 = sizeof($stud)-$star+1;
			$end2 = sizeof($stud);
		}
		$start=$start2;
		$end=$end2;
	}

$stud = file("topic.txt");

for($i=$end-1;$i>$start-2;$i-=1):

$disp=split("\t",$stud[$i]);
$number = $disp[0];
$numbercheck = chop($number);
	if(($numbercheck != "" )&& (strlen($numbercheck)!=6)):

		if(strlen($disp[1])>35){
			$topic = substr($disp[1],0,35);
			$topic = $topic."...";
		}
		else{
			$topic = $disp[1];
		}
		if(strlen($disp[2])>13){
			$name = substr($disp[2],0,13);
			$name = $name."...";
		}
		else{
			$name = $disp[2];
		}
		$dattime = split(",",$disp[3]);
		$date = eregi_replace(" ","",$dattime[1]);

		$count = file("webboard/num$number.txt");
		$numview = eregi_replace("\n","",$count[0]);
		$numreply = eregi_replace("\n","",$count[1]);
		$count[2] = eregi_replace("\n","",$count[2]);
		if($count[2] =="no reply"||$count[2] ==""){
		$updateDis = "no reply";
		}
		else{
		$update = split("\t",$count[2]);
		$updateDis = substr($update[0],0,9)." : ".$update[1];
		}

		////////////////////////////////////////////////////////////
?>
    <?php 

	endif;
endfor;


////////////////////////////////////////////////////////////
?>
  </table>

  <table width="764"  border="0" cellpadding="5" cellspacing="0" bordercolor="#FFFFFF">

	  

<?php 

//test

	if($start&&$end){$chkvar=1;}
	else{$chkvar=0;}
		$maxmes = 120;
		$pagecount = 0;

	$stud=file("topic.txt");
		
	if($chkvar==0){
		$star=sizeof($stud)%$maxmes;	
		if($star==0){
			$start2 = sizeof($stud)-$maxmes+1;
			$end2 = sizeof($stud);
		}
		else{
			$start2 = sizeof($stud)-$star+1;
			$end2 = sizeof($stud);
		}
		$start=$start2;
		$end=$end2;
	}

$stud = file("topic.txt");

for($i=$end-1;$i>$start-2;$i-=1):

$disp=split("\t",$stud[$i]);
$number = $disp[0];
$numbercheck = chop($number);
	if(($numbercheck != "" )&& (strlen($numbercheck)!=6)):

		if(strlen($disp[1])>35){
			$topic = substr($disp[1],0,35);
			$topic = $topic."...";
		}
		else{
			$topic = $disp[1];
		}
		if(strlen($disp[2])>13){
			$name = substr($disp[2],0,13);
			$name = $name."...";
		}
		else{
			$name = $disp[2];
		}
		$dattime = split(",",$disp[3]);
		$date = eregi_replace(" ","",$dattime[1]);

		$count = file("webboard/num$number.txt");
		$numview = eregi_replace("\n","",$count[0]);
		$numreply = eregi_replace("\n","",$count[1]);
		$count[2] = eregi_replace("\n","",$count[2]);
		if($count[2] =="no reply"||$count[2] ==""){
		$updateDis = "no reply";
		}
		else{
		$update = split("\t",$count[2]);
		$updateDis = substr($update[0],0,9)." : ".$update[1];
		}

		////////////////////////////////////////////////////////////
?>
  <tr align="center" valign="middle" bordercolor="#FFFFFF" bgcolor="#FFFBFD">
    <td width="52"><center class="style20">
      <font face="MS Sans Serif" size="1"><?php echo $number; ?></font>
    </center></td>
    <td><span class="style20"><font face="MS Sans Serif" size="1">&nbsp;&nbsp;<a target="_blank" href="brd_shw.php?number=<?php echo $number;?>"><?php echo $topic; ?></a></font></span></td>
    <td width="100"><center class="style20">
      <font size="1" face="MS Sans Serif"><?php echo $name; ?></font>
    </center></td>
    <td width="20"><center class="style20">
      <font size="1" face="MS Sans Serif"><?php echo $numview;?></font>
    </center></td>
    <td width="20"><center class="style20">
      <font size="1" face="MS Sans Serif"><?php echo $numreply;?></font>
    </center></td>
    <td width="120"><center class="style20">
      <font size="1" face="MS Sans Serif"><?php echo $date; ?></font>
    </center></td>
    <td width="130"><span class="style20">&nbsp;<font size="1" face="MS Sans Serif"><?php echo $updateDis;?></font></span></td>
  </tr>

<?php 

	endif;
endfor;


////////////////////////////////////////////////////////////
?>
  </table>
  <br>
  <hr width="85%">
</center>
</body>
</html>