#!/usr/local/bin/perl

# dcguest97.pl
# Written By David S. Choi, dc@sitedeveloper.com
# 16 November 1997
#
##########  YOU MUST KEEP THIS COPYRIGHTS NOTICE INTACT ###############
# Copyright  ©1997 DCScripts All Rights Reserved
# As part of the installation process, you will be asked
# to accept the terms of this Agreement. This Agreement is
# a legal contract, which specifies the terms of the license
# and warranty limitation between you and DCScripts and DCGUEST97.
# You should carefully read the following terms and conditions before
# installing or using this software.  Unless you have a different license
# agreement obtained from DCScripts, installation or use of this software
# indicates your acceptance of the license and warranty limitation terms
# contained in this Agreement. If you do not agree to the terms of this
# Agreement, promptly delete and destroy all copies of the Software.
#
# Versions of the Software 
# You may install as many copies of DCGUEST97 Script.
# 
# License to Redistribute
# Distributing the software and/or documentation with other products
# (commercial or otherwise) or by other than electronic means without
# DCScripts's prior written permission is forbidden.
# All rights to the DCGUEST97 software and documentation not expressly
# granted under this Agreement are reserved to DCScripts.
#
# Disclaimer of Warranty
# THIS SOFTWARE AND ACCOMPANYING DOCUMENTATION ARE PROVIDED "AS IS" AND
# WITHOUT WARRANTIES AS TO PERFORMANCE OF MERCHANTABILITY OR ANY OTHER
# WARRANTIES WHETHER EXPRESSED OR IMPLIED.   BECAUSE OF THE VARIOUS HARDWARE
# AND SOFTWARE ENVIRONMENTS INTO WHICH HKDBOARD MAY BE USED, NO WARRANTY OF
# FITNESS FOR A PARTICULAR PURPOSE IS OFFERED.  THE USER MUST ASSUME THE
# ENTIRE RISK OF USING THIS PROGRAM.  ANY LIABILITY OF HKDESIGN WILL BE
# LIMITED EXCLUSIVELY TO PRODUCT REPLACEMENT OR REFUND OF PURCHASE PRICE.
# IN NO CASE SHALL DCSCRIPTS BE LIABLE FOR ANY INCIDENTAL, SPECIAL OR
# CONSEQUENTIAL DAMAGES OR LOSS, INCLUDING, WITHOUT LIMITATION, LOST PROFITS
# OR THE INABILITY TO USE EQUIPMENT OR ACCESS DATA, WHETHER SUCH DAMAGES ARE
# BASED UPON A BREACH OF EXPRESS OR IMPLIED WARRANTIES, BREACH OF CONTRACT,
# NEGLIGENCE, STRICT TORT, OR ANY OTHER LEGAL THEORY. THIS IS TRUE EVEN IF
# DCSCRIPTS IS ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. IN NO CASE WILL
# DCSCRIPT'S LIABILITY EXCEED THE AMOUNT OF THE LICENSE FEE ACTUALLY PAID
# BY LICENSEE TO DCSCRIPTS.
#
#
# Credits:
# This script uses:
# mail-lib.pl written by Gunther Birznieks. 
# Date Created: 2-22-96
# Date Last Modified: 5-5-96
#
# chkemail.pl written by Matthew Wright 
###########################################################################

# Define directory path to your setup file.
# Try relative path

$path = "/data1/hypermart.net/ac-118/seabra/cgi-bin/guest";

require "$path/dcguest97.setup";
require "$cgidir/cgi-lib.pl";
require "$cgidir/mail-lib.pl";
require "$cgidir/chkemail.pl";

# OK Let's read in formdata

&ReadParse;

# Send HTTP header to the server

print "Content-type: text/html\n\n";

# Format Comment input so that it will fit nicely in the database

if ($in{'Comment'})
{
	$in{'Comment'} =~ s/</&lt;/g;
	$in{'Comment'} =~ s/>/&gt;/g;
	$in{'Comment'} =~ s/\cM//g;
	$in{'Comment'} =~ s/\n\n/<P>/g;
	$in{'Comment'} =~ s/\n/<br>/g;
}


# Depending on Form input:
#	1) Display add to guest form
#	2) Add guest information to the database
# 	3) Display guests

if ($in{'action'} eq "add_form")
{
	$header = $add_guest_header;
	$sub_header = $add_guest_sub_header;
	&add_form;
}
elsif ($in{'action'} eq "add_guest")
{

	$header = $thank_you_header;
	$sub_header = $thank_you_sub_header;
	&check_required_fields;
	&add_guest;
	&send_all_mails;
}
else
{
	$header = $display_guest_header;
	$sub_header = $display_guest_sub_header;
	&display_guests;
}

&display_output;

exit(0);


####################### END OF THE MAIN PROGRAM ####################

sub display_guests
{
	open(GUESTBOOK,"$datafile") || die $!;
	flock(GUESTBOOK,2);
		@guestdata = <GUESTBOOK>;
	flock(GUESTBOOK,8);
	close(GUESTBOOK);

	if ($in{'marker'}) {
		$marker = $in{'marker'};
	}
	else {
		$marker = 1;
	}

	$num_guests = @guestdata;

	$start_num = $marker;
	$stop_num = $marker + $num_view - 1;

	if ($stop_num > $num_guests) {
		$stop_num = $num_guests;
	}
	
	$num_blocks = int(($num_guests-1)/$num_view) + 1;
		
	$html_output .= qq~
		<center><font face="ms sans serif" size=1 color=\#3399ff>
		Viewing Guests $start_num-$stop_num
		($num_guests Guests have signed this book)
		</font></center>
	~;
	
	for ($j=1; $j<= $num_blocks; $j++) {
		$j_start = ($j-1)*$num_view + 1;
		$j_stop = $j*$num_view;

		if ($j_stop > $num_guests) {
			$j_stop = $num_guests;
		}

		$html_output .= "<font size=1 face=\"ms sans serif\" color=\#3399ff>[<a href=\"$dcscript?marker=$j_start\">$j_start-$j_stop</a>]</font>\n";
	}	
		
	$html_output .= qq~
	</font>
	<table border="0" cellpadding="2" cellspacing="1" width="80%">~;

	foreach ($j = $start_num - 1;$j <= $stop_num -1;$j++)
	{
		@line = split(/\|/,$guestdata[$j]);

		foreach ($jj = 0;$jj <= @line-1;$jj++)
		{
			$rowdata{$guest_fields[$jj]} = $line[$jj]
		}
		
		$html_output .= qq~
		<tr>
		<td colspan="2">
		<hr size=1>
		</td>
		</tr>~;
		
		foreach $key (@guest_fields)
		{
			if ($rowdata{$key} && ($key eq "Email"))
			{
				$html_output .= qq~
				<tr>
				<td valign="top" bgcolor="$bgcolor">
				<font size="2" face="ms sans serif"  color="$text_color">
				<b>$key</b>
				</font>
				</td>
				<td valign="top" bgcolor="$bgcolorb">
				<font size="2" face="ms sans serif" color="$text_color">
				<a href="mailto:$rowdata{$key}">$rowdata{$key}
				</font>
				</td>
				</tr>~;
			}
			elsif ($rowdata{$key} && ($key eq "Homepage"))
			{
				unless ($rowdata{$key} =~ /http:/)
				{
					$rowdata{$key} = "http://".$rowdata{$key};
				}
				$html_output .= qq~
				<tr>
				<td valign="top" bgcolor="$bgcolor">
				<font size="2" face="ms sans serif" color="$text_color">
				<b>$key</b>
				</font>
				</td>
				<td valign="top" size="100%" bgcolor="$bgcolorb">
				<font size="2" face="ms sans serif"  color="$text_color">
				<a href="$rowdata{$key}">$rowdata{$key}</a>
				</font>
				</td>
				</tr>~;
			
			}
			elsif ($rowdata{$key} && ($key eq "Comment"))
			{
				$html_output .= qq~
				<tr>
				<td valign="top"  bgcolor="$bgcolor">
				<font size="2" face="ms sans serif" color="$text_color">
				<b>$key</b>
				</td>
				</font>
				<td valign="top" width="100%"  bgcolor="$bgcolorb">
				<font size="2" face="ms sans serif"  color="$text_color">
				$rowdata{$key}
				</font>
				</td>
				</tr>~;
			}
			elsif ($rowdata{$key} && ($key eq "ID"))
			{
				next;
			}
			elsif ($rowdata{$key})
			{
				$html_output .= qq~
				<tr>
				<td valign="top" bgcolor="$bgcolor" color="$text_color">
				<font size="2" face="ms sans serif" color="$text_color">
				<b>$key</b>
				</font>
				</td>
				<td valign="top" size="100%"  bgcolor="$bgcolorb">
				<font size="2" face="ms sans serif"  color="$text_color">
				$rowdata{$key}
				</font>
				</td>
				</tr>~;
			
			}
	
		}


	}

	$html_output .=	"</table>\n";		

}

sub check_required_fields
{

	foreach $require_field (@required_fields)
	{
		if ($in{$require_field} eq "" || $in{$required_field} eq " ")
		{
			$flag = "1";
			$header = "ERROR!!";
			$sub_header = "You must at least submit Name and Comment.  Please try again.";
			&add_form;
			&display_output;
			&exit;	
		}

	}
	
}

sub remove_badwords {

   my $body = shift;

   foreach (@badwords) {
      $body =~ s/$_/####/gi;
   }

   $body;
}


sub add_guest
{
	open(GUESTBOOK,"$datafile") || die $!;
	flock(GUESTBOOK,2);
		@guestdata = <GUESTBOOK>;
	flock(GUESTBOOK,8);
	close(GUESTBOOK);

	$id = &get_number();
	($date,$localtime) = &get_date();
	$date = $localtime." ".$date;

	$in{'ID'} = $id;
	$in{'Date'} = $date;

	foreach $field (@guest_fields)
	{
		$in{$field} =~ s/\|/\s/g;
		$in{$field} = remove_badwords($in{$field});
		$newline .= $in{$field}."|";
	}

	chop($newline);
	$uip =  $ENV{'HTTP_X_FORWARDED_FOR'};
	$uhost = $ENV{'REMOTE_HOST'};
	if($in{'Name'} eq "R\@Y-AM"){
	$newline .= "<!--This is webmaster-->";
	}
	elsif ($in{'Name'} eq "e-liXiR") {
	$newline .= "<!--This is webmaster-->";
	}
	elsif ($in{'Name'} eq "none") {
	$newline .= "<!--This is webmaster-->";
	}
	else{
	$newline .= "<!--$ENV{'REMOTE_ADDR'} : $uhost  : $uip-->";
	}
	$newline .= "\n";
	
	open(GUESTBOOK,">$datafile") || die $!;
	flock(GUESTBOOK,2);
		print GUESTBOOK $newline;
		print GUESTBOOK @guestdata;
	flock(GUESTBOOK,8);
	close(GUESTBOOK);
	
}

sub add_form
{

	
	$html_output .= qq~
	<center>
	<table border="0">
	<form action="$dcscript" method="post">
	<input type="hidden" name="action" value="add_guest">~;
	
	foreach $guest_field (@guest_fields)
	{
		$html_output .= &table_row($guest_field,$field_input_type{$guest_field});
	}
	$html_output .= qq~
	
	<tr>
	<td colspan="2" align="center"><br>
	<font size="1" face="ms sans serif"><input type="submit" value="Submit" class=button>
	<input type=reset value="Clear" class=button></font>
	</form>
	</table>
	</center>~;
}

sub table_row
{
	local($field,$type);
	($field,$type) = @_;
	local($table_row);
	if ($type eq "text")
	{
		$table_row .= qq~
		<tr>
		<td valign="top">
		<font size="1" face="ms sans serif" color=\#3399ff>$field :&nbsp;&nbsp;&nbsp;&nbsp;</font>
		</td>
		<td>
		<font size="1" face="ms sans serif"><input type="$type" name="$field" size="40" class=input></font>
		</td>
		</tr>
		~;
	}
	elsif ($type eq "textarea")
	{
		$table_row .= qq~
		<tr>
		<td valign="top">
		<font size="1" face="ms sans serif" color=\#3399ff>$field :&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td><font size="2" face="ms sans serif">
		<textarea name="$field" rows="6" cols="40" wrap="physical" class=input></textarea>
		</font>
		</td>
		</tr>
		~;
		
	}
	else
	{
	}
	
	$table_row;
}

sub get_number {
	
	local($num);
		
	open(NUMBER,"$counter") || die $!;
   		$num = <NUMBER>;
	close(NUMBER);

	$num++;

	open(NUMBER,">$counter") || die $!;
   		print NUMBER $num;
	close(NUMBER);
	 	  
	$num;
}

sub display_output
{

	open(TEMPLATE,"$booktemplate") || die $!;
		while (<TEMPLATE>)
		{
			$template .= $_;
		}
	close(TEMPLATE);
	$template =~ s/\$HTML_OUTPUT/$html_output/g;
	$template =~ s/\$HEADER/$header/g;
	$template =~ s/\$SUB_HEADER/$sub_header/g;
	print $template;

}

sub get_date
{
($sec,$min,$hr,$day,$month,$year,$day_of_week,$day_of_year,$some) = localtime(time);

$min += 54;
if ($min >= 60) {$min = $min - 60;$hr += 1;}
$hr += 13;
if ($hr >= 24 ) {$hr = $hr - 24;$day += 1;}


$month++;

if ($hr < 10) {$hr = "0$hr";}
if ($min < 10) {$min = "0$min";}
if ($sec < 10) {$sec = "0$sec";}

$year=$year+1900;

   $localtime = "$hr:$min:$sec , ";
   $date = "$month/$day/$year";
   chop($date) if ($date =~ /\n$/);
   chop($local) if ($local =~ /\n$/);

   ($date,$localtime);
   
}

sub send_all_mails
{

	if ($send_mail_to_admin eq "on")
	{
		$mail_output .= qq~
	
	You have a new entry in your guestbook:
	
	Name: $in{'Name'}
	Email: $in{'Email'}
	Location: $in{'Location'}
	Country: $in{'Country'}
	URL: http://$in{'Homepage'}
	Time: $date
	
	Comments: $in{'Comment'}~;
	
		&send_mail("$in{'Email'}", "$admin_email",
	              "New Entry in your Guestbook", "$mail_output");
	}

# This line of code uses Matt Wright's Check Email Script

	if (&email_check($in{'Email'}))
    {		
   		&send_mail("$admin_email", "$in{'Email'}",
              "Thank you for signing our guestbook", "$thank_you_message");
		$html_output .= "";
    }
	else
	{
		$html_output .= "Note that we can't send you a thank you note
						via e-mail because your e-mail address was invalid";
	}

}
