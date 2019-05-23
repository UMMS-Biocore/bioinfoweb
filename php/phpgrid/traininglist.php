<?php
/**
 * PHP Grid Component
 *
 * @author Abu Ghufran <gridphp@gmail.com> - http://www.phpgrid.org
 * @version 1.4.6
 * @license: see license.txt included in package
 */
 
// set up DB
$conn = mysql_connect("localhost", "bioinfo", "bioinfo2013");
mysql_select_db("bioinfo");

// set your db encoding -- for ascent chars (if required)
mysql_query("SET NAMES 'utf8'");

// include and create object
include("php/phpgrid/inc/jqgrid_dist.php");
$g = new jqgrid();

// set few params
$grid["caption"] = "Training List";
$grid["multiselect"] = true;
$grid["export"] = array("format"=>"xlsx", "filename"=>"my-file", "sheetname"=>"test");
$grid["export"] = array("format"=>"pdf", "filename"=>"my-file", "heading"=>"Invoice Details", "orientation"=>"landscape");
$g->set_options($grid);

$g->set_actions(array(	
						"add"=>true, // allow/disallow add
						"edit"=>true, // allow/disallow edit
						"delete"=>true, // allow/disallow delete
						"rowactions"=>true, // show/hide row wise edit/del/save option
						"export"=>true, // show/hide export to excel option
						"autofilter" => true, // show/hide autofilter for search
						"search" => "advance" // show single/multi field search condition (e.g. simple or advance)
					) 
				);
// set database table for CRUD operations
$g->table = "traininglist";

// subqueries are also supported now (v1.2)
// $g->select_command = "select * from (select * from invheader) as o";
// render grid

$out = $g->render("list");
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
