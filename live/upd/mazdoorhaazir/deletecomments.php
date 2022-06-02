<!-- Including a Connection of Database (db.php) -->
<?php require_once("includes/db.php");?>
<!-- Including a Function from functions.php  -->
<?php require_once("includes/functions.php");?>
<!-- Including a Session file sessions.php  -->
<?php require_once("includes/sessions.php");?>

<?php 

    if(isset($_GET["id"])){
        $SearchQueryParameter = $_GET["id"];
        global $ConnetingDB;
        $sql = "DELETE FROM comments WHERE id='$SearchQueryParameter'";
        $Execute = $ConnectingDB->query($sql);
        if ($Execute) {
          $_SESSION["SuccessMessage"]="Comment Deleted Successfully ! ";
          Redirect_to("comments.php");
        }else {
          $_SESSION["ErrorMessage"]="Something Went Wrong. Try Again !";
          Redirect_to("comments.php");
        }
      }


?>