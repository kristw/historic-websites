#!/usr/local/bin/perl

## Config Setup Webboard Program ##########
$maxpost = "50"; # ��ͨӹǹ������������������Ҥ��ʢ�ͤ�������Ҩӹǹ������������
$cgi_dir ="/data1/hypermart.net/ac-118/seabra";
$My_Url="http://ac-118.hypermart.net/seabra"; # ��� �������ͧ�Ǻ�س
$Msg_Dir ="$cgi_dir/webboard"; # ��� Directory ���س��俿�� .html
$Topic_Dir="$cgi_dir/cgi-bin/webboard"; # ��� ��������纨ӹǹ topic ��ҧ� ��� *.dat
$View_Dir="$cgi_dir/webboard/view"; # ��� ��������纨ӹǹ���١�з��
$Vperl_Dir="$cgi_dir/webboard/cgi-bin";
$Img_Dir="$cgi_dir/webboard/images"; # ��� ����������ٻ��� �١ upload ����
$Msg_Url="$My_Url/webboard"; #��� ����� 俿�� .html �� url ��Ѻ ��ҧ�ҡ��ҧ����
$Img_Url="$My_Url/webboard/images"; #��� url �directory ����� file �ٻ��� �١ upload ��
$Logo_Url="$My_Url/webboard.swf"; #����������ͧ�س
$Script_Url="$My_Url/cgi-bin"; #��ͷ������ͧ Script �� url �Ф�Ѻ
$Vperl_Url="$My_Url/webboard/cgi-bin";
################################################### �������������ҡ club
$maxsize = "200";
$limitpage="118"; #��� ���͡�ʴ���з��ӹǹ����ͤ��������˹�� ���ʴ���з������ش
$time_miss = 12; # ���س��䢵ç $time_miss �Ф�Ѻ �繤�����Ҥ�����ҧ�����ҧ server �Ѻ���Ңͧ���ͧ����ҵ�ҧ�ѹ��� ��
### Admin Board
$s_admin="hoyback";    #�ç����������¹�� username �ͧ�س (��͹�����ź��з��)
$s_pass ="herkack";  #��÷Ѵ�������� password ���س������������Ѻ
####################################################################
### �س�е�ͧ���˹�ҵҢͧ�Ǻ㹡�ͺ�ͧ print<<EOF  ...���֧ EOF  ��ҧ�ش ���� sub HTML_HEADER ��ҹ��
## HTML_HEADER ����� ��ǹ��Ǣͧ�Ǻྨ�ͧ�س
###������� HEADER �������ǹ����繵�������Ф�Ѻ ��� ����� $ ��˹�� ���ǹ�ͧ header ��� footer
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
            <div align="center"><b><font size="1" face="MS Sans Serif" color="#3399FF">&nbsp;&nbsp;&nbsp;&nbsp;Seaboard Webboard :: ���-�ͺ�ѭ�Ҥ��ѡ����</font></b></div>
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
                <a href="$My_Url/show.shtml" target="show">��Ѻ˹���á</a></font></div>
            </td>
            <td bgcolor="#f0f0f0"> 
              <div align="center"><font size="1" face="ms Sans Serif" color=\#3399ff><a href="$Script_Url/addnew.pl?action=post">��駡�з������</a></font></div>
            </td>
            <td bgcolor="#f0f0f0"> 
              <div align="center"><font size="1" face="ms Sans Serif" color=\#3399ff><a href="javascript:openWindow();">�١��蹵�ҧ�</a></font></div>
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
 ### �س�е�ͧ���˹�ҵҢͧ�Ǻ㹡�ͺ�ͧ print<<EOF  ...���֧ EOF  ��ҧ�ش ���� sub HTML_FOOTER ��ҹ��
 ###  HTML_FOOTER ����� ��ǹ��ҧ�ͧ�Ǻྨ�ͧ�س
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
@days = ('��','�.','�.','�.','��','�','�');
@months = ('�.�.','�.�.','�.�.','��.�.','��.�.','�.�.','��.�.','�.�.','�.�.','�.�.','�.�.','�.�.','�.�.');
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

