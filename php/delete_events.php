<?php
require_once("config.php");

/* Values received via ajax */
$id = $_POST['id'];

$sql = "DELETE from events WHERE id=".$id;
$q = $db->prepare($sql);
$q->execute();
?>
