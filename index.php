<?php
require_once("php/conf.php");
require_once("php/config.php");
require_once("php/auth.php");
require_once("php/login.php");
    

?>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="google-site-verification" content="rwz1FJP_NEa3csgcWaNc5GrTegvL8xxj3Hu-sVc0RnQ" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
   
    <title>Bioinformatics Core</title>
    <!-- Bootstrap core CSS -->
    <link href="dist/css/bootstrap.css" rel="stylesheet">
    <script src="dist/lib/jquery-1.7.2.min.js" type="text/javascript"></script>
    <!--cupertino  dark-hive  dot-luv  excite-bike  flick  jquery-ui.custom.min.js  redmond  smoothness  start  ui-darkness  ui-lightness-->
    <link rel="stylesheet" type="text/css" media="screen" href="php/phpgrid/js/themes/flick/jquery-ui.custom.css"></link>	
    <link rel="stylesheet" type="text/css" media="screen" href="php/phpgrid/js/jqgrid/css/ui.jqgrid.css"></link>	
    <?if(isset($p) && $p==8){?>
    <script src="php/phpgrid/js/jqgrid/js/i18n/grid.locale-en.js" type="text/javascript"></script>
    <script src="php/phpgrid/js/jqgrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>	
    <script src="php/phpgrid/js/themes/jquery-ui.custom.min.js" type="text/javascript"></script>
    <?}?>
  </head>
  <body>
    
    <?php
    include("content/menu.html");
    if (!isset($p) || (isset($p) && ($p==0 || $p == "")))
    {
	include("content/mainjumbo.html");
    }
    ?>
<br/>
<br/>
<div class="container">
   <?php
			

		      if (!isset($p) || (isset($p) && $p==0 || $p == ""))
		      {
				include("content/main.html");
	              }
                      else
		      {
		        $query = "SELECT * FROM navigation ORDER BY pid";
                        try {
	                   $sth = $db->prepare($query);
	                   $sth->execute();
                        } 
                        catch(PDOException $ex){ die("Failed to run query: " . $ex->getMessage()); }
			$arrValues = $sth->fetchAll();
                       
                        foreach ($arrValues as $row){
			    if ($p==$row["pid"])
			    {
				include($row["include_file"]);
			    }
			}
		      }

  ?>
      <hr>
<?php
    if (isset($s)) echo "<div class=\"alert alert-success\">".$s."</div>";  
    elseif (isset($e)) echo "<div class=\"alert alert-danger\">".$e."</div>";  
?>
      <footer>
        <p>&copy; BioCore 2015</p>
      </footer>

    </div> <!-- /container -->
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->

    <script src="dist/js/bootstrap.min.js"></script>
  </body>
</html>
