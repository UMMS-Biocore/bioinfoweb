<?
error_reporting(E_ALL);
ini_set('report_errors','on');
$mysqli = new mysqli('galaxyweb.umassmed.edu', 'biocore', 'biocore2013', 'biocore');
if ($mysqli->connect_error) {
    die('Connect Error (' . $mysqli->connect_errno . ') '
            . $mysqli->connect_error);
}
$user = $_GET['u'];

$data = array();
if ($result = $mysqli->query('
 SELECT CONCAT("id_", CAST(wr.workflow_run_id AS CHAR)) id, wr.workflow_run_id num, workflowname title,
 TIME_TO_SEC(timediff(end_time, start_time)) duration,
 result, s.percentComplete, start_time start, end_time finish
 FROM biocore.workflow_run wr, biocore.workflows w,
   (select a.workflow_run_id, if( (serviceSuccess/totalServices)*100 >=100, 100,
    (serviceSuccess/totalServices)*100) percentComplete
    FROM (SELECT w.workflow_run_id, w.services totalServices
            FROM workflow_run w
            WHERE w.username="'.$user.'") a,
         (SELECT w.workflow_run_id, count(s.service_run_id) serviceRunCount
            FROM service_run s, workflow_run w
            WHERE w.username="'.$user.'" and s.wkey=w.wkey group by w.workflow_run_id ) b,
         (SELECT w.workflow_run_id, count(s.service_run_id) serviceSuccess
            FROM service_run s, workflow_run w where w.username="'.$user.'" and s.result=1 and s.wkey=w.wkey group by w.workflow_run_id) c
            WHERE a.workflow_run_id=b.workflow_run_id and a.workflow_run_id=c.workflow_run_id and b.workflow_run_id=c.workflow_run_id) s
    WHERE w.workflow_id=wr.workflow_id and wr.username="'.$user.'" and s.workflow_run_id=wr.workflow_run_id order by start_time desc;
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
