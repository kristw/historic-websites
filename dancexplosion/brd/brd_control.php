 <html><head></head>
 


<link rel=stylesheet href="scroll.css" type="text/css">
<style type="text/css">
<!--
A:link, A:visited { text-decoration: none; color:orange}
A:hover { text-decoration: none; color:#00aaFF}
body{ scrollbar : no}
.mhand { cursor:hand;}
.hove{color:#00aaff}
-->
</style>

<body bgcolor="#ffffff" leftmargin=0 topmargin=0 marginheight=0 marginwidth=0>
<table border=0 width=100%><tr><td>
<div align=left><font color=#00aaFF face=verdana style="font-size:8pt"> <b> &nbsp;:: view page </b> >>


<?php
		$maxmes = 120;
		$pagecount = 0;

$stud = file("topic.txt");

	for($numstud = sizeof($stud);$numstud>$maxmes;$numstud-=$maxmes){
		$start2=sizeof($stud)-$numstud+1;
		$end2=sizeof($stud)-$numstud+$maxmes;
		$pagecount++;
		if($pagecount>1){echo "-";}
		echo "<a href='brd_main.php?start=$start2&&end=$end2' target=show>$pagecount</a>";
	}
	if($numstud!=0){
		$start2=sizeof($stud)-$numstud+1 ;
		$end2=sizeof($stud);
		$pagecount++;
		if($pagecount>1){echo "-";}
		echo "<a href='brd_main.php?start=$start2&&end=$end2' target=show>$pagecount</a>";
	}

?>&nbsp;&nbsp;
</font>
</div>
</td><td>

<div style="font-face:verdana;font-size:8pt" align=right><b><font color=#00aaFF>
<a href="brd_postnew.html" target=show>Post New TopiC</a> &nbsp;: :&nbsp;  Delete TopiC&nbsp;&nbsp;
</font></b></div>
</td></tr></table>
</body></html>