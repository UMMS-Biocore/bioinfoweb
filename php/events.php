<?php
// List of events
 require_once("config.php");
 $json = array();

 // Query that retrieves events
 $query = "SELECT * FROM events ORDER BY id";

 try {
	$sth = $db->prepare($query);
	$sth->execute();
     } 
catch(PDOException $ex){ die("Failed to run query: " . $ex->getMessage()); } 


 // sending the encoded result to success page
 echo json_encode($sth->fetchAll());

?>
