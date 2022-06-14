<?php 
$DSN='mysql:host=localhost;dbname=mazdoorhaazir-32313273ff';
$ConnectingDB = new PDO ($DSN,'root','');

// $DSN='mysql:host=sdb-u.hosting.stackcp.net;dbname=mazdoorhaazir56-3231313592';
// $ConnectingDB = new PDO ($DSN,'mazdoorhaazir','mhpmhp@123');
// try {
// 
//   // set the PDO error mode to exception
//   $ConnectingDB->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
//   echo "Connected successfully";
// } catch(PDOException $e) {
//   echo "Connection failed: " . $e->getMessage();
// }
?>