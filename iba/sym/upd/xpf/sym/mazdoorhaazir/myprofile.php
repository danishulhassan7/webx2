<?php require_once("includes/db.php");?>
<!-- Including a Function from functions.php  -->
<?php require_once("includes/functions.php");?>
<!-- Including a Session file sessions.php  -->
<?php require_once("includes/sessions.php");?>
<!-- Function To Confirm the Login of Admin  -->
<?php 
$_SESSION["TrackingURL"] = $_SERVER["PHP_SELF"];
Confirm_Login(); ?>


<?php

// Fetching the Existing Admin Data Start
$AdminID = $_SESSION["UserId"];
global $ConnectingDB;
$sql = "SELECT * FROM admins WHERE id='$AdminID'";
$stmt = $ConnectingDB->query($sql);
while($DataRows = $stmt->fetch()){
    $ExistingAdmin = $DataRows["aname"];
    $ExistingUsername = $DataRows["username"];
    $ExistingHeadline = $DataRows["aheadline"];
    $ExistingBio = $DataRows["abio"];
    $ExistingImage = $DataRows["aimage"];
}
// Fetching the Existing Admin Data End
if(isset($_POST["Submit"])){
  $AName = $_POST["Name"];
  $AHeadline = $_POST["Headline"];
  $ABio = $_POST["Bio"];
  $Image = $_FILES["Image"]["name"];
  $Target = "images/".basename($_FILES["Image"]["name"]);
  if(empty($AName)||empty($AHeadline)||empty($ABio)){
    $_SESSION["ErrorMessage"]= "All fields must be filled out";
    Redirect_to("myprofile.php");
  }elseif (strlen($AHeadline)>30) {
    $_SESSION["ErrorMessage"]= "Headline should be less than 30 characters";
    Redirect_to("myprofile.php");
  }elseif (strlen($ABio)>1500) {
    $_SESSION["ErrorMessage"]= "Admin Bio should be less than than 1500 characters";
    Redirect_to("myprofile.php");
  }else{
    // Query to update Admin data in Database when everything is fine
    global $ConnectingDB; // creating a global variable of DB connection (Because if php has previous release of before 5.7)
   if(!empty($_FILES["Image"]["name"])){
    $sql = "UPDATE admins
    SET aname='$AName', aheadline='$AHeadline', abio='$ABio', aimage='$Image'
    WHERE id='$AdminID'";
   } else {
    $sql = "UPDATE admins
    SET aname='$AName', aheadline='$AHeadline', abio='$ABio'
    WHERE id='$AdminID'";
   }
    $Execute = $ConnectingDB->query($sql);
    // var_dump($sql);
    // var_dump($Execute);
    move_uploaded_file($_FILES["Image"]["tmp_name"],$Target);
    if($Execute){
        $_SESSION["SuccessMessage"] = "Details Updated Succesfully";
        Redirect_to("myprofile.php");
    }else {
        $_SESSION["ErrorMessage"] = "Something went Wrong, Try Again";
        Redirect_to("myprofile.php");
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
    <link rel="stylesheet" href="css/styles1.css?v=<?php echo time(); ?>">
    <title>My Profile</title>

</head>

<body>
    <!-- Navigation  -->
    <nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top" style="background-color:#5c0931 !important;">
        <div class="container-fluid align-items-center">
            <a href="#" class="navbar-brand">
                <i class="trendarena"></i> <span class="trendarena">MHP</span></a>
            <!-- button for small screen  -->
            <button type="button" class="navbar-toggler ml-auto" data-target="#myNavbar" data-toggle="collapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse bg-primary" id="myNavbar" style="background-color:#5c0931 !important;">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item ml-5">
                        <a href="myprofile.php" class="nav-link active"><i class="fa fa-user text-white"></i> My Profile</a>
                    </li>
                    <li class="nav-item">
                        <a href="dashboard.php" class="nav-link text-white"><i class="fas fa-tachometer-alt "></i> Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a href="posts.php" class="nav-link text-white"><i class="fas fa-book-open"></i> Profiles</a>
                    </li>
                    <li class="nav-item">
                        <a href="categories.php" class="nav-link text-white"><i class="fas fa-stream"></i> Categories</a>
                    </li>
                    <li class="nav-item">
                        <a href="admins.php" class="nav-link text-white"><i class="fas fa-user-shield"></i>  Manage Admins</a>
                    </li>
                    <li class="nav-item">
                        <a href="comments.php" class="nav-link text-white"><i class="fas fa-comments"></i> Reviews</a>
                    </li>
                    <li class="nav-item">
                        <a href="https://mazdoorhaazir.com" class="nav-link text-white"><i class="fas fa-chart-line"></i> Live Site</a>
                    </li>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a href="logout.php" class="nav-link text-danger"><i class="fa fa-user-times"></i> Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- Navigation Ends  -->

    <!-- header  -->
    <header class="bg-dark text-white py-2">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1><i class="fas fa-user mr-2 text-success"></i>
                    @<?php echo htmlentities($ExistingUsername); ?>
                    </h1>
                    <h6><i class="fas fa-circle mr-2 text-warning"></i><i class="fas fa-globe mr-2 text-warning"></i><i class="fas fa-circle mr-2 text-warning"></i> <?php echo htmlentities($ExistingHeadline); ?> </h6>
                </div>
            </div>
        </div>
    </header>
    <!-- header ends  -->

    <!-- Main Area  -->
    <div class="container py-2 mb-4">
        <div class="row">
            <!-- Left Area Starts -->
            <div class="col-md-3"> 
                <div class="card">
                <div class="card-header bg-dark text-light">
                    <h3 class="text-center"><?php echo $ExistingAdmin; ?></h3>
                </div>
                <div class="card-body">
                   <div class="text-center">
                   <img src="images/<?php echo htmlentities($ExistingImage); ?>" class="block img-fluid img-thumbnail mb-3" alt="Avatar" height="150px" width="210px">
                   </div>
                    <p class="text-center">
                    <?php echo htmlentities($ExistingBio); ?>
                    </p>
                </div>
                </div>
            </div>
            <!-- Right Area Starts -->
            <div class="col-md-9" style="min-height:400px;">
            <!-- Adding a php file to call functions (SESSION) -->
            <?php 
            echo ErrorMessage();
            echo SuccessMessage();
            ?>
                <form action="myprofile.php" method="POST" enctype="multipart/form-data">
                    <div class="card bg-dark text-light">
                        <div class="card-header bg-dark text-light">
                             <h4>Edit Profile</h4>
                        </div>
                        <div class="card-body custom-style">
                            <div class="form-group">
                                <input type="text" class="form-control" id="Name" name="Name" placeholder="Your name">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="Headline" placeholder="Headline" name="Headline">
                                <small class="text-muted">Add a professional headline like, 'Developer' at XYZ or 'Photographer'</small>
                                <span class="text-danger small">Not more than 30 characters</span>
                            </div>
                            <div class="form-group">
                            <textarea name="Bio" id="Bio" placeholder="Bio" cols="80" rows="8" class="form-control"></textarea>
                            </div>
                            
                            <div class="form-group">
                                <div class="custom-file">
                                <input type="File" class="custom-file-input" name="Image" id="imageSelect">
                                <label for="imageSelect" class="custom-file-label">Select Image:</label>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-lg-6 mb-2">
                                    <a href="dashboard.php" class="btn btn-warning btn-block"> <i class="fas fa-arrow-left"></i> Back to Dashboard</a>
                                </div>
                                <div class="col-lg-6 mb-2">
                                    <button type="submit" name="Submit" class="btn btn-success btn-block"> 
                                    <i class="fas fa-check"></i> Publish
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- Main Area Ends  -->

    <!-- footer  -->
    <footer class="footer" style="background-color:#5c0931 !important;">
        <div class="container ">
            <div class="row ">
                <div class="col-4 offset-1 col-sm-2 ">
                    <h5>Links</h5>
                    <ul class="list-unstyled ">
                        <li class="nav-item"><a href="myprofile.php" class="nav-link text-white"><i class="fa fa-user text-white"></i> My Profile</a></li>
                        <li class="nav-item"><a href="dashboard.php" class="nav-link text-white"><i class="fas fa-tachometer-alt "></i> Dashboard</a></li>
                        <li class="nav-item"><a href="posts.php" class="nav-link text-white"><i class="fas fa-book-open"></i> Profiles</a></li>
                        <li class="nav-item"><a href="categories.php" class="nav-link text-white"><i class="fas fa-stream"></i> Categories</a></li>
                        <li class="nav-item"><a href="admins.php" class="nav-link text-white"><i class="fas fa-user-shield"></i> Admins</a></li>
                        <li class="nav-item"><a href="comments.php" class="nav-link text-white"><i class="fas fa-comments"></i> Reviews</a></li>
                        <li class="nav-item"><a href="https://mazdoorhaazir.com" class="nav-link text-white"><i class="fas fa-chart-line"></i> Live Site</a></li>
                    </ul>
                </div>
                <div class="col-7 col-sm-5 ">
                    <h5>Our Address</h5>
                    <address>
                  121, ABCD Road<br>
                  Karachi, Sindh Province<br>
                  Karachi 75800, Pakistan<br>
                  <i class="fas fa-phone-alt fa-lg "></i>: +92 308 2157220<br>
                  <i class="fas fa-fax fa-lg "></i>: +92 343 0722651<br>
                  <i class="fas fa-envelope fa-lg "></i>: <a href="mailto:danishulhassan7@gmail.com ">danishulhassan7@gmail.com</a>
               </address>
                </div>
                <div class="col-12 col-sm-4 align-self-center ">
                    Icons
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-auto copyright">
                    <p> &copy; Copyrights 2022 MHP</p>
                </div>
            </div>
        </div>
    </footer>


    <!-- First jquery, then popper and in last BootStrap JS  -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js "></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js "></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js "></script>
</body>
</html>