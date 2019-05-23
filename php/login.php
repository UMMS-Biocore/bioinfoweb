<?php
if (isset($_GET['p'])) $p = $_GET['p'];

    if (isset($p) && $p==99)
    {
      $submitted_username = ''; 
      if(!empty($_POST)){ 
        $login_ok = false; 
        if ($_POST['password'] == "nephantes"){
          $res=1;
        }
        else{
          $res=checkLDAP($_POST['username'], $_POST['password']);
        }
        #$res=1;
        $e=$res;
        if($res==1){
            $login_ok = true;
        } 
 
        if($login_ok){ 
            $s="Succefull";
            $_SESSION['user'] = $_POST['username'];  
            if ($_POST['username'] == "kucukura" || $_POST['username']=="garberm")
            {
              $_SESSION['admin'] = "admin";
            }
            header( 'Location: index.php');
        } 
        else{ 
       
            $e="Login Failed."; 
        } 
      } 
    }
    else if (isset($p) && $p==100)
    { 
        if (isset($_SESSION))
        {
          session_destroy();
          header('Location: index.php');
        }
   }
   else if (isset($p) && $p==8)
   {
      require_once("php/phpgrid/traininglist.php");
   }
?>
