<?php
error_reporting(E_ALL);
set_time_limit(0);

$address = "127.0.0.1";
$port = 7777;
$i = 0;
$arr = array();

$mysqli = new mysqli("localhost","root","root","StudentsDB");

//创建端口
$sock = socket_create(AF_INET, SOCK_STREAM, SOL_TCP) or die("socket_create() failed :reason:" . socket_strerror(socket_last_error()) . "\n");

//绑定
socket_bind($sock, $address, $port) or die("socket_bind() failed :reason:" . socket_strerror(socket_last_error($sock)) . "\n");

//监听
socket_listen($sock, 5) or die("socket_bind() failed :reason:" . socket_strerror(socket_last_error($sock)) . "\n");

do {
	//得到一个链接
	if (($msgsock = socket_accept($sock)) === false) {
		echo "socket_accepty() failed :reason:" . socket_strerror(socket_last_error($sock)) . "\n";
		break;
	}
	//welcome  发送到客户端
	$msg = "hello";
	socket_write($msgsock, $msg, strlen($msg));
	// read client message
	do {
		$buf = socket_read($msgsock, 8192);
		if (!$buf) {
			break;
		}

		if (strstr($buf,"SELECT")) {
			$result = $mysqli -> query($buf);
			while ($row = $result -> fetch_assoc()) {
				$arr[$i]["st_name"] = $row["st_name"];
				$arr[$i]["st_gender"] = $row["st_gender"];
				$arr[$i]["st_age"] = $row["st_age"];
				$arr[$i]["st_studentID"] = $row["st_studentID"];
				$i ++;
			}

			$json = json_encode(array(
				"message" => "success",
				"data" => $arr,
			));
		}
		if ($json) {
			$talkback = $json;
		}
		else {
			$talkback = "none";
		}
		if (false === socket_write($msgsock, $talkback, strlen($talkback))) {
			echo "socket_write() failed reason:" . socket_strerror(socket_last_error($sock)) ."\n";
		} else {
			echo 'send success';
		}
	} while(true);
	
	socket_close($msgsock);
} while(true);
//关闭socket
socket_close($sock);

?>