
<!-- Including a Connection of Database (db.php) -->
<?php require_once("includes/db.php");?>

<!-- Creating a Redirection function  -->

<?php

function Redirect_to($New_Location){
    header("Location:".$New_Location);
    exit;
}

// Creating a function to validate the already existence of USERNAME  (Admins.php)

function CheckUserNameExistOrNot($UserName){
    global $ConnectingDB;
    $sql  = "SELECT username FROM admins WHERE username=:userName";
    $stmt = $ConnectingDB->prepare($sql);
    $stmt->bindValue(':userName',$UserName);
    $stmt->execute();
    $Result = $stmt->rowcount();
    if($Result==1){
        return true;
    } else {
        return false;
    }
}

// Creating a function to validate the already existence of email  (UserLogin.php)

function CheckEmailExistOrNot($Email){
    global $ConnectingDB;
    $sql  = "SELECT email FROM users WHERE email=:email";
    $stmt = $ConnectingDB->prepare($sql);
    $stmt->bindValue(':email',$Email);
    $stmt->execute();
    $Result = $stmt->rowcount();
    if($Result==1){
        return true;
    } else {
        return false;
    }
}
// For ADMIN 
function Login_Attempt($UserName,$Password){
     // Query to authenicate the Admin from the Database 
     global $ConnectingDB; // creating a global variable of DB connection (Because if php has previous release of before 5.7)
     $sql = "SELECT * FROM admins WHERE username=:userName AND password=:passWord LIMIT 1";
     $stmt =  $ConnectingDB->prepare($sql);
     $stmt->bindValue(':userName',$UserName);
     $stmt->bindValue(':passWord',$Password);
     $stmt->execute();
     $Result = $stmt->rowcount();
     if ($Result==1) {
        return $Found_Account=$stmt->fetch();
     }else {
        return null;
     }
}

// For User 

function Login_Attempt_User($Email,$Password){
    // Query to authenicate the Admin from the Database 
    global $ConnectingDB; 
    $sql = "SELECT * FROM users WHERE email=:email AND password=:passWord LIMIT 1";
    $stmt =  $ConnectingDB->prepare($sql);
    $stmt->bindValue(':email',$Email);
    $stmt->bindValue(':passWord',$Password);
    $stmt->execute();
    $Result = $stmt->rowcount();
    if ($Result==1) {
       return $Found_Account=$stmt->fetch();
    }else {
       return null;
    }
}
// For Admin 
function Confirm_Login() {
    if(isset($_SESSION["UserId"])){
        return true;
    }else {
        echo "Hello";
        $_SESSION["ErrorMessage"]= "Login Required ! ";
        Redirect_to("Login.php");
    }
}

// For User
function Confirm_Login_User() {
    if(isset($_SESSION["UserId"])){
        return true;
    }else {
        $_SESSION["ErrorMessage"]= "Login Required ! ";
        Redirect_to("Login.php");
    }
}

// Dashboard File functions 

function TotalPosts() {
    global $ConnectingDB;
    $sql = "SELECT COUNT(*) FROM posts";
    $stmt = $ConnectingDB->query($sql);
    $TotalRows = $stmt->fetch();
    $TotalPosts = array_shift($TotalRows);
    echo $TotalPosts;
}

function TotalCategories() {
    global $ConnectingDB;
    $sql = "SELECT COUNT(*) FROM category";
    $stmt = $ConnectingDB->query($sql);
    $TotalRows = $stmt->fetch();
    $TotalCategories = array_shift($TotalRows);
    echo $TotalCategories;
}

function TotalAdmins() {
    global $ConnectingDB;
    $sql = "SELECT COUNT(*) FROM admins";
    $stmt = $ConnectingDB->query($sql);
    $TotalRows = $stmt->fetch();
    $TotalAdmins = array_shift($TotalRows);
    echo $TotalAdmins;
}

function TotalComments() {
    global $ConnectingDB;
    $sql = "SELECT COUNT(*) FROM comments";
    $stmt = $ConnectingDB->query($sql);
    $TotalRows = $stmt->fetch();
    $TotalComments = array_shift($TotalRows);
    echo $TotalComments;
}



function ApproveCommentsAccordingToPost($PostId){
    global $ConnectingDB;
    $sqlApprove = "SELECT COUNT(*) FROM comments
    WHERE  post_id = '$PostId' AND status='ON'";
    $stmtApprove = $ConnectingDB->query($sqlApprove);
    $RowsTotal = $stmtApprove->fetch();
    $Total = array_shift($RowsTotal);
    return $Total;
}

function DisApproveCommentsAccordingToPost($PostId){
    global $ConnectingDB;
    $sqlDisApprove = "SELECT COUNT(*) FROM comments
    WHERE  post_id = '$PostId' AND status='OFF'";
    $stmtDisApprove = $ConnectingDB->query($sqlDisApprove);
    $RowsTotal = $stmtDisApprove->fetch();
    $Total = array_shift($RowsTotal);
    return $Total;
 }

?>