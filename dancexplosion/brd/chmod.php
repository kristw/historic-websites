<?php 
	if($action=="check"){
		chmod ("webboard/$filename.txt",0777);
		echo " success ";
	}
?>
	
	<html>
		<body>
			<form method=post action="chmod.php">
			<input type=hidden value=check name=action>
			filename : <input type=text name=filename><br>
			<input type=submit>
			</form>
		</body>
	</html>

