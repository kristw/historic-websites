#!/usr/bin/perl
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
###################################################

require "config.pl";
print "Content-type:text/html\n\n";
&FormInput(*input);
$list = $input{'list'};
$page = $input{'page'};

$date_del = `date +"%D"`; chop($date_del);

open( DATEFILE , "$Msg_Dir/date.dat" );
$datefile = <DATEFILE>;
close( DATEFILE );

if ($date_del ne $datefile) {

unlink<$Msg_Dir/ipreply/*.dat>;
unlink<$Msg_Dir/ip/*.dat>;

open (DATEFILE,">$Msg_Dir/date.dat");
print DATEFILE "$date_del";
close(DATEFILE);
}

&HTML_HEADER;

print <<EOF;

<SCRIPT LANGUAGE="JavaScript" src="http://www.popuptraffic.com/assign.php?l=ac118"></script> 
<SCRIPT LANGUAGE="JavaScript" src="http://www.popuptraffic.com/assign.php?l=ac118&mode=behind"> </script>


EOF

open( MSGFILE ,"$Topic_Dir/topic.dat");
@msgdata = <MSGFILE>;
close( MSGFILE );
@msgdata=reverse( @msgdata );
$size = @msgdata;
$numtopic = $size + 1;
$sum=$size/$limitpage;

#ตรวจสอบคำสั่งเลื่อนหน้า
if ($size>$limitpage) { 
 	print "<div align=right><font size=1 face=\"ms sans serif\">แสดงกระทู้หน้าละ $limitpage >> ";
		for($i=0; $i<$sum; $i++) {
			$j=$i;
			$j++;
			if ($i<1) { 
				print "[ <a href=\"webboard.pl\">หน้าแรก</a> ]"; 
			} else {
				print "[ <a href=\"webboard.pl?page=$i\">";
				print "$j</a> ]";
				} 
  		}
	print "</font></div>";
}

 if ($page) { 
 	$limitpage2=$limitpage*$page;
	$_=$limitpage2+$limitpage;
	for($i=0; $i<$size; $i++){
	$numtopic--; 
		if (($i>=$limitpage2) && ($i<$_)){ 
			@display = split(/\|\|\|\|/,$msgdata[$i]);
			if ($display[1] ne "") {
				print "<font size=1 face=\"ms sans serif\"><BR><IMG SRC='$My_Url/webboard/i_mesg.gif' HEIGHT=14 WIDTH=11> - <font color=#006699>$display[0]</font>- <A HREF='$My_Url/webboard\/$display[1]' target=_blank>$display[2]</A> - <font COLOR=\#003399>$display[3]</FONT> <font size=1> \[$display[4]\]</font>$display[5]</font>";
				&checknum;  		
			}
		} 
	}
}
else { 
	for($i=0; $i<$size; $i++){
			$numtopic--;
				@display = split(/\|\|\|\|/,$msgdata[$i]);
			if ($display[1] ne "") {
				print "<font size=1 face=\"ms sans serif\"><BR><IMG SRC='$My_Url/webboard/i_mesg.gif' HEIGHT=14 WIDTH=11> - <font color=#006699>$display[0]</font>- <A HREF='$My_Url/webboard\/$display[1]' target=_blank>$display[2]</A> - <font COLOR=\#003399>$display[3]</FONT> <font size=1> \[$display[4]\]</font>$display[5]</font>";
			}
				&checknum;  
	}
} 

########################
sub checknum{
	if ($numtopic< 10) {$numtopic = "0000$numtopic";}
	elsif ($numtopic < 100){$numtopic = "000$numtopic";} 
	elsif ($numtopic < 1000){$numtopic = "00$numtopic";} 
	else {$numtopic = "0$numtopic";} 
	$FNAME = "$Topic_Dir/$display[0].dat";
	$FILE_NAME="$FNAME";
	open (NUMMSG,"$FILE_NAME") ;
	$nummsg = <NUMMSG>;
	close(NUMMSG);   
 	if ($nummsg ne ""){  
		print "<font size=2 face=\"MS Sans Serif\">\(<b>$nummsg</b>\) </font>"; 
	}
	$VNAME = "$View_Dir/$display[0].dat";
	$VFILE_NAME="$VNAME";
	open (VIEWMSG,"$VFILE_NAME");
	$viewmsg = <VIEWMSG>;
	close(VIEWMSG);
	if ($viewmsg ne "") {
		print "<font size=2 face=\"MS Sans Serif\">\(<b>$viewmsg</b>\)</font>"; 
	}
}

 
&HTML_FOOTER;

sub FormInput
{
local (*qs) = @_ if @_;

if ($ENV{'REQUEST_METHOD'} eq "GET")
        {
        $qs = $ENV{'QUERY_STRING'};
        }
elsif ($ENV{'REQUEST_METHOD'} eq "POST")
        {
        read(STDIN,$qs,$ENV{'CONTENT_LENGTH'});
        }

@qs = split(/&/,$qs);

foreach $i (0 .. $#qs)
        {
        $qs[$i] =~ s/\+/ /g;
        $qs[$i] =~ s/%(..)/pack("c",hex($1))/ge;

        ($name,$value) = split(/=/,$qs[$i],2);

        if($qs{$name} ne "")


                {
                $qs{$name} = "$qs{$name}:$value";
                }
        else
                {
                $qs{$name} = $value;
                }
        }
}