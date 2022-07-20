<?php require_once("includes/functions.php");?>
<!-- Including a Session file sessions.php  -->
<?php require_once("includes/sessions.php");?>

<?php 
     $_SESSION["UserId"]=null;
     $_SESSION["UserName"]=null;
     $_SESSION["AdminName"]=null;

     session_destroy();
     Redirect_to("login.php");
?>