<?php if($action!="post"&&$action!="add"&$action!="reply"):

include("board_dsp.php");

endif;?>

<?php if($action=="post"): //˹���ʴ�Ẻ form �ͧ webboard?>

<?php include("board_form.php");?>

<?php endif;?>

<?php 

if($action =="add"){
	

	$topic = stripslashes($topic);
	$name = stripslashes($name);
	$email = stripslashes($email);
	$comment = stripslashes($comment);
	$picture = stripslashes($picture);



	//�����ӹǹ��з��ŧ� numtopic.txt
	$filename="numtopic.txt";
	$data = file($filename);
	$data[0]++;
	$numtopic = $data[0];

	//��¹�����Ţͧ board ŧ� 00..$numtopic.txt
	$comment = ereg_replace("\n","<br>",$comment);

	if ($data[0]< 10) {$data[0] = "0000$data[0]";}
	elseif ($data[0] < 100){$data[0] = "000$data[0]";} 
	elseif ($data[0] < 1000){$data[0] = "00$data[0]";} 
	else {$data[0] = "0$data[0]";} 
	
	if($picture!=""&&$picture_size){
		if($picture_size){
			if($picture_size>25000){
				echo "<html><body onload=\"alert('�Ҿ�բ�Ҵ�˭��Թ 250 kb ��Ѻ');window.location='webboard.php';\"></body></html>";
				exit;
			}
			if($picture_type == "image/pjpeg" || $picture_type == "image/gif" || $picture_type == "image/bmp"){
				if($picture_type == "image/pjpeg"){ $imgsur = "jpg";}
				else if ($picture_type == "image/gif"){ $imgsur = "gif";}
				else if ($picture_type == "image/bmp"){ $imgsur = "bmp";}
				copy($picture,"webboard/".$data[0].".".$imgsur);
				$pass = 1;
			}
			else{
				echo "<html><body onload=\"alert('�����س�����������ٻ�Ҿ��Ѻ');window.location='webboard.php';\"></body></html>";
				exit;
			}
		}
	}

	//��¹����������ǡѺ��Ǣ��ŧ� topic.txt
	$date = date("H:i:s , d/m/Y");
	$ip = $REMOTE_ADDR;
	$towrite = $data[0]."\t".$topic."\t".$name."\t".$date."\t".$ip."\n";
	
	if($pass == 1){
		$pict = $data[0].".".$imgsur;
	}

	$topost = $topic."\t".$name."\t".$date."\t".$comment."\t".$pict."\t".$ip."\t".$email."\n";

	$fp = fopen("topic.txt","a");
	fputs($fp,$towrite);
	fclose($fp);

	$fc = fopen("webboard/$data[0].txt","a");
	fputs($fc,"$topost");
	fclose($fc);

	$fe = fopen("$filename","w");
	fwrite($fe,"$numtopic");
	fclose($fe);

	$fd = fopen("webboard/num$data[0].txt","a");
	fputs($fd,"0"."\n"."0\n"."no reply");
	fclose($fd);

	//��¹ ip ŧ� ipcheck.txt
	$ipArray = file("ipcheck.txt");
	$ipToSave = $name."\t".$ip;
	$already=0;
	for($i=0;$i<sizeof($ipArray);$i++){
		$ipArray[$i] = eregi_replace("\n","",$ipArray[$i]);
		if($ipToSave == $ipArray[$i]){
			$already = 1;
			break;
		}
	}
	if($already==0){
		$ipToSave=$ipToSave."\n";
		$fd = fopen("ipcheck.txt","a");
		fputs($fd,$ipToSave);
		fclose($fd);
	}
	// end ip check zone


	echo "<html><body onload=\"alert('���Ѻ�����Ţͧ�س���º�������Ǥ�Ѻ');window.location='brd_main.php';\"></body></html>";


}

?>


<?php 

if($action =="reply"){
	

	$name = stripslashes($name);
	$email = stripslashes($email);
	$comment = stripslashes($comment);
	$picture = stripslashes($picture);
	$date = date("H:i:s , d/m/Y");
	$date2 = date("d/m/Y");
	$ip = $REMOTE_ADDR;
	


	//�����ӹǹ���ͺŧ� num$number.txt
	$count = file("webboard/num$number.txt");
	$count[0] = eregi_replace("\n","",$count[0]);
	$count[1] = eregi_replace("\n","",$count[1]);
	$count[1]++;

	//��¹�����Ţͧ board ŧ� $number.txt
	$comment = ereg_replace("\n","<br>",$comment);

	if($picture!=""&&$picture_size){
		if($picture_size){
			if($picture_size>25000){
				echo "<html><body onload=\"alert('�Ҿ�բ�Ҵ�˭��Թ 250 kb ��Ѻ');window.location='brd_shw.php?number=$number';\"></body></html>";
				exit;
			}
			if($picture_type == "image/pjpeg" || $picture_type == "image/gif" || $picture_type == "image/bmp"){
				if($picture_type == "image/pjpeg"){ $imgsur = "jpg";}
				else if ($picture_type == "image/gif"){ $imgsur = "gif";}
				else if ($picture_type == "image/bmp"){ $imgsur = "bmp";}
				copy($picture,"webboard/".$number."-".$count[1].".".$imgsur);
				$pass = 1;
			}
			else{
				echo "<html><body onload=\"alert('�����س�����������ٻ�Ҿ��Ѻ');window.location='brd_shw.php?number=$number';\"></body></html>";
				exit;
			}
		}
	}

	//��¹����������ǡѺ��õͺ��з��ŧ� $number.txt
	
	if($pass == 1){
		$pict = $number."-".$count[1].".".$imgsur;
	}

	$toreply = $name."\t".$date."\t".$comment."\t".$pict."\t".$ip."\t".$email."\n";

	$fc = fopen("webboard/$number.txt","a");
	fputs($fc,"$toreply");
	fclose($fc);

	//��¹����������ǡѺ��� update  ��������ӹǹ���ͺ��з��ŧ���� num$number.txt
	$count[2] = $name."\t".$date2;

	$fa = fopen("webboard/num$number.txt","w");
	
	$tocount = $count[0]."\n".$count[1]."\n".$count[2];
	
	fputs($fa,$tocount);
	fclose($fa);

	//��¹ ip ŧ� ipcheck.txt
	$ipArray = file("ipcheck.txt");
	$ipToSave = $name."\t".$ip;
	$already=0;
	for($i=0;$i<sizeof($ipArray);$i++){
		$ipArray[$i] = eregi_replace("\n","",$ipArray[$i]);
		if($ipToSave == $ipArray[$i]){
			$already = 1;
			break;
		}
	}
	if($already==0){
		$ipToSave=$ipToSave."\n";
		$fd = fopen("ipcheck.txt","a");
		fputs($fd,$ipToSave);
		fclose($fd);
	}
	// end ip check zone

	echo "<html><body onload=\"alert('���Ѻ�����Ţͧ�س���º�������Ǥ�Ѻ');window.location='brd_shw.php?number=$number';\"></body></html>";


}

?>