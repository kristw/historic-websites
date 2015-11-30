#!/usr/local/bin/perl
##################################################
# Copyright 1999 Thailand Miscellaneous.                                #
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
$msgby = $obj->param(msgby);
$email = $obj->param(email);
$icq = $obj->param(icq);
$msgdetail = $obj->param(msgdetail);
$msgcount = $obj->param(msgcount);
$type = $obj->param(type);

$uip =  $ENV{'HTTP_X_FORWARDED_FOR'};
$uhost = $ENV{'REMOTE_HOST'};
if ($ENV{'HTTP_X_FORWARDED_FOR'} ne "") {
$ENV{'REMOTE_ADDR'} =  $ENV{'HTTP_X_FORWARDED_FOR'};
}
print "Content-type:text/html\n\n"; 
&get_date;

if ( ($msgby eq "") || ($msgdetail eq "") ) {

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

open( RUDE, "$Msg_Dir/badword.txt") || die "Can not open badword.txt to read\n";
@rude = <RUDE>;
chomp(@rude); 
close(@rude);

#@rude =("ควย", "ไอ้", "สัตว์", "มึง", "หี", "หำ", "เย็ด" ,"fuck" );

foreach $word (@rude) {

if ($msgby     =~/$word/)   {$bad ='yes'; }

if ($msgdetail =~/$word/)   {$bad ='yes'; }

if ($bad eq 'yes') {print "ไม่สุภาพเลยครับ $word";exit; }

}

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
				$motto = $mdat[4];
				$id=$msgby;
				$msgby = "$mdat[5]";
				if (($email eq "")&&($mdat[2] ne "")) {
					$email = $mdat[2];
				}
			}
		}
		else{
			&HTML_HEADER;
			$mesg = "Password ผิด";
			$url = "$My_Url/webboard/$msgcount.php";
			$act = "";
			&message;
			&HTML_FOOTER;
			exit;
		}
	}
	else{
		&HTML_HEADER;
		$mesg = "ใส่ ID ในช่อง name ด้วยครับ ถ้าเลือก type เป็น member";
		$url = "$My_Url/webboard/$msgcount.php";
		$act = "";
		&message;
		&HTML_FOOTER;
		exit;
	}
}
else{$motto = "";}

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


open (POST,"$Msg_Dir/addhtml.txt");
$post = <POST>;
close (POST);

if ($msgdetail eq "$post") {
&HTML_HEADER;
print "<center>กรุณาอย่า post ข้อความซ้ำครับ</center>";
&HTML_FOOTER;
exit;
}
open (IPFILE,"$Msg_Dir/ipreply/$ENV{'REMOTE_ADDR'}.dat");
$ip = <IPFILE>;
close(IPFILE);    

if ($ip eq "$maxpost")  {
print <<more;
<h1>คุณได้ส่งข้อความมาเกินกำหนดแล้วครับผม  ต้องขออภัยที่ต้องทำอย่างนี้เนื่องจากบอร์ดนี้โดนก่อกวนจากผู้ที่ไม่หวังดี</h1>
more

open (IPQFILE,"$Msg_Dir/ipreply/q/$ENV{'REMOTE_ADDR'}.dat");
$ipq = <IPQFILE>;
close(IPQFILE);    

$ipq++;

open (IPQFILE,">$Msg_Dir/ipreply/q/$ENV{'REMOTE_ADDR'}.dat");
print IPQFILE "$ipq";
close(IPQFILE);

}
else {

$ip++;

open (IPFILE,">$Msg_Dir/ipreply/$ENV{'REMOTE_ADDR'}.dat");
print IPFILE "$ip";
close(IPFILE);

###### get&set number of message ######

$fnum = $msgcount;
$fname = "$fnum.dat";
$FILE_NAME="$Topic_Dir/$fname";

open (NUMMSG,"$FILE_NAME") ;
$nummsg = <NUMMSG>;
close(NUMMSG);    

$nummsg++;
$numprint = $nummsg;
if ($fileupload ne "") {&upload;}

open (NUMMSG,">$FILE_NAME") ;
print NUMMSG "$numprint";
close(NUMMSG);

open (newfile,">>$Msg_Dir/update.html"); 
print newfile "$msgcount\n";
close(newfile); 

open (post11,">$Msg_Dir/addhtml.txt");
print post11 "$msgdetail";
close (post11);
###################################################

if ($type eq "member") {
	open(BON,"$mem_dir/d_$id.txt");
	@bonus = <BON>;
	close(BON);
	chomp($bonus[7]);
	$bonus[7] = $bonus[7]+50;
	$bonus[7] = $bonus[7]."\n";
	open(BOON,">$mem_dir/d_$id.txt");
	print BOON @bonus;
	close(BOON);
}
### add name&ip files ###
&checkby;
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
### Add *.HTML ###

$fnum = $msgcount;
$fname = "$fnum.php";
$FILE_NAME="$Msg_Dir/$fname";

### read data ###
open(MSGFILE,"$FILE_NAME") ;
@LINES = <MSGFILE>;
close( MSGFILE );
$SIZE=@LINES;
#################

### write data ###
$num = $nummsg;
$num--;
open(MSGFILE,">$FILE_NAME") ;
for ($i=0;$i<=$SIZE;$i++) {
$_=$LINES[$i];
  if (/<!--message=$num-->/) { 
     print MSGFILE "<!--message=$nummsg-->\n\n";
  }
  else {
     if (/<!--msgform-->/) {   
		$span=3;
		if ($fileupload ne "") {$span++;}
		if ($motto ne "") {$span++;}
	print MSGFILE "<center><table width=\"80\%\" border=\"0\" cellspacing=\"5\" cellpadding=\"3\" align=\"center\">";
	print MSGFILE "<tr><td bgcolor=\"\#eeeeee\" colspan=\"3\"><font face=\"MS Sans Serif\" size=\"1\" color=\"\#3399ff\"><b>ตอบเป็นคนที่ $nummsg</b></font></td>";
&checkdetail;
	print MSGFILE "<td bgcolor=\"\#3399ff\" rowspan=\"$span\" width=\"15\" valign=\"middle\" align=\"center\"> ";
	print MSGFILE "<div align=\"center\"> <font face=\"verdana\" size=\"2\" color=\"\#FFFFcc\">R<br>E<br>P<br>L<br>Y</font></div></td></tr>";
	if ($fileupload ne "" ) {
	print MSGFILE "<tr><td bgcolor=\"\#ececec\" colspan=\"3\">";
	print MSGFILE "<div align=\"center\"><b><font color=Red size=2 face=\"ms sans serif\"><img src=\"$Img_Url/$msgcount-$nummsg.$sir\"></font></b></div>";
	print MSGFILE "</td></tr>";
	}
	print MSGFILE "<tr> <td bgcolor=\"\#efefef\" colspan=\"3\"><font face=\"ms sans serif\" size=\"2\" color=\"\#0066FF\"><br><center><table width=88% border=0><tr><td><font face=\"ms sans serif\" size=\"2\" color=\"\#0066FF\">$msg</font></td></tr></table></center></font> ";
	print MSGFILE "<br><center><table style=\"border-width:1;border-color:\#3399ff\" width=100%><tr><td><font face=\"ms sans serif\" size=\"2\" color=\"\#000099\">Name : <font face=\"MS Sans Serif\" size=2>";
	unless ($email=~/.*\@.*\..*/) {
		&checkby;
		if (($type eq "member")&&($mdat[5] ne "-")) { print MSGFILE "<img src='$My_Url/cgi-bin/club/mem_log/$msgby' height=20 border=0></font></font></td>\n ";
		}else{		print MSGFILE "$name</font></font></td>\n ";}
	}
	else{
		&checkby;
		&checkemail;
		if (($type eq "member")&&($mdat[5] ne "-")) {print MSGFILE "<a href=\"mailto:$email\"><img src='$My_Url/cgi-bin/club/mem_log/$msgby' height=20 border=0></a></font></font></td>\n ";
		}else{		print MSGFILE "<a href=\"mailto:$email\">$name</a></font></font></td>\n ";}
	}
	print MSGFILE "</font></font></td>";
	print MSGFILE "<td width=\"125\">"; 
	print MSGFILE "<div align=\"center\"><font face=\"ms sans serif\" size=\"2\" color=\"\#000099\">ICQ : ";
	print MSGFILE "</font><font face=\"ms sans serif\" size=\"2\" color=\"\#000099\"><font face=\"ms sans serif\" size=\"2\">";
	if ($icq ne "" ) {
	&checkicq;
	print MSGFILE "$icq</font><font face=\"ms sans serif\" size=\"1\"> ";
	print MSGFILE "<img src='http://online.mirabilis.com/scripts/online.dll?icq=$icq\&amp;img=5' width=\"19\"></font></font></div>";
	}
	else{
	print MSGFILE "-</font></font></div>";
	}
	print MSGFILE "</td><td width=\"150\"> ";
	print MSGFILE "<div align=\"center\"><font color=\"\#000099\" face=\"ms sans serif\" size=\"1\">[ $date , $time น.]</font></div></td></tr></table></td></tr> ";
	if ($motto ne "") {
	print MSGFILE "<tr><td bgcolor=\"\#ececec\" colspan=\"3\"> ";
	print MSGFILE "<div align=\"center\"><font face=\"MS Sans Serif\" size=\"1\" color=\"\#3399ff\">\"$motto\"</font></div></td></tr>";
	}

	if(($msgby eq "Mr. RaY-aM")||($msgby eq "e-LiXir")||($msgby eq "[NeOpHytE]e-liXiR")){
		print MSGFILE "<!--unknown-->\n";
	}
	else{
		print MSGFILE "<!--$ENV{'REMOTE_ADDR'} : $uhost  : $uip-->\n"; 
	}
	print MSGFILE "</TABLE></CENTER><hr size=1 width=70%>\n\n";
	print MSGFILE "<!--msgform-->\n\n";
  }

     else{
	     print MSGFILE $_;
     }
  }
}
close( MSGFILE );
&HTML_HEADER;
print <<EOF;
  <p>&nbsp;</p>
<div align="center"><font color="\#3399ff" size=2 face="ms sans serif">ขอบคุณที่แสดงความคิดเห็นครับ</font><br>
<font face="verdana" color="\#3399ff" size=2>  [ <A HREF='$Msg_Url/$fname'>Back to Message</A> ]</font><br>
    <p>&nbsp;</p>
</div>
EOF

&HTML_FOOTER;

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
# เชคว่าใช้สมาชิหรือไม่
#password1 คือ รหัสลับส่วนตัวคนที่ 1
#password2 คือ รหัสลับส่วนตัวคนที่ 2
sub checkby{
      $name = " $msgby";
	  $name =~ s/</&lt;/g; 
      $name =~ s/>/&gt;/g; 
  	  $name =~s/iamrayam/<img src=\"$Msg_Url\/images\/rayam.jpg\" border=0>/g;  
  	  $name =~s/vj_scorpio/<img src=\"$Msg_Url\/images\/vj.jpg\" border=0>/g;  
  	  $name =~s/a_ac118/<img src=\"$Msg_Url\/images\/paman.jpg\" border=0>/g;  
  	  $name =~s/beagle_ac118/<img src=\"$Msg_Url\/images\/beagle.jpg\" border=0>/g;  
  	  $name =~s/iamnone/<img src=\"$Msg_Url\/images\/none.jpg\" border=0>/g;  
  	  $name =~s/iamelixir/<img src=\"$Msg_Url\/images\/elixir.jpg\" border=0>/g;  
  	  $name =~s/binarybig/<img src=\"$Msg_Url\/images\/big.jpg\" border=0>/g;  
  	  $name =~s/password1/<img src=\"images\/real.gif\" border=0>/g;  
  	  $name =~s/password2/<img src=\"images\/real.gif\" border=0>/g;	  
  	  $name =~s/satoon_verdetta/<img src=\"$Msg_Url\/images\/satoon.jpg\" border=0>/g;  
	  $name =~s/\*\*\*\*\*/\-\-/g;
}

  sub checkicq{
      $icq = " $icq";
	  $icq =~ s/</&lt;/g; 
      $icq =~ s/>/&gt;/g;
	  $icq =~ s/"/&quot;/g;
	  $icq =~ s/'/&rsquo;/g;
  }	
    sub checkemail{
      $email = " $email";
	  $email =~ s/</&lt;/g; 
      $email =~ s/>/&gt;/g;
	  $email =~ s/"/&quot;/g;
	  $email =~ s/'/&rsquo;/g;
  }

sub upload{
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
open(picture,">$Img_Dir/$msgcount-$nummsg.$sir");
binmode(picture);
print picture $buffer;
close(picture);
}
