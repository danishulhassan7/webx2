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
        $Admin = $_SESSION["AdminName"];
        $sql = "UPDATE comments SET status='OFF', approvedby='$Admin' WHERE id='$SearchQueryParameter'";
        $Execute = $ConnectingDB->query($sql);
        if ($Execute) {
          $_SESSION["SuccessMessage"]="Comment Dis-Approved Successfully ! ";
          Redirect_to("Comments.php");
        }else {
          $_SESSION["ErrorMessage"]="Something Went Wrong. Try Again !";
          Redirect_to("Comments.php");
        }
      }


?>