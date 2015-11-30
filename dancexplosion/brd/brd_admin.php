<?php
	if(!$action):
?>

		<html>
			<body>
				<font color="#ff9900" size="2" face="Microsoft Sans Serif"><strong>Intania 87 Webboard Administrator Area</strong></font><br>
				<br>
				<form method=post action="brd_admin.php"><input type=hidden name=action value="process">
				<table width="95%" border="0" cellspacing="0" cellpadding="0">
				  <tr> 
					<td width="21%"><font color="#0099ff" size="2" face="Microsoft Sans Serif">Topic 
					  Number </font></td>
					<td width="2%"><div align="center"><font color="#0099ff" size="2" face="Microsoft Sans Serif">:</font></div></td>
					<td width="77%"><input name="numtopic" type="text" id="numtopic"></td>
				  </tr>
				  <tr> 
					<td><font color="#0099ff" size="2" face="Microsoft Sans Serif">Admin Username</font></td>
					<td><div align="center"><font color="#0099ff" size="2" face="Microsoft Sans Serif">:</font></div></td>
					<td><input name="username" type="text" id="username"></td>
				  </tr>
				  <tr> 
					<td><font color="#0099ff" size="2" face="Microsoft Sans Serif">Password</font></td>
					<td><div align="center"><font color="#0099ff" size="2" face="Microsoft Sans Serif">:</font></div></td>
					<td><input name="password1" type="password" id="password1"></td>
				  </tr>
				  <tr> 
					<td><font color="#0099ff" size="2" face="Microsoft Sans Serif">Confirm Password 
					  </font></td>
					<td><div align="center"><font color="#0099ff" size="2" face="Microsoft Sans Serif">:</font></div></td>
					<td><input name="password2" type="password" id="password2"></td>
				  </tr>
				</table>
				<br>
				<input type="submit" name="Submit" value="Submit">
				<input type="reset" name="Submit2" value="Reset">
				</form>
			</body>
		</html>


<?php
	endif;
	
	if($action=="process"){
		if($password1==$password2){
			if($username=="elx"&&$password1=="hoyback"){
				if(strlen($numtopic)==5){
					$stud = file("topic.txt");
					$nummy = $numtopic-1;
					if($stud[$nummy]){
						if(substr($stud[$nummy],0,1)!="*"){
							$stud[$nummy]="*".$stud[$nummy];
							$fp = fopen("topic.txt","w");
							for($i=0;$i<sizeof($stud);$i++){
								fputs($fp,$stud[$i]);
							}
							chmod("webboard/$numtopic.txt",0777);
							rename("webboard/$numtopic.txt","webboard/del$numtopic.txt");
							echo "topic was deleted successfully";
						}
						else {
							echo "topic was deleted before";
						}
					}
					else{
						echo "topic not found";
					}
				}
				else{
					echo "topic not valid";
				}
			}
			else{
				echo "you are not admin.";
			}
		}
		else{
			echo "password does not match";
		}
	}

?>

