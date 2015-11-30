#!/usr/local/bin/perl

## Config Setup Webboard Program ##########
$maxpost = "50"; # คือจำนวนที่ตั้งไว้เมื่อมีเวลาคนโพสข้อความเข้ามาจำนวนทั้งหมดกี่ครั้ง
$cgi_dir ="/data1/hypermart.net/ac-118/seabra";
$My_Url="http://ac-118.hypermart.net/seabra"; # คือ ที่อยู่ของเวบคุณ
$Msg_Dir ="$cgi_dir/webboard"; # คือ Directory ที่คุณเก็บไฟฟล์ .html
$Topic_Dir="$cgi_dir/cgi-bin/webboard"; # คือ ที่ๆไว้เก็บจำนวน topic ต่างๆ คือ *.dat
$View_Dir="$cgi_dir/webboard/view"; # คือ ที่ๆไว้เก็บจำนวนคนดูกระทู้
$Vperl_Dir="$cgi_dir/webboard/cgi-bin";
$Img_Dir="$cgi_dir/webboard/images"; # คือ ที่ๆไว้เก็บรูปที่ ถูก upload มาเก็บ
$Msg_Url="$My_Url/webboard"; #คือ ที่เก็บ ไฟฟลฺ .html เป็น url ครับ ต่างจากข้างบนนะ
$Img_Url="$My_Url/webboard/images"; #คือ url ทdirectory ที่เก็บ file รูปที่ ถูก upload มา
$Logo_Url="$My_Url/webboard.swf"; #คือไฟล์โลโก้ของคุณ
$Script_Url="$My_Url/cgi-bin"; #คือที่อยู่ของ Script เป็น url นะครับ
$Vperl_Url="$My_Url/webboard/cgi-bin";
################################################### ตัวแปรเพิ่มเติมจาก club
$maxsize = "200";
$limitpage="118"; #คือ เลือกแสดงกระทู้จำนวนกี่ข้อความในแต่ละหน้า จะแสดงกระทู้ล่าสุด
$time_miss = 12; # ให้คุณแก้ไขตรง $time_miss นะครับ เป็นค่าเวลาความต่างระหว่าง server กับเวลาของเมืองไทยว่าต่างกันกี่ ชม
### Admin Board
$s_admin="hoyback";    #ตรงนี้ให้เปลี่ยนเป็น username ของคุณ (ใช้ตอนเข้ามาลบกระทู้)
$s_pass ="herkack";  #บรรทัดนี้ใส่เป็น password ที่คุณจะใช้เข้ามาแก้ครับ
####################################################################
### คุณจะต้องแก้ไขหน้าตาของเวบในกรอบของ print<<EOF  ...จนถึง EOF  ล่างสุด และใน sub HTML_HEADER เท่านั้น
## HTML_HEADER นี้คือ ส่วนหัวของเวบเพจของคุณ
###เวลาแก้ไข HEADER ให้เก็บส่วนที่เป็นตัวแปรไว้นะครับ คือ ที่มี $ นำหน้า ในส่วนของ header และ footer
sub HTML_HEADER{
&get_date;
print <<EOF;
<html>
<head>
<title>Assumption College 118 Webboard - Official Site of Assumption College 118</title>
<meta http-equiv="Content-Type" content="text/html; charset=">
<link rel=stylesheet href="$My_Url/scroll.css" type="text/css">

<style type="text/css">
<!--
a:link { color: #005CA2; text-decoration: none}
a:visited { color: #005CA2; text-decoration: none}
a:active { color: #0099FF; text-decoration: underline}
a:hover { color: #0099FF; text-decoration: underline}
.input {  font: 15px ms sans serif; color: #3399ff; 
	BORDER-BOTTOM: #3399ff solid thin;
    BORDER-LEFT: #3399ff solid thin;
    BORDER-RIGHT:#3399ff solid thin;
    BORDER-TOP: #3399ff solid thin; background: #6BDAFA ; width : 212 ; }
.button {  font: 12px ms sansserif; color: #ffffff;
	BORDER-BOTTOM: #6BDAFA solid thin;
    BORDER-LEFT: #6BDAFA solid thin;
    BORDER-RIGHT:#6BDAFA solid thin;
    BORDER-TOP: #6BDAFA solid thin; background: #3399ff ; width : 80;}

-->
</style>

<script language="JavaScript">

<!--
function openWindow() {
  popupWin = window.open('../webboard/images/index.html', 'remote','scrollbars,resizable,width=350,height=450')
}
//-->

</script>
</head>

<body bgcolor="#FFFFFF">
<center>
<table width="100%" border="1" cellspacing="1" cellpadding="0" bordercolor="#FFFFFF">
  <tr> 
    <td bgcolor="#3399FF" width="30"> 
      <div align="center"><font face="MS Sans Serif" size="1" color="#FFFFFF"><b>&gt;&gt;</b></font></div>
    </td>
    <td> 
      <table width="100%" border="1" cellspacing="0" cellpadding="0" bgcolor="#6BDAFA">
        <tr> 
          <td bordercolor="#FFFFFF">
            <div align="center"><b><font size="1" face="MS Sans Serif" color="#3399FF">&nbsp;&nbsp;&nbsp;&nbsp;Seaboard Webboard :: ถาม-ตอบปัญหาคนรักทะเล</font></b></div>
          </td>
        </tr>
      </table>
    </td>
    <td bgcolor="#3399FF" width="30"> 
      <div align="center"><font face="MS Sans Serif" size="1" color="#FFFFFF"><b>&lt;&lt;</b></font></div>
    </td>
  </tr>
</table>
       <table width="90%" border="0" cellspacing="5">
          <tr> 
            <td bgcolor="#f0f0f0"> 
              <div align="center"><font size="1" face="ms Sans Serif" color=\#3399ff> 
                <a href="$My_Url/show.shtml" target="show">กลับหน้าแรก</a></font></div>
            </td>
            <td bgcolor="#f0f0f0"> 
              <div align="center"><font size="1" face="ms Sans Serif" color=\#3399ff><a href="$Script_Url/addnew.pl?action=post">ตั้งกระทู้ใหม่</a></font></div>
            </td>
            <td bgcolor="#f0f0f0"> 
              <div align="center"><font size="1" face="ms Sans Serif" color=\#3399ff><a href="javascript:openWindow();">ลูกเล่นต่างๆ</a></font></div>
            </td>
          </tr>
          <tr bgcolor="#F0f0f0"> 
            <td colspan="3"> 
              <div align="center"><font face="verdana" size="2" color="#f0f0f0"><font color="#CCCCCC">southern seabra webboard ||| 
	<font face="ms sans serif" size=2>$date</font>
                </font></font></div>
            </td>
          </tr>
          <tr> 
            <td colspan="3"> 
              <hr size='1' width='80%'>
            </td>
          </tr>
        </table></center><center>
		<table border=0 width=85%><tr><td>
EOF
 }
 #############################################
 ### คุณจะต้องแก้ไขหน้าตาของเวบในกรอบของ print<<EOF  ...จนถึง EOF  ล่างสุด และใน sub HTML_FOOTER เท่านั้น
 ###  HTML_FOOTER นี้คือ ส่วนล่างของเวบเพจของคุณ
 sub HTML_FOOTER{
 
 print <<EOF;
</td></tr></table>
<br>
<hr size='1' width='70%'>
<div align="center"> <font size="1" face="verdana">Copyright \@2001 Assumption College SPS 10<br>
  </font> <br>

</div>
</body>
</html>

EOF
 
  }

################################################################
sub message{
	print "<font face='ms sans serif' size=2 color=#3399ff><center>\" $mesg \"<br>[--<a onclick=\"window.history.go(-1)\">Back</a>--]</center></font>";
}
#################################################################
sub get_date {
@days = ('อา','จ.','อ.','พ.','พฤ','ศ','ส');
@months = ('ม.ค.','ม.ค.','ก.พ.','มี.ค.','เม.ย.','พ.ค.','มิ.ย.','ก.ค.','ส.ค.','ก.ย.','ต.ค.','พ.ย.','ธ.ค.');
($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time+($time_miss*3600)); 
$mon++; 
if($hour < 10) { $hour = "0$hour"; }
if ($min < 10) { $min = "0$min"; }
if ($sec < 10) { $sec = "0$sec"; }

# rectify Y2K problem
$year += 2443;
$time = "$hour:$min:$sec";
$mday--;
#$date = "$days[$wday], $months[$mon] $mday, $year";
$date = "$mday $months[$mon] $year";

}
1;

