<?
error_reporting(E_ALL);
ini_set('report_errors','on');
$mysqli = new mysqli('galaxyweb.umassmed.edu', 'biocore', 'biocore2013', 'biocore');
if ($mysqli->connect_error) {
    die('Connect Error (' . $mysqli->connect_errno . ') '
            . $mysqli->connect_error);
}

$id = $_GET['id'];

$data = array();
if ($result = $mysqli->query(' 
Select CONCAT("id_", CAST(j.job_id AS CHAR)) id, j.job_id num, jobname title,
j.job_num, TIME_TO_SEC(timediff(j.end_time, j.start_time)) duration, 
 j.result result, submit_time submit, j.start_time start, j.end_time finish from 
jobs j, service_run sr where sr.wkey=j.wkey and sr.service_id=j.service_id and sr.service_run_id='.$id.'
order by start;
'))
{

        //$data['testdata'] = mysqli_fetch_all($result,MYSQLI_ASSOC);
        while(($row=$result->fetch_assoc())){$data[]=$row;}
        $result->close();
}


header('Cache-Control: no-cache, must-revalidate');
header('Content-type: application/json');
echo json_encode($data);
exit;
