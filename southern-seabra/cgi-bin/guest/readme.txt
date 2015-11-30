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
###########################################################################

Thank you for trying out our script.  If you have any suggestions, please direct
them to suggest@sitedeveloper.com


DCGuest97 contains following files:

1) dcguest97.cgi (755)		- main script
2) dcguest97.setup (644)	- setup file
3) guestbook.htmlt (644) 	- template file
4) cgi-lib.pl (644)			- library file
5) mail-lib.pl (644)		- library file
6) chkemail.pl (644)		- library file

7) guestbook.txt (666)	- guest database
8) guestcount.txt (666)	- guest counter

-----------------------------------------------------------------
Setting up DCGuest97

Editing dcguest97.cgi - all you need to do is edit $path statement.
Try relative path.  That is

$path = ".";

If it doesn't work, just use the absolute directory path.


Editing dcguest97.setup - you will need to modify most of the variables
defined in this file.

-----------------------------------------------------------------
Installing DCGuest97

- Create a directory in your cgi-bin named dcguest97 and upload files 1-4
- Chmod dcguest97.cgi to 755
- Create a sub directory under dcguest97 named Data and set permission to 777
- Upload guestbook.txt and guestcount.txt to 666

- Make sure you use ASCII mode when you transfer these files
- Make sure your data directory is set to 777

THAT's ALL FOLKS>>>>

-----------------------------------------------------------------------

To view your guestbook, user http://www.yourdomain/cgi-bin_path/dcguest97.cgi

-------------------------------------------------------------------