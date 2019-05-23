<?php
error_reporting(E_ALL);
ini_set('report_errors','on');
$mysqli = new mysqli('galaxyweb.umassmed.edu', 'biocore', 'biocore2013', 'biocore');

if ($mysqli->connect_error) {
    die('Connect Error (' . $mysqli->connect_errno . ') '
            . $mysqli->connect_error);
}

$id = $_GET['id'];

$data = array();
if ($result = $mysqli->query('SELECT j.jobname, jo.jobout FROM biocore.jobs j, biocore.jobsout jo where j.wkey=jo.wkey and j.job_num=jo.jobnum and j.job_id='.$id.';'))
{

        //$data['testdata'] = mysqli_fetch_all($result,MYSQLI_ASSOC);
        while(($row=$result->fetch_assoc())){$data[]=$row;}
        $result->close();
}

header('Cache-Control: no-cache, must-revalidate');
header('Content-type: application/json');
echo json_encode($data);
exit;
