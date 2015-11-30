#!/usr/local/bin/perl
#
# dclinks98admin.cgi
# Written By David S. Choi, dc@sitedeveloper.com
# 5 Feb 1998
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
# CREDITS = This script uses Matt Wright's cookie.lib library file
# You can get you free copy at www.worldwidemart/scripts --
#
###########################################################################

# Define directory path to this script
# If relative path will work leave it as is

$path = "/data1/hypermart.net/ac-118/seabra/cgi-bin/guest";

# inlcude library files...
# NOTE---YOU MUST REQUIRE DCGUEST97.SETUP BEFORE DCGUEST97ADMIN.SETUP----

require "$path/dcguest97.setup";
require "$path/dcguest97admin.setup";

# $cgidir is defined in dcguest97.setup

require "$cgidir/cgi-lib.pl";
require "$cgidir/cookie.lib";

# ----------------- Shouldn't have to change anything below here --------------#

# Read in Form data

&ReadParse;

# If Password file doesn't exist, create one
# with username dcscripts and password dcscripts

&check_password_file;

print "Content-type: text/html\n";

if ($in{'change_password'}) {
	print "\n";
	&change_password_form;
	&display_output;
	exit(0);
}

$action = $in{"action"};
&check_password;

if ($action eq "list") {

	print "\n";
   &display_links;

} elsif ($action eq "remove") {

	print "\n";
	$header = $display_removedone_header;
	$sub_header = $display_removedone_sub_header;
	&remove_links;

} elsif ($action eq "change_password") {

	&change_password;

	print "\n";

   $header = $display_change_header;
   $header = $display_change_sub_header;
   &logon;
	
} else {

	print "\n";
	$header = $display_main_header;
	$sub_header = $display_main_sub_header;
	&display_main;

}

&display_output;

exit(0);


###
### subroutine display_main
###

sub display_main {

	$html_output .= qq~
	<li><a href="$adminurl?action=list">Remove Guest Entries</a>
	<li><a href="$adminurl?change_password=not_empty">Change your Username and Password</a>
	~;

}


###
### subroutine remove_links
###

sub remove_links {

	@records = split(/\0/,$in{'records'});

	open(G,"$datafile") || die $!;
	flock(G,2);
		@guestdata = <G>;
	flock(G,8);
	close(G);

	$new_links = "";
	
	$html_output .= qq~
	<table border="0" cellpadding="2" width="425">
				<tr>
					<th bgcolor="$bgcolor">
						<font face="MS Sans Serif" size="2" color="black">Message Posted By</font>
					</th>
					<th bgcolor="$bgcolor">
						<font face="MS Sans Serif" size="2" color="black">Message</font>
					</th>
				</tr>
	~;

	foreach (@guestdata) {

		chop($_) if ($_ =~ /\n$/);

		@row = split(/\|/,$_);			
		$hit = "no";

		foreach ($j = 0;$j <= @row-1;$j++) {
			$rowdata{$guest_fields[$j]} = $row[$j];
		}

		foreach $record (@records) {

			if ($rowdata{"ID"} == $record) {
				$hit="yes";

				$html_output .= qq~
				<tr>
					<td bgcolor="$bgcolor">
						<font face="MS Sans Serif" size="2" color="black">$rowdata{"Name"}</font>
					</td>
					<th bgcolor="$bgcolor">
						<font face="MS Sans Serif" size="2" color="black">$rowdata{"Comment"}</font>
					</th>
				</tr>
				~;
				$last;
			}

		}
		
		unless ($hit eq "yes") {
			$new_links .= "$_\n";
		}

	}


	$html_output .= qq~
	</table>
	~;

		open(LINKSDATA,">$datafile") || die $!;
		flock(LINKSDATA,2);
			print LINKSDATA $new_links;
		flock(LINKSDATA,8);
		close(LINKSDATA);

}

###
###
### subroutine display_links
###
###


sub display_links {

	if ($in{'type'}) {
		$type = "radio";
		$todo = "edit_form";
		$submit_value = "Edit Selected Link";
		$header = $display_edit_header;
		$sub_header = $display_edit_sub_header;
	} else {
		$type = "checkbox";
		$todo = "remove";
		$submit_value = "Remove Links";
		$header = $display_remove_header;
		$sub_header = $display_remove_sub_header;
	}
	
	open(LINKSDATA,"$datafile") || die $!;
	flock(LINKSDATA,2);
		@linksdata = <LINKSDATA>;
	flock(LINKSDATA,8);
	close(LINKSDATA);

	$html_output .= qq~
	<form action="$adminurl" method="post">
	<input type="hidden" name="action" value="$todo">

	<table border="0" cellpadding="2" width="425">
	<tr>
		<th bgcolor="$bgcolor">
			<font face="MS Sans Serif" size="2" color="black">Select</font>
		</th>
		<th bgcolor="$bgcolor">
			<font face="MS Sans Serif" size="2" color="black">Posted by</font>
		</th>
		<th bgcolor="$bgcolor">
			<font face="MS Sans Serif" size="2" color="black">Comment</font>
		</th>
	</tr>

	~;
	
		foreach $line (@linksdata) {
			@row = split(/\|/,$line);
	
			foreach ($j = 0;$j <= @row-1;$j++) {
				$rowdata{$guest_fields[$j]} = $row[$j];
			}
			$html_output .= "<tr>\n";
			$html_output .= &list_record($type,@rowdata);
			$html_output .= "</tr>\n";
		}

		
	$html_output .= qq~
	</table>
	<p align="center">
	<input type="submit" value="$submit_value">
	<input type="reset" value="Reset Form">	
	</p>
	</form>
	~;
}

###
###
### subroutine change_password_form
###
###

sub change_password_form {

	$header = "Change Password and Username";
	$sub_header = "Complete following form to Change your username and password";
	
	$html_output .= qq~
	
	<form action="$adminurl" method="post">
	<input type="hidden" name="action" value="change_password">
	<table border="0" align="center">
	<tr>
		<th>
		Old Username: 
		</th>
		<td>
		<input type="text" name="username" width="40">
		</td>
	</tr>
	<tr>
		<th>
		New Username:
		</th>
		<td>
		<input type="text" name="new_username" width="40">
		</td>
	</tr>
	<tr>
		<th>
		Old Password: 
		</th>
		<td>
		<input type="password" name="password" width="40">
		</td>
	</tr>
	<tr>
		<th>
			New Password:
		</th>
		<td>
			<input type="password" name="new_password1" width="40">
		</td>
	</tr>
	<tr>
		<th>
			New Password:
		</th>
		<td>
		 <input type="password" name="new_password2" width="40">
		</td>
	</tr>

	<tr>
		<td>
		&nbsp;
		</td>
		<td align="left">
			<input type="submit" value="Change Now">
			<input type="reset" value="Reset">
		</td>
	</tr>
	</table>

	</form>
~;
}

###
###
### subroutine display_logon
###
###


sub display_logon {

	$html_output .= qq~
	
	<form action="$adminurl" method="post">
	<input type="hidden" name="action" value="logon">
	<table border="0" align="center">
	<tr>
		<th>
		Username:
		</th>
		<td>
		 <input type="text" name="username" width="40">
		</td>
	</tr>
	<tr>
		<th>
			Password:
		</th>
		<td>
			<input type="password" name="password" width="40">
		</td>
	</tr>
	<tr>
		<td>
		&nbsp;
		</td>
		<td align="left">
			<input type="submit" value="Logon">
		</td>
	</tr>
	</table>
	</form>
~;

}

###
###
### subroutine display_password
###
###

sub display_output {

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

###
###
### subroutine change_password
###
###

sub change_password {

	if (!$in{'username'}) {

       &error(no_username);

	} elsif (!$in{'password'}) {

       &error(no_password);

	}

	$username = $in{'username'};
	$new_username = $in{'new_username'};
	$password = $in{'password'};
	$new_password1 = $in{'new_password1'};
	$new_password2 = $in{'new_password2'};

	open(PASSWORD,"$password_file") || &error(password_file);
		$username_password = <PASSWORD>;
		chop($username_password) if ($username_password =~ /\n$/);
	close(PASSWORD);

   ($orig_username,$orig_password) = split(/:/,$username_password);
   
   $test = my_crypt($password, substr($password, 0, 2));

	if (!($test eq $orig_password && $orig_username eq $username)) {

      	&error(bad_combo);

	} elsif ($new_password1 ne $new_password2) {

		&error('not_same');

	} else {

		$new_password = my_crypt($new_password1, substr($new_password1, 0, 2));
		$username_password = join(":",$new_username,$new_password);
		
		open(PASSWORD,">$password_file") || &error(password_file);
			print PASSWORD "$username_password\n";
   	close(PASSWORD);

		&SetCookies('username',$new_username,'password',$new_password);

	}

   print "\n";
	
}


###
###
### subroutine check_password
###
###

sub check_password {

	open(PASSWORD,"$password_file") || &error(password_file);
		$username_password = <PASSWORD>;
      	chop($username_password) if $username_password =~ /\n$/;
   	close(PASSWORD);

	($orig_username,$orig_password) = split(/:/,$username_password);

	if ($in{'action'} eq "logon") {

			if (!$in{'username'}) {
				&error(no_username);
			}
			elsif (!$in{'password'}) {
		       &error(no_password);
			}
			
			$test = my_crypt($in{'password'}, substr($in{'password'}, 0, 2));
	
			if (!($test eq $orig_password && $in{'username'} eq $orig_username)) {
		      &error(bad_combo);
			}
			
			&SetCookies('username',$in{'username'},'password',$test);
	}
	elsif (&GetCookies('username','password')) {

		$username = $Cookies{'username'};
		$password = $Cookies{'password'};

		if (!($password eq $orig_password && $username eq $orig_username)) {
	      &error(bad_combo);
		}

	} else {
		
			&logon;		
	}
	
}

sub logon {
	print "\n";
	$header = $display_logon_header;
	$sub_header = $display_logon_sub_header;
	&display_logon;
	&display_output;
	exit(0);
}


sub error {

   $error = $_[0];

	print "\n";

    if ($error eq 'bad_combo') {
      $header = "Bad Username Password Combo";
      $sub_header = "You entered Bad Username-Password Combination.<br>  Go Back and Try Again";
    }
   elsif ($error eq 'password_file') {
      $header = "Could Not Open Password File For Reading";
      $sub_header = "Could not open the password file for reading!<br> Check permissions and try again.";
   }
   elsif ($error eq 'no_username') {
      $header = "No Username";
      $sub_header = "You forgot to enter username.  Go back and try again.";
   }
   elsif ($error eq 'no_password') {
      $header = "No Password";
      $sub_header = "You forgot to enter Password.  Go back and try again.";
    }
   elsif ($error eq 'not_same') {
      $header = "Incorrect Password Type-In";
      $sub_header = "The passwords you typed in for your new password were not the same.";
      $sub_header .= "<br>You may have mistyped, please try again.\n";
   }
   elsif ($error eq 'no_change') {
      $header = "Could Not Open Password File For Writing";
      $sub_header = "Could not open the password file for writing!  Password not changed!";
   }

   &display_output;
   exit(0);
}

sub check_password_file {

	if (!(-e "$password_file")) {

	   	$username = "dcscripts";
   		$password = my_crypt("dcscripts", substr("dcscripts", 0, 2));
   		$username_password = join(":",$username,$password);

			open(PASSWORD,">$password_file") || &error(password_file);
				print PASSWORD "$username_password\n";
			close(PASSWORD);
	}
}



sub list_record {

	local($type,@rowdata) = @_;
	local($output);
	
	foreach $key (@guest_fields){
		
		if ($rowdata{$key} && ($key eq "Comment")) {

				$output .= qq~
				<td valign="top" bgcolor="$bgcolor">
				<font size="2" face="ms sans serif" color="black">
				<B>
				$rowdata{$key}
				</B>
				</font>
				</td>
				~;
			}
			elsif ($key eq "Name") {

				$output .= qq~
				<td valign="top" bgcolor="$bgcolor" align=center>
				<font size="2" face="ms sans serif">
				<input type="$type" name="records" value="$rowdata{'ID'}">
				</font>
				</td>
				<td valign="top" bgcolor="$bgcolor">
				<font size="2" face="ms sans serif" color="black">$rowdata{$key}</font>
				</font>
				</td>
				~;			
			}
	
		}
	
	$output;
}

sub my_crypt {

	local($arg1, $arg2) = @_;
	local($arg);

# For winNT system, comment out following line

	$arg = crypt($arg1,$arg2);

# For winNT system, uncomment collowing line
#	$arg1;

}