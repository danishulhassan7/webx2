<!-- Including a Connection of Database (db.php) -->
<?php require_once("includes/db.php");?>
<!-- Including a Function from functions.php  -->
<?php require_once("includes/functions.php");?>
<!-- Including a Session file sessions.php  -->
<?php require_once("includes/sessions.php");?>

<!-- This Script for User Login Form  -->
<?php
if(isset($_SESSION["UserId"])){
    Redirect_to("#");
}
if(isset($_POST["submit"])){
  $Email        = $_POST["email"];
  $Password        = $_POST["password"];


  if(empty($Email)||empty($Password)){
    $_SESSION["ErrorMessage"]= "All fields must be filled out";
    Redirect_to("UserLogin.php");
  }else{
    // Query to authenicate the Admin from the Database 
    $Found_Account = Login_Attempt_User($Email,$Password);
    if ($Found_Account) {
        $_SESSION["UserId"]=$Found_Account["id"];
        $_SESSION["Email"]=$Found_Account["email"];
        $_SESSION["UserName"]=$Found_Account["username"];
        $_SESSION["SuccessMessage"] = "Wellcome ".$_SESSION["UserName"]." ! ";
        if(isset($_SESSION["TrackingURL"])){
            Redirect_to($_SESSION["TrackingURL"]);
        }else {
            Redirect_to("#");
        }
    }else {
        $_SESSION["ErrorMessage"] = "Incorrect Email OR Password";
        Redirect_to("UserLogin.php");
    }
  }
  } //Ending of Submit Button If-Condition
  ?>

<!-- This Script for Registration Form  -->
<?php
if(isset($_POST["Submit"])){
  $UserName        = $_POST["Username"];
  $Email            = $_POST["Email"];
  $Password        = $_POST["Password"];
  $ConfirmPassword = $_POST["ConfirmPassword"];
  
  // Creating Date and Time Functions
  date_default_timezone_set("Asia/Karachi");
  $CurrentTime = time();
  $DateTime = strftime("%B %d, %Y %H:%M:%S",$CurrentTime);

  if(empty($UserName)|| empty($Email)|| empty($Password)||empty($ConfirmPassword)){
    $_SESSION["ErrorMessage"]= "All fields must be filled out";
    Redirect_to("UserLogin.php");
  }elseif (is_numeric($UserName)) {
    $_SESSION["ErrorMessage"]= "Name should be string";
    Redirect_to("UserLogin.php");
  }elseif (strlen($Password)<6) {
    $_SESSION["ErrorMessage"]= "Password should be greater than 5 characters";
    Redirect_to("UserLogin.php");
  }elseif ($Password !== $ConfirmPassword) {
    $_SESSION["ErrorMessage"]= "Password and Confirm Password should match";
    Redirect_to("UserLogin.php");
  }elseif (CheckEmailExistOrNot($Email)) {
    $_SESSION["ErrorMessage"]= "This email exists already, Please try another one";
    Redirect_to("UserLogin.php");
  }else{
    // Query to insert NEW ADMIN in Database when everything is fine
    global $ConnectingDB; // creating a global variable of DB connection (Because if php has previous release of before 5.7)
    $sql = "INSERT INTO users(datetime,username,password,email)";
    $sql .= "VALUES(:dateTime,:userName,:password,:email)";
    $stmt =  $ConnectingDB->prepare($sql);
    $stmt->bindValue(':dateTime',$DateTime);
    $stmt->bindValue(':userName',$UserName);
    $stmt->bindValue(':password',$Password);
    $stmt->bindValue(':email',$Email);

    $Execute=$stmt->execute();

    if($Execute){
        $_SESSION["SuccessMessage"] = "New User with the name of ".$UserName." registers Succesfully";
        Redirect_to("UserLogin.php");
    }else {
        $_SESSION["ErrorMessage"] = "Something went Wrong, Try Again";
        Redirect_to("UserLogin.php");
    }
  }
} //Ending of Submit Button If-Condition
 ?>


<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Important Meta Tags -->
    <!-- Required meta tags always come first -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <!-- Description Meta Tag  -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description"
        content="Mazdoor Haazir is a platform that connects customers to the skilled, experienced and reliable service professionals in their own locality. “Mazdoor Haazir” is the one-stop destination for all areas needs which includes cemetery, concrete laborers at your doorstep." />
    <meta name="keywords"
        content="MazdoorHaazir, Online Labour, Cemetery, Labour, Local Labour, Mazdoor, Mistri, Karachi" />
    <meta name="author" content="MazdoorHaazir" />
    <meta name="email" content="danishulhassan7@gmail.com" />
    <!-- BootStrap CSS  -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <!-- Font awesome -->
    <script src="https://kit.fontawesome.com/97acf97beb.js"></script>
    <!-- Google Fonts  -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <!-- BootStrap-Social  -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-social/5.1.1/bootstrap-social.min.css">
    <link rel="stylesheet" href="css/style.css">
    <title>Sign in | Sign up</title>
    <!-- Adding Icon in title  -->
    <link rel="icon" href="fav-icon.svg" type="img/svg-icon">
</head>

<body>

    <section>

        <div class="main-container">
            <div class="forms-container">
                <div class="signin-signup">
                    <!-- Form 1 Sign In (Login) -->
                    <form class="sign-in-form" action="UserLogin.php" method="POST">
                        <h2 class="title">Sign In</h2>
                        <div class="input-field">
                            <i class="fas fa-user"></i>
                            <input type="email" placeholder="Email" name="email">
                        </div>
                        <div class="input-field">
                            <i class="fas fa-lock"></i>
                            <input type="password" placeholder="Password" name="password">
                        </div>
                        <input type="submit" value="Login" class="button solid" name="submit">
                        <p class="social-text">Or Sign in with Social Apps</p>
                        <div class="social-media">
                            <a href="#" class="social-icon">
                                <i class="fab fa-facebook-f"></i>
                            </a>
                            <a href="#" class="social-icon">
                                <i class="fab fa-twitter"></i>
                            </a>
                            <a href="#" class="social-icon">
                                <i class="fab fa-google"></i>
                            </a>
                            <a href="#" class="social-icon">
                                <i class="fab fa-linkedin-in"></i>
                            </a>
                        </div>
                    </form>

                    <!-- form 2 Sign Up (Registration)-->
                    <form action="UserLogin.php" method="POST" class="sign-up-form">
                        <h2 class="title">Sign Up</h2>
                        <div class="input-field">
                            <i class="fas fa-user"></i>
                            <input type="text" placeholder="User Name" name="Username" id="username">
                        </div>
                        <div class="input-field">
                            <i class="fas fa-envelope"></i>
                            <input type="email" placeholder="Email" name="Email" id="email">
                        </div>
                        <div class="input-field">
                            <i class="fas fa-lock"></i>
                            <input type="password" placeholder="Password" name="Password" id="password">
                        </div>
                        <div class="input-field">
                            <i class="fas fa-lock"></i>
                            <input type="password" placeholder="Confirm Password" name="ConfirmPassword" id="cpassword">
                        </div>
                        <input type="submit" value="Sign up" class="button solid" name="Submit">
                        <p class="social-text">Or Sign up with Social Apps</p>
                        <div class="social-media">
                            <a href="#" class="social-icon">
                                <i class="fab fa-facebook-f"></i>
                            </a>
                            <a href="#" class="social-icon">
                                <i class="fab fa-twitter"></i>
                            </a>
                            <a href="#" class="social-icon">
                                <i class="fab fa-google"></i>
                            </a>
                            <a href="#" class="social-icon">
                                <i class="fab fa-linkedin-in"></i>
                            </a>
                        </div>
                    </form>
                    <br>
                    <div class="container">
        <div class="row">
            <div class="col-12">
            <!-- Adding a php file to call functions (SESSION) -->
                  <?php 
                    echo ErrorMessage();
                    echo SuccessMessage();
                    ?>
            </div>
        </div>
    </div>
                </div>
            </div>

            <div class="panels-container">
                <!-- Panel 1 for (Sign Up-Registration) -->
                <div class="panel left-panel">
                    <div class="content">
                        <h3>New here ? </h3>
                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Dignissimos quae cumque.</p>
                        <button type="button" class="button transparent" id="sign-up-btn"><strong>Sign up</strong></button>
                    </div>
                    <img src="svg-img/login.svg" class="image" alt="Login">
                </div>

                <!-- Panel 2 for Sign-up (Login) -->
                <div class="panel right-panel">
                    <div class="content">
                        <h3>One of us ? </h3>
                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Dignissimos quae cumque.</p>
                        <button type="button" class="button transparent" id="sign-in-btn"><strong>Sign in</strong></button>
                    </div>
                    <img src="svg-img/signup.svg" class="image" alt="Registration">
                </div>
            </div>
        </div>
    </section>


    <!-- First jquery, then popper and in last BootStrap JS  -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js "></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js "></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js "></script>
    <!-- JS File  -->
    <script src="js/app.js"></script>
    <script src="js/LoginRegistrationValidation.js"></script>
</body>

</html>