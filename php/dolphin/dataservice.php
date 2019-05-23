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
SELECT CONCAT("id_", CAST(sr.service_run_id AS CHAR)) id, sr.service_run_id num,  s.servicename title,
 TIME_TO_SEC(timediff(sr.end_time, sr.start_time)) duration, sp.percentComplete, sr.start_time start, sr.end_time finish, sr.result result
  FROM biocore.workflow_run wr, biocore.service_run sr, services s,
(Select a.service_run_id, (jobFinished/jobCount)*100 percentComplete
FROM
(SELECT sr.service_run_id, count(j.job_id) jobCount
FROM workflow_run w, jobs j, service_run sr
where j.wkey=w.wkey and sr.wkey=j.wkey and sr.service_id=j.service_id and w.workflow_run_id='.$id.'
group by sr.service_id) a,
(SELECT sr.service_run_id, count(j.job_id) jobFinished
FROM workflow_run w, jobs j, service_run sr
where j.wkey=w.wkey and sr.wkey=j.wkey and sr.service_id=j.service_id and w.workflow_run_id='.$id.' and j.result=3
group by sr.service_id) b
where a.service_run_id=b.service_run_id) sp
  where sr.wkey=wr.wkey and s.service_id=sr.service_id and sp.service_run_id=sr.service_run_id 
  and wr.workflow_run_id='.$id.' order by sr.start_time;
'))
{

        //$data['testdata'] = mysqli_fetch_all($result,MYSQLI_ASSOC);
        while(($row=$result->fetch_assoc())){$data[]=$row;}
        $result->close();
}


header('Cache-Control: no-cache, must-revalidate');
header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
header('Content-type: application/json');
echo json_encode($data);
exit;
