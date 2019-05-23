<?php

$url = "http://galaxy.umassmed.edu/api/users";
$json = file_get_contents($url);
$json_data = json_decode($json, true);
echo "My token: ". $json_data["Email"];

?>
