#!/usr/local/bin/perl

$cgi_dir = "/data1/hypermart.net/ac-118/seabra/cgi-bin/counter";
#$cgi_dir = "d:\web ac118\cgi-bin\counter";
$cgi_url = "http://ac-118.hypermart.net/seabra/cgi-bin/counter";
#$cgi_url = "d:\web ac118\cgi-bin\counter";
$counter = "counter.txt";
	open(CT,"$cgi_dir/$counter");
	$count = <CT>;
	close(CT);

	$count++;

	open(CT,">$cgi_dir/$counter");
	print CT "$count";
	close(CT);



	if ($count< 10) {$count = "0000$count";}
	elsif ($count < 100){$count = "000$count";} 
	elsif ($count < 1000){$count = "00$count";} 
	elsif ($count < 10000){$count = "0$count";} 

@count_array = split(//,$count);
$max=@count_array;
print "Content-type:text/html\n\n"; 

	for($i=0;$i<$max;$i++){
		if ($i<4) {
				print "<img src=\"$cgi_url/$count_array[$i]\.gif\" BORDER=0>";
		}
		elsif ($i==4) {
				print "<img src=\"$cgi_url/l_$count_array[$i]\.gif\" BORDER=0>";
		}
	}

