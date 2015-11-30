#!/usr/local/bin/perl
##################################################
# Copyright 1999-2001 Thailand Miscellaneous.                                #
#Allrights reserved. webmaster@thaimisc.com                       #
# This Program is Free Only !!!! Don't Sale                                 #
# โปรแกรมนี้เป็นโปรแกรมแจกฟรี เพื่อนนำไปพัฒนาต่อ หรือศึกษาเท่านั้น       #
# หามนำไปเพื่อการค้าขาย หรือหวังผลตอบแทน หากต้องการจะทำ                #
# กรุณาติดต่อเรา http://www.thaimisc.com                                          #
#  webmaster@thaimisc.com                         								   #			
#	หากใครที่ จะมีความกรุณาสนับสนุนเราทางด้านการเงินและการพัฒนาเวบ #
# นี้ต่อไป กรุณาติดต่อ 162-301948 หรือ choo@thaimisc.com          #
# ด้วยนะครับ :) เนื่องจากเรายังเป็นเยาว์ชนและยังอยู่ในวัยเรียนจึงยังต้องการ   #
#เงินสนับสนุนบางส่วน ขอบคุณครับ    					                                         #
##################################################
require "config.pl";
use CGI;
$obj = new CGI;
$fileupload = $obj->param(fileupload);
$msgname = $obj->param(msgname);
$msgby = $obj->param(msgby);
$email = $obj->param(email);
$icq = $obj->param(icq);
$msgdetail = $obj->param(msgdetail);
$action = $obj->param(action);
$uip =  $ENV{'HTTP_X_FORWARDED_FOR'};
$uhost = $ENV{'REMOTE_HOST'};
if ($ENV{'HTTP_X_FORWARDED_FOR'} ne "") {
$ENV{'REMOTE_ADDR'} =  $ENV{'HTTP_X_FORWARDED_FOR'};
}
print "Content-type:text/html\n\n"; 
&get_date;


if($action eq "post") { 
&HTML_HEADER;
print <<"EOF";


<form method=post action="$Script_Url/addnew.pl" enctype="multipart/form-data">
  <table width="80%" border="0" align="center">
    <tr> 
      <td valign="middle" height="30" width="67"><font color="\#3399ff" size="2" face="MS Sans Serif"> 
        หัวข้อ :</font></td>
      <td valign="middle" width="400"><font color="\#3399ff" size="2" face="MS Sans Serif"> 
        <input type=text name='msgname' size="60" class="input">
        *</font></td>
    </tr>
    <tr> 
      <td valign="middle" height="30" width="67"><font color="\#3399ff" size="2" face="MS Sans Serif">Name&nbsp;&nbsp; 
        :</font></td>
      <td valign="middle" width="400"><font color="\#3399ff" size="2" face="MS Sans Serif"> 
        <input size=60 type=text name='msgby' class="input">
       </font></td>
    </tr>
    <tr> 
      <td valign="middle" height="30" width="76"><font color=\#3399ff size="2" face="MS Sans Serif">email 
        :</font></td>
      <td valign="middle" width="400"><font color="\#3399ff" size="2" face="MS Sans Serif"> 
        <input size=60 type=text name='email' class="input">
        </font></td>
    </tr>
    <tr> 
      <td valign="middle" height="30" width="76"><font color=\#3399ff size="2" face="MS Sans Serif">icq 
        : </font></td>
      <td valign="middle" width="400"><font color="\#3399ff" size="2" face="MS Sans Serif"> 
        <input size=60 type=text name='icq' class="input">
        </font></td>
    </tr>
	<tr> 
      <td valign=middle><font size="2" face="MS Sans Serif" color="\#3399ff">Image : </font></td>
      <td valign=middle><font color="black" size="2" face="MS Sans Serif"> 
<input type="file" name="fileupload" class=input>
        </font></td>
    </tr>
    <tr> 
      <td valign="middle" height="30" width="67"><font color="\#3399ff" size="2" face="MS Sans Serif">Detail&nbsp;</font><font size="2" face="MS Sans Serif"> 
        :</font></td>
      <td valign="middle" rowspan="4" width="400"> <font size="2" face="MS Sans Serif"> 
        <textarea name='msgdetail' cols=59 rows=6 wrap="virtual" class="input"></textarea>
        </font><font size="2" face="MS Sans Serif"> </font><font size="2" face="MS Sans Serif"> 
        </font></td>
    </tr>
    <tr> 
      <td height="30" width="67" valign="middle">&nbsp;</td>
    </tr>
    <tr> 
      <td height="30" width="67" valign="middle">&nbsp;</td>
    </tr>
    <tr> 
      <td height="30" width="67" valign="middle">&nbsp;</td>
    </tr>
    <tr> 
      <td height="30" width="67" valign="middle">&nbsp;</td>
      <td valign="middle" width="400"><font size="2" face="MS Sans Serif"> <center>
		<input type=hidden name=type value=guest>
		<input type=submit value='Post' name="submit" class="button">
        <input type=reset value='Clear' name="reset" class="button"></center>
        </font></td>
    </tr>
  </table></form>
    

EOF
&HTML_FOOTER;
exit;
}

$type = $obj->param(type);
if ($type eq "member") {
	$psd = $obj->param(psd);
	chomp($psd);
	chomp($msgby);
	$temp3  = $mem_dir."/d_".$msgby;
	if (-e "$temp3.txt") {
		open(EEE,"$temp3.txt");
		@mdat = <EEE>;
		close(EEE);
		chomp(@mdat);
		if ($psd eq $mdat[1]) {
			if ($mdat[5] eq "-") {
				$motto = $mdat[4];
				$id = $msgby;
				$name = $mdat[0];
				$msgby = $name;
				if (($email eq "")&&($mdat[2] ne "")) {
					$email = $mdat[2];
				}
			}
			else{
				if (($email eq "")&&($mdat[2] ne "")) {
					$email = $mdat[2];
				}
				$motto = $mdat[4];
				$id = $msgby;
				$msgby = "$mdat[5]";
			}
		}
		else{
			&HTML_HEADER;
			$mesg = "Password ผิด";
			$url = "$My_Url/cgi-bin/addnew.pl?action=post";
			$act = "";
			&message;
			&HTML_FOOTER;
			exit;
		}
	}
	else{
		&HTML_HEADER;
		$mesg = "ใส่ ID ในช่อง name ด้วยครับ ถ้าเลือก type เป็น member";
		$url = "$My_Url/cgi-bin/addnew.pl?action=post";
		$act = "";
		&message;
		&HTML_FOOTER;
		exit;
	}
}
else{$motto = "";}

if ( ($msgby =~ /revolt/) || ($msgby =~ /rev0lt/) || ($msgname eq "") || ($msgby eq "") || ($msgdetail eq "") ) {
&HTML_HEADER;
print <<EOF;
<div align="center">
  <p>&nbsp;</p>
  <p>ข้อความไม่ครบครับ กรุณากลับไปแก้ใหม่</p>
  <p><br>
  </p>
</div>
EOF
&HTML_FOOTER;
}

else{      

open(COUNT,"$count_dir/c_mem.txt");
$nummem = <COUNT>;
close(COUNT);
for ($h=0;$h<$nummem;$h++) {
	$i = $h+1;
	if ($i < 10) {$j = "00000$i";}
	elsif ($i < 100) {$j = "0000$i";}
	elsif ($i < 1000){$j = "000$i";} 
	elsif ($i < 10000){$j = "00$i";} 
	elsif ($i < 100000){$j = "0$i";}
	open(D,"$mem_dir/d_$j.txt");
	@dat = <D>;
	close(D);
	chomp(@dat);
	$name=$dat[0];
	if ($msgby eq $name) {
		if ($type ne "member") {
			$h=$nummem;
			&HTML_HEADER;
			$mesg = "ชื่อนี้มีคนใช้แล้วครับ";
			$url = "$My_Url/webboard/$msgcount.php";
			$act = "";
			&message;
			&HTML_FOOTER;
			exit;
		}
	}
}

open( RUDE, "$Msg_Dir/badword.txt") || die "Can not open badword.txt to read\n";
@rude = <RUDE>;
chomp(@rude); 
close(@rude);


#@rude =("ควย", "ไอ้", "สัตว์", "มึง", "หี", "หำ", "เย็ด" ,"fuck" );

foreach $word (@rude) {

if ($msgname   =~/$word/)   {$bad ='yes'; }

if ($msgby     =~/$word/)   {$bad ='yes'; }

if ($msgdetail =~/$word/)   {$bad ='yes'; }

if ($bad eq 'yes') {print "ไม่สุภาพเลยครับ $word";exit; }

}

open(Post, "$Msg_Dir/addnew.txt");
$post = <Post>;
close(Post);
if ($msgname eq $post) {
&HTML_HEADER;
print "<center>กรุณาอย่า post ข้อความซ้ำครับ</center>";
&HTML_FOOTER;
exit;
}

open (IPFILE,"$Msg_Dir/ip/$ENV{'REMOTE_ADDR'}.dat");
$ip = <IPFILE>;
close(IPFILE);    

if ($ip eq "$maxpost")  {
print <<more;
<h1>คุณได้ส่งข้อความมาเกินกำหนดแล้วครับผม  ต้องขออภัยที่ต้องทำอย่างนี้เนื่องจากบอร์ดนี้โดนก่อกวนจากผู้ที่ไม่หวังดี</h1>
more

open (IPQFILE,"$Msg_Dir/ip/q/$ENV{'REMOTE_ADDR'}.dat");
$ipq = <IPQFILE>;
close(IPQFILE);    

$ipq++;

open (IPQFILE,">$Msg_Dir/ip/q/$ENV{'REMOTE_ADDR'}.dat");
print IPQFILE "$ipq";
close(IPQFILE);

}
else {

$ip++;

open (IPFILE,">$Msg_Dir/ip/$ENV{'REMOTE_ADDR'}.dat");
print IPFILE "$ip";
close(IPFILE);
###### get&set number of topic ######


open (NUMFILE,"$Topic_Dir/numtopic.dat");
$numtopic = <NUMFILE>;
close(NUMFILE);    

$numtopic++;
$numprint = $numtopic;

if ($numtopic < 10) {$numtopic = "0000$numtopic";} else{
if ($numtopic < 100) {$numtopic = "000$numtopic";} else{
if ($numtopic < 1000) {$numtopic = "00$numtopic";} else{
if ($numtopic < 10000) {$numtopic = "0$numtopic";} }}}
if ($fileupload ne "") {&upload;}

open (NUMFILE,">$Topic_Dir/numtopic.dat");
print NUMFILE "$numprint";
close(NUMFILE);

open (newfile,">>$Msg_Dir/new.html"); 
print newfile "$numtopic\n";
close(newfile); 
open(Post11,">$Msg_Dir/addnew.txt");
print Post11 "$msgname";
close(Post11);

#####################################

if ($type eq "member") {
	open(BON,"$mem_dir/d_$id.txt");
	@bonus = <BON>;
	close(BON);
	chomp($bonus[7]);
	$bonus[7] = $bonus[7]+100;
	$bonus[7] = $bonus[7]."\n";
	open(BOON,">$mem_dir/d_$id.txt");
	print BOON @bonus;
	close(BOON);
}

###### set number of message ######
$fname = "$numtopic.dat";
$FILE_NAME="$Topic_Dir/$fname";
$fdate = "date$numtopic.html";
$FILE_DATE="$Topic_Dir/date/$fdate";
open (NUMMSG,">$FILE_NAME") ;
print NUMMSG "0";
close(NUMMSG);    
#ใส่ค่าวันที่ใหม่เข้าไป
#open(DATE_FILE,">$FILE_DATE");
#print DATE_FILE "$date";
#close(DATE_FILE);


####################################

###### set number of message viewer ######
$vname = "$numtopic.dat";
$VFILE_NAME = "$View_Dir/$vname";
 open(VIEWMSG,">$VFILE_NAME");
 print	 VIEWMSG "0";
 close(VIEWMSG);
chmod(0777,"$VFILE_NAME");


####################################

### chmod topid.dat to 777 then add topic.dat and chmod back to 644 ###
chmod(0777,"$Topic_Dir/topic.dat");

open (TOPICFILE,">>$Topic_Dir/topic.dat");
&checknametopic;
&checkby;
print TOPICFILE "$numtopic||||$numtopic.php||||$topic||||";
if (($type eq "member")&&($mdat[5] ne "-")) {
print TOPICFILE "<img src='$My_Url/cgi-bin/club/mem_log/$msgby' height=20 border=0>";
}
else{
print TOPICFILE "$name";
}
print TOPICFILE "||||$date||||<!--$ENV{'REMOTE_ADDR'} : $uhost  : $uip-->\n";
close(TOPICFILE);




### add name&ip files ###


open(IPL,"$Topic_Dir/ipname.dat");
@iplist = <IPL>;
close(IPL);
$ccc = @iplist;
if ($iplist[0] ne "") {
	for ($i=0; $i<$ccc;$i++) {
		@ipm = split(/\*\*\*\*\*/,$iplist[$i]);
		chomp(@ipm);
		if ($ipm[0] eq $msgby) {
			if ($ipm[1] eq $ENV{'REMOTE_ADDR'}) {
				$i = $ccc;
				$acting = 1;
			}
			if ($ipm[1] ne $ENV{'REMOTE_ADDR'}) {
				$acting = 0;
			}
		}
		else{
			$acting = 0;
		}
	}
}
else{
	$acting = 0;
}
if ($acting == 0) {
	open(IPLW,">>$Topic_Dir/ipname.dat");
	print IPLW "$msgby";
	print IPLW "*****";
	print IPLW "$ENV{'REMOTE_ADDR'}\n";
	close(IPLW);
}

### CREATE *.SHTML ###


$fname = "$numtopic.php";

$FILE_NAME="$Msg_Dir/$fname";

open(MSGFILE,">>$FILE_NAME") ;

print MSGFILE "<html><head><title>$topic</title>\n";
print MSGFILE "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-874\">\n";
print MSGFILE "<style type=\"text/css\">\n";
print MSGFILE "<!--\n";
print MSGFILE "a:link { color: #005CA2; text-decoration: none}";
print MSGFILE "a:visited { color: #005CA2; text-decoration: none}";
print MSGFILE "a:active { color: #0099FF; text-decoration: underline}";
print MSGFILE "a:hover { color: #0099FF; text-decoration: underline}";
print MSGFILE "body {  margin: 0px  0px; padding: 0px  0px}\n";
print MSGFILE ".slimtable { border-color:\#3399ff;border-width:1}\n";
print MSGFILE "-->\n";
print MSGFILE "</style></head>\n";
print MSGFILE "<body bgcolor=\"\#FFFFFF\" bgproperties=\"fixed\">\n";
print MSGFILE "<script language=\"javascript\" src=\"$My_Url/bg.js\"></script>\n";
print MSGFILE "<!--message=0-->\n";
print MSGFILE "<?php include('count.php');vrcount($numprint);?>\n";
print MSGFILE "<link rel=stylesheet href=\"$My_Url/scroll.css\" type=\"text/css\">\n";
print MSGFILE "<link rel=stylesheet href=\"$My_Url/basic.css\" type=\"text/css\">\n";
print MSGFILE "<style>body {  margin: 0px  0px; padding: 0px  0px; background-position: right bottom;background-attachment: fixed; background-repeat : no-repeat }</style>";
print MSGFILE "<div align=\"center\"><font size=\"1\" face=\"MS Sans Serif\"><b> </b></font>";

print MSGFILE "  <font face=\"ms sans serif\" color=\"\#3399ff\" size=\"2\"><b><font face=\"verdana\">Southern \n";
print MSGFILE "  Seabra Webboard</font></b></font><br></div><center>\n";
print MSGFILE "<table width=\"80%\" border=\"0\" cellspacing=\"5\" cellpadding=\"3\" align=\"center\">\n";
print MSGFILE "  <tr bgcolor=\"\\#3399ff\"><td colspan=\"3\"><div align=\"center\"><font face=\"MS Sans Serif\" size=\"1\" color=\"\#FFFFCC\"><b>$topic</b></font></div></td></tr>\n";
if ($fileupload ne "") {
print MSGFILE "  <tr><td bgcolor=\"\#ececec\" colspan=\"3\"> \n";
print MSGFILE "      <div align=\"center\"><b><font color=Red size=2 face=\"ms sans serif\"><img src=\"$Img_Url/$numtopic.$sir\"></font></b></div>\n";
print MSGFILE "    </td></tr>\n";
}
&checkdetail;
print MSGFILE "  <tr><td bgcolor=\"\#efefef\" colspan=\"3\"><font face=\"ms sans serif\" size=\"2\" color=\"\#0066FF\">\n";
print MSGFILE "<br><center><table width=88% border=0><tr><td><font face=\"ms sans serif\" size=\"2\" color=\"\#0066FF\">$msg</font></td></tr></table></center></font>\n";
print MSGFILE " <br><center><table border=0 width=100%><tr><td><font face=\"ms sans serif\" size=\"2\" color=\"\#000099\">Name : <font face=\"MS Sans Serif\">\n";
	unless ($email=~/.*\@.*\..*/) {
		&checkby;
		if (($type eq "member")&&($mdat[5] ne "-")) {print MSGFILE "<img src='$My_Url/cgi-bin/club/mem_log/$msgby' height=20 border=0></font></font></td>\n ";
		}else{		print MSGFILE "$msgby</font></font></td>\n ";}
	}
	else{
		&checkby;
		&checkemail;
		if (($type eq "member")&&($mdat[5] ne "-")) {print MSGFILE "<a href=\"mailto:$email\"><img src='$My_Url/cgi-bin/club/mem_log/$msgby' height=20 border=0></a></font></font></td>\n ";}
		else{		print MSGFILE "<a href=\"mailto:$email\">$msgby</a></font></font></td>\n ";}
	}

print MSGFILE "    <td width=\"125\">\n";
print MSGFILE "      <div align=\"center\"><font face=\"ms sans serif\" size=\"2\" color=\"\#000099\">ICQ : \n";
	if ($icq ne "" ) {
	&checkicq;
print MSGFILE "        </font><font face=\"ms sans serif\" size=\"2\" color=\"\#000099\"><font face=\"ms sans serif\" size=\"2\">$icq</font><b><font face=\"ms sans serif\" size=\"1\"> \n";
print MSGFILE "        <img src='http://online.mirabilis.com/scripts/online.dll?icq=$icq&amp;img=5' width=\"19\">\n";
}
else{
print MSGFILE "        </font><font face=\"ms sans serif\" size=\"2\" color=\"\#000099\"><font face=\"verdana\" size=\"1\">-</font><b><font face=\"verdana\" size=\"1\">\n";
}
print MSGFILE "</font></b></font></div></td>\n";
print MSGFILE "    <td width=\"150\"> \n";
print MSGFILE "      <div align=\"center\"><font color=\"\#000099\" face=\"ms sans serif\" size=\"1\">[$date , $time น.]</font></div>\n";
print MSGFILE "    </td></tr></table></td></tr>\n";
if ($motto ne "") {
print MSGFILE "  <tr bgcolor=\"\#ececec\"> <td colspan=\"3\"> \n";
print MSGFILE "      <div align=\"center\"><font face=\"MS Sans Serif\" size=\"1\" color=\"\\#3399ff\">\"$motto\"</font></div>\n";
print MSGFILE "    </td></tr>\n";
}
	if(($msgby eq "Mr. RaY-aM")||($msgby eq "e-LiXir")||($msgby eq "[NeOpHytE]e-liXiR")){
		print MSGFILE "<!--unknown-->\n";
	}
	else{
		print MSGFILE "<!--$ENV{'REMOTE_ADDR'} : $uhost  : $uip-->\n"; 
	}
print MSGFILE "</table></center><center><hr size=1 width=70%></center>\n\n<!--msgform-->\n\n";

&messageform;

close( MSGFILE );
chmod(0777,"$FILE_NAME");

&HTML_HEADER;
print <<EOF;
  <p>&nbsp;</p>
<div align="center"><font face="ms sans serif" size=2 color=\#3399ff>ขอบคุณที่ใช้บริการ AC 118 Web  Board ครับ<br></font>
  [ <a href='$My_Url/cgi-bin/webboard.pl'><font face="ms sans serif" size=2 color=navy>กลับไป Web Board</font></a> ] <br>
    <p>&nbsp;</p>
</div>
EOF
&HTML_FOOTER;

}

   


sub messageform{

print MSGFILE "<table  border=0 width=80% cellpadding=\"2\" cellspacing=\"2\" align=center>\n";
print MSGFILE "<tr bgcolor=\"\#3399ff\"><td align=center> <center>\n";
print MSGFILE "<font face=\"ms sans serif\" color=white size=2>ขอเชิญร่วมเสนอแนะความคิดเห็นครับ</font></b> \n";
print MSGFILE "</center></td></tr><tr align=\"center\"><td> \n";

print MSGFILE "<center><table border=0 width=\"80%\"><tr> ";
print MSGFILE " <form action=\"$My_Url/cgi-bin/addhtml.pl\" method=post enctype=\"multipart/form-data\">   ";
print MSGFILE "<td valign=\"middle\" height=\"30\" width=\"67\"><font color=\"\#3399ff\" size=\"2\" face=\"MS Sans Serif\">Name&nbsp;&nbsp; ";
print MSGFILE ":</font></td>";
print MSGFILE " <td valign=\"middle\" width=\"400\"><font color=\"black\" size=\"2\" face=\"MS Sans Serif\"> ";
print MSGFILE "  <input size=50 type=text name='msgby' class=\"input\">";
print MSGFILE "       *</font></td>   </tr>    <tr> ";

print MSGFILE "     <tr><td valign=\"middle\" height=\"30\" width=\"76\"><font color=\#3399ff size=\"2\" face=\"MS Sans Serif\">email ";
print MSGFILE "       :</font></td>";
print MSGFILE "<td valign=\"middle\" width=\"400\"><font color=\"black\" size=\"2\" face=\"MS Sans Serif\"> ";
print MSGFILE "       <input size=50 type=text name='email' class=\"input\">";
print MSGFILE "       </font></td>    </tr>    <tr> ";
print MSGFILE "     <td valign=\"middle\" height=\"30\" width=\"76\"><font color=\#3399ff size=\"2\" face=\"MS Sans Serif\">icq ";
print MSGFILE "       : </font></td>";
print MSGFILE "     <td valign=\"middle\" width=\"400\"><font color=\"black\" size=\"2\" face=\"MS Sans Serif\"> ";
print MSGFILE "       <input size=50 type=text name='icq' class=\"input\">";
print MSGFILE "       </font></td>    </tr>    <tr> ";
#####
print MSGFILE "     <td valign=\"middle\" height=\"30\" width=\"76\"><font color=\#3399ff size=\"2\" face=\"MS Sans Serif\">รูปภาพ ";
print MSGFILE "       : </font></td>";
print MSGFILE "     <td valign=\"middle\" width=\"400\"><font color=\"black\" size=\"2\" face=\"MS Sans Serif\"> ";
print MSGFILE "       <input type=hidden name=msgcount value=$numtopic><input type=\"file\" name=\"fileupload\" class=input>";
print MSGFILE "       </font></td>    </tr>    <tr> ";
#####
print MSGFILE "     <td valign=\"middle\" height=\"30\" width=\"67\"><font color=\"\#3399ff\" size=\"2\" face=\"MS Sans Serif\">รายละเอียด&nbsp;</font><font size=\"2\" face=\"MS Sans Serif\"> ";
print MSGFILE "       :</font></td>";
print MSGFILE "     <td valign=\"middle\" rowspan=\"4\" width=\"400\"> <font size=\"2\" face=\"MS Sans Serif\"> ";
print MSGFILE "       <textarea name='msgdetail' cols=49 rows= 6 wrap=virtual class=\"input\"></textarea> ";
print MSGFILE "       *</font><font size=\"2\" face=\"MS Sans Serif\"> </font><font size=\"2\" face=\"MS Sans Serif\"> ";
print MSGFILE "       </font></td>";
print MSGFILE "   </tr>";
print MSGFILE "  <tr> ";
print MSGFILE "     <td height=\"30\" width=\"67\" valign=\"middle\">&nbsp;</td>";
print MSGFILE "   </tr>    <tr> ";
print MSGFILE "     <td height=\"30\" width=\"67\" valign=\"middle\">&nbsp;</td>";
print MSGFILE "   </tr>    <tr> ";
print MSGFILE "     <td height=\"30\" width=\"67\" valign=\"middle\">&nbsp;</td>";
print MSGFILE "   </tr>    <tr> ";
print MSGFILE "     <td height=\"30\" width=\"67\" valign=\"middle\">&nbsp;</td>";
print MSGFILE "     <td valign=\"middle\" width=\"400\"><font size=\"2\" face=\"MS Sans Serif\"> <center>";
print MSGFILE " <input type=hidden name=type value=guest>";
print MSGFILE "       <input type=submit value='Post' name=\"submit\" class=\"button\">";
print MSGFILE "       <input type=reset value='Clear' name=\"reset\" class=\"button\"></center>";
print MSGFILE "       </font></td>    </tr>  </table></form></center>";
print MSGFILE "</td></tr></table>";
print MSGFILE "</body></html>\n";
}
}


##############

sub checkdetail {
      $msg = " $msgdetail";
	  $msg =~ s/</&lt;/g; 
      $msg =~ s/>/&gt;/g; 
      $msg =~ s/\n\n/<p>/g;
      $msg =~ s/\n/<br>/g;
      $msg =~s/sm101/<img src=\"images\/sm101.gif\">/g;
      $msg =~s/sm102/<img src=\"images\/sm102.gif\">/g;
	  $msg =~s/sm103/<img src=\"images\/sm103.gif\">/g;
	  $msg =~s/sm104/<img src=\"images\/sm104.gif\">/g;
	  $msg =~s/sm111/<img src=\"images\/sm111.gif\">/g;
	  $msg =~s/sm112/<img src=\"images\/sm112.gif\">/g;
	  $msg =~s/sm113/<img src=\"images\/sm113.gif\">/g;
	  $msg =~s/sm114/<img src=\"images\/sm114.gif\">/g;
	  $msg =~s/sm115/<img src=\"images\/sm115.gif\">/g;
	  $msg =~s/sm116/<img src=\"images\/sm116.gif\">/g;
	  $msg =~s/sm117/<img src=\"images\/sm117.gif\">/g;
	  $msg =~s/sm118/<img src=\"images\/sm118.gif\">/g;
	  $msg =~s/sm119/<img src=\"images\/sm119.gif\">/g;
	  $msg =~s/sm120/<img src=\"images\/sm120.gif\">/g;
	  $msg =~s/sm121/<img src=\"images\/sm121.gif\">/g;
	  $msg =~s/sm122/<img src=\"images\/sm122.gif\">/g;
	  $msg =~s/sm123/<img src=\"images\/sm123.gif\">/g;
	  $msg =~s/sm124/<img src=\"images\/sm124.gif\">/g;
	  $msg =~s/sm125/<img src=\"images\/sm125.gif\">/g;
	  $msg =~s/sm126/<img src=\"images\/sm126.gif\">/g;
	  $msg =~ s/\:\)/<img src=\"images\/sm103.gif\">/g;
  	  $msg =~ s/:p/<img src=\"images\/sm119.gif\">/g;
	  $msg =~ s/(\[font (.+?)\])(.+?)(\[\/font\])/<font $2>$3<\/font>/isg;
      $msg =~ s/(\[url\])(\S+?)(\[\/url\])/ <A HREF=\"$2\" TARGET=_blank>$2<\/A> /isg;
      $msg =~ s/(\[email\])(\S+\@\S+?)(\[\/email\])/ <A HREF=\"mailto:$2\">$2<\/A> /isg;
  	  $msg =~ s/(\[img\])(\S+?)(\[\/img\])/ <IMG SRC=\"$2\"> /isg;
	  $msg =~ s/(\[b\])(.+?)(\[\/b\])/<b>$2<\/b>/isg;
	  $msg =~ s/(\[i\])(.+?)(\[\/i\])/<i>$2<\/i>/isg;
   	  $msg =~ s/(\[center\])(.+?)(\[\/center\])/<center>$2<\/center>/isg;
   	  $msg =~ s/(\[right\])(.+?)(\[\/right\])/<div align=right>$2<\/div>/isg;
   	  $msg =~ s/(\[navy\])(.+?)(\[\/navy\])/<font color=navy>$2<\/font>/isg;
   	  $msg =~ s/(\[blue\])(.+?)(\[\/blue\])/<font color=blue>$2<\/font>/isg;
   	  $msg =~ s/(\[red\])(.+?)(\[\/red\])/<font color=red>$2<\/font>/isg;
   	  $msg =~ s/(\[black\])(.+?)(\[\/black\])/<font color=black>$2<\/font>/isg;
}

sub checkby{
      $name = " $msgby";
	  $name =~ s/</&lt;/g; 
      $name =~ s/>/&gt;/g;
	  $name =~s/password/<img src=\"\/webboard\/images\/real.gif\" border=0>/g;	  
  	  $name =~s/iamrayam/<img src=\"$Msg_Url\/images\/rayam.jpg\" border=0>/g;  
  	  $name =~s/vj_scorpio/<img src=\"$Msg_Url\/images\/vj.jpg\" border=0>/g;  
  	  $name =~s/a_ac118/<img src=\"$Msg_Url\/images\/paman.jpg\" border=0>/g;  
  	  $name =~s/beagle_ac118/<img src=\"$Msg_Url\/images\/beagle.jpg\" border=0>/g;  
  	  $name =~s/iamnone/<img src=\"$Msg_Url\/images\/none.jpg\" border=0>/g;  
  	  $name =~s/iamelixir/<img src=\"$Msg_Url\/images\/elixir.jpg\" border=0>/g;  
  	  $name =~s/binarybig/<img src=\"$Msg_Url\/images\/big.jpg\" border=0>/g;  
  	  $name =~s/satoon_verdetta/<img src=\"$Msg_Url\/images\/satoon.jpg\" border=0>/g;  
	  $name =~s/\*\*\*\*\*/--/g;
	  $name =~s/\|\|\|\|/\-\|\-\|\-\|\-/g;	  
}

sub checknametopic{
      $topic = " $msgname";
	  $name =~s/\|\|\|\|/abcdefghi/g;	  
	  $topic =~ s/</&lt;/g; 
      $topic =~ s/>/&gt;/g;
  }
  
  sub checkicq{
      $icq = " $icq";
	  $icq =~ s/</&lt;/g; 
      $icq =~ s/>/&gt;/g;
	  $icq =~ s/\"/&quot;/g;
	  $icq =~ s/\'/&rsquo;/g;
  }
  sub checkemail{
      $email = " $email";
	  $email =~ s/</&lt;/g; 
      $email =~ s/>/&gt;/g;
	  $email =~ s/"/&quot;/g;
	  $email =~ s/'/&rsquo;/g;
  }
sub upload {
$filesave = $fileupload;
$filesave =~s{^.*\\}{};
if (($filesave !~/.jpg/i) && ($filesave !~/.gif/i) && ($filesave !~/.png/i)) {
&HTML_HEADER;
print "<center>file ผิดประเภทนะคับ</center>";
&HTML_FOOTER;
exit;
}
$buffer = "";
while (read($fileupload, $data, 1024)) {
$buffer .= $data;
if (length($buffer) > ($maxsize * 1024)) {
&HTML_HEADER;
print "<center>file มีขนาดใหญ่เกิน $maxsize KB นะครับ</center>";
&HTML_FOOTER;
exit;
}
}
@fileee = split(/\./,$filesave);
$sir = @fileee[1];
open(picture,">$Img_Dir/$numtopic.$sir");
binmode(picture);
print picture $buffer;
close(picture);
}