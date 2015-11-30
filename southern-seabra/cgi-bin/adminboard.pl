#!/usr/local/bin/perl 
require "config.pl";
print "Content-type:text/html\n\n";
&pasteform;
$topic = "topic.dat";
$numtopic = "numtopic.dat";
$admin =$FORM{'admin'}; 
$remark=$FORM{'remark'}; 
$reset=$FORM{'reset'}; 
$passwd=$FORM{'passwd'}; 
$cfirmdel=$FORM{'deletefile'};
##########################
if ($FORM{'action'} eq "delete") {
&checkpass;
&dodelete;
exit;
}

&html;
##########################
sub checkpass {
if ($remark =~ /\-/) {
	@cutter = split(/\-/,$remark);
	$cutter[1]++;
	$remark = $cutter[0];
	$cutter[0]++;
	for ($i=$cutter[0];$i<$cutter[1] ;$i++) {
		if ($i > $cutter[0]) {
			if ($i < 10) {$i = "00000$i";}
			elsif ($i < 100) {$i = "0000$i";}
			elsif ($i < 1000){$i = "000$i";} 
			elsif ($i < 10000){$i = "00$i";} 
			elsif ($i < 100000){$i = "0$i";}
		}
		$remarksss=$remark;
		$remark = $remarksss.",$i";
	}
}
if ( ($remark eq "") && ($reset eq "no") ) {$delete = "กรุณากรอกหมายเลขกระทู้ด้วยครับ";&html;}
if (($admin ne $s_admin)||($passwd ne $s_pass)){ 
$delete = "You are not Admin. <br>กรุณาอย่าล่วงล้ำเข้ามาในสถานที่ส่วนบุคคล !!!";
&html;
}
}

sub dodelete {
if ($reset eq "yes"){
unlink<$Msg_Dir/*.html>;
unlink<$Topic_Dir/*.dat>;
open (NUMTOPICFILE,">$Topic_Dir/$numtopic");
close(NUMTOPICFILE);
open (TOPICFILE,">$Topic_Dir/$topic");
close(TOPICFILE);
$delete = "กระทู้ใน webboard ได้ถูกลบทั้งหมดแล้ว";
&html;
}
if ($remark ne "") {
@remark1 = split(/,/,$remark); 
open (FILE,"$Topic_Dir/$topic"); 
@data = <FILE>;
close(FILE);


open (MFILE,">$Topic_Dir/$topic"); 
foreach $line(@data){ 
foreach $remark11 (@remark1) {
if ($line =~/$remark11/){ 
$line =""; 
print MFILE "\n$line"; 
$found = "yes"; 
}
if ($cfirmdel eq "yes") {unlink("$Msg_Dir/$remark11.php");
unlink("$Topic_Dir/$remark11.dat");
unlink("$View_Dir/$remark11.dat");
}
} 
print MFILE "$line"; 
} 
close(MFILE); 
if ($found eq "yes") {
$delete = "delete";
} else {$delete = "ไม่พบหมายเลขกระทู้ที่คุณใส่มา";}
&html;
}
}
##########################
sub html {
print <<EOF;
<html> 
<head> 
<title>Admin board version1.0 for webboard2.3b</title> 
</head> 
<body> 
<form method="POST" action="$admin_file"> 
EOF
if ($delete eq "delete") {
foreach $remark11 (@remark1) {
print <<EOF;
<center><font color="red" size="5"><b></u>คุณได้ลบกระทู้หัวข้อ $remark11 เรียบร้อยแล้ว</u></b></font></center>
EOF
}
$delete = "";
}
if ($delete ne "") {
print <<EOF;
<center><font color="red" size="5"><b></u>$delete</u></b></font></center>
EOF
}
print <<EOF;
<div align="center"> 
    <table border="0" width="84%" cellspacing="0" cellpadding="2">
      <tr> 
        <td width="100%" bgcolor="#0066FF" colspan="3"> 
          <p align="center"><b><font size="4" color="#FFFFFF" face="Verdana">Admin board version1.0 for webboard2.3b</font></b>
        </td>
      </tr>
      <center>
        <tr> 
          <td width="41%" bgcolor="#D9E8FF" colspan="2"> <br>
            <font color="#FF0000"> <b><font face="Verdana" size="2">Topic number</font></b><font face="MS Sans Serif" size="3"> 
            <b><br></b> 
            </font></font></td>
          <td width="59%" bgcolor="#D9E8FF" valign="middle"><br>
            <input name="remark" size="20">
          </td>
        </tr>
        <tr> 
          <td width="41%" bgcolor="#D9E8FF" colspan="2" height="37"><b><font size="2" color="#FF0000"><b><font face="Verdana" color="#FF0000">Reset 
            Webboard </font><font color="#FF0000"><font face="MS Sans Serif" size="3">(ลบทั้งหมด) 
            </font></font></b></font><font face="Verdana" size="2" color="#CC0000"> 
            </font></b></td>
          <td width="59%" bgcolor="#D9E8FF" height="37"> 
            <p><font size="2" color="#808080"><b><font face="Verdana"> Yes</font></b></font> 
              <input type="radio" name="reset" value="yes">
              <font size="2" color="#808080"><b><font face="Verdana">No</font></b></font> 
              <input type="radio" name="reset" checked value="no">
            </p>
            </td>
        </tr>
        <tr>
          <td width="41%" bgcolor="#D9E8FF" colspan="2" height="36"><font size="2" color="#808080"><b><font face="Verdana">Admin 
            </font></b></font></td>
          <td width="59%" bgcolor="#D9E8FF" height="36"> 
            <input name="admin" size="20">
          </td>
        </tr>
        <tr> 
          <td width="41%" bgcolor="#D9E8FF" colspan="2"><b><font face="Verdana" size="2"> 
            <font color="#808080">Password</font></font></b></td>
          <td width="59%" bgcolor="#D9E8FF"> 
            <input name="passwd" size="20" type="password">
            <input name="action" size="20" type="hidden" value="delete">
          </td>
        </tr>
		 
				<tr> 
          <td width="41%" bgcolor="#D9E8FF" colspan="2"><b><font face="Verdana" size="2"> 
            <font color="#808080">			<input type="checkbox" name="deletefile" value="yes"></font></font></b></td>
          <td width="59%" bgcolor="#D9E8FF"> ลบไฟล์กระทู้ด้วย
			</td>
        </tr>

        <tr> 
          <td width="41%" bgcolor="#D9E8FF" colspan="2"> 
            <p align="center"> 
          </td>
          <td width="59%" bgcolor="#D9E8FF"> 
            <input type="submit" value=" Delete ">
            <input type="reset" value="Reset">
          </td>
        </tr>
        <tr> 
          <td width="100%" bgcolor="#D9E8FF" colspan="3"><font face="Verdana" size="3"><font color="red">หมายเหตุ</font> ในกรณีต้องการลบหลายๆ กระทู้กรุณาใช้เครื่องหมาย , คั่นครับ</font></td>
        </tr>
      </center>
    </table> 
</div> 
</form> 
</body> 
</html> 
EOF
exit;
}

              sub pasteform { 
               read(STDIN,$buffer,$ENV{'CONTENT_LENGTH'}); 
               @pairs = split(/&/,$buffer); 
               foreach $pair (@pairs){ 
               ($name,$value) = split(/=/,$pair); 
               $value =~ tr/+/ /; 
               $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C",hex($1))/eg; 
               $value =~ s/~!/~!/g; $FORM{$name}=$value; 
               } 
              }