<!-- Including a Connection of Database (db.php) -->
<?php require_once("includes/db.php");?>
<!-- Including a Function from functions.php  -->
<?php require_once("includes/functions.php");?>
<!-- Including a Session file sessions.php  -->
<?php require_once("includes/sessions.php");?>

<!-- Fetching the existing data for Admin Profile on public site -->
<?php
    $SearchQueryParameter = $_GET["aname"];
    global   $ConnectingDB;
    $sql    =  "SELECT aname,aheadline,abio,aimage FROM admins WHERE aname=:userName";
    $stmt   =  $ConnectingDB->prepare($sql);
    $stmt   -> bindValue(':userName', $SearchQueryParameter);
    $stmt   -> execute();
    $Result = $stmt->rowcount();
if( $Result==1 ){
  while ( $DataRows   = $stmt->fetch() ) {
    $ExistingName     = $DataRows["aname"];
    $ExistingBio      = $DataRows["abio"];
    $ExistingImage    = $DataRows["aimage"];
    $ExistingHeadline = $DataRows["aheadline"];
  }
}
else {
  $_SESSION["ErrorMessage"]="Bad Request !!";
  Redirect_to("Blog.php?page=1");
}

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
    <title>Admin Profile</title>

</head>

<body>
        <!-- Navigation  -->
        <nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
        <div class="container-fluid align-items-center">
            <a href="#" class="navbar-brand">
                <i class="fas fa-blog trendarena"></i> <span class="trendarena">TrendArena</span></a>
            <!-- button for small screen  -->
            <button type="button" class="navbar-toggler ml-auto" data-target="#myNavbar" data-toggle="collapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse bg-primary" id="myNavbar">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a href="Blog.php" class="nav-link text-white"><i class="fas fa-home"></i> Home</a>
                    </li>
                    <li class="nav-item">
                        <a href="posts.php" class="nav-link text-white"><i class="fas fa-book-open"></i> About Us</a>
                    </li>
                    <li class="nav-item">
                        <a href="Blog.php" class="nav-link text-white"><i class="fas fa-stream"></i> Blog</a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link text-white"><i class="fas fa-user-shield"></i>  Contact Us</a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link text-white"><i class="fas fa-comments"></i> Features</a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link text-white"><i class="fas fa-chart-line"></i> Live Blog</a>
                    </li>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <form action="Blog.php" class="form-inline d-none d-sm-block">
                        <div class="form-group"> 
                            <input type="text" name="Search" placeholder="Type here"  class="form-control mr-2">
                            <button class="btn btn-primary" name="SearchButton"><i class="fas fa-search"></i> Search</button>
                        </div>
                    </form>
                </ul>
            </div>
        </div>
    </nav>
    <!-- Navigation Ends  -->

    <!-- header  -->
    <header class="bg-dark text-white py-2">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h1><i class="fas fa-user text-success mr-2"></i> <?php echo htmlentities($ExistingName); ?> </h1>
                    <h6><i class="fas fa-circle mr-2 text-warning"></i><i class="fas fa-globe mr-2 text-warning"></i><i class="fas fa-circle mr-2 text-warning"></i> <?php echo htmlentities($ExistingHeadline); ?> </h6>
                </div>
            </div>
        </div>
    </header>
    <!-- header ends  -->

    <!-- main area starts  -->
    <section class="container py-2 mb-4">
        <div class="row">
            <div class="col-md-3">
                <div class="card">
                <div class="card-header bg-warning text-center">
                <h5><i class="fas fa-user text-danger mr-2"></i> <?php echo htmlentities($ExistingName); ?> </h5>
                </div>
                <img src="images/<?php echo htmlentities($ExistingImage); ?>" class="d-block img-fluid mb-4 img-thumbnail rounded" alt="Admin Avatar">
                </div>
            </div>

            <div class="col-md-9">
                <div class="card">
                <div class="card-header bg-dark text-light">
                <h1><i class="fas fa-list mr-2 text-warning"></i> Description </h1>
                </div>
                    <div class="card-body">
                        <p class="lead"> <?php echo htmlentities($ExistingBio); ?></p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- main area ends  -->


    <!-- footer  -->
    <footer class="footer ">
        <div class="container ">
            <div class="row ">
                <div class="col-4 offset-1 col-sm-2 ">
                    <h5>Links</h5>
                    <ul class="list-unstyled ">
                        <li class="nav-item"><a href="myprofile.php" class="nav-link text-white"><i class="fa fa-user text-white"></i> My Profile</a></li>
                        <li class="nav-item"><a href="dashboard.php" class="nav-link text-white"><i class="fas fa-tachometer-alt "></i> Dashboard</a></li>
                        <li class="nav-item"><a href="posts.php" class="nav-link text-white"><i class="fas fa-book-open"></i> Posts</a></li>
                        <li class="nav-item"><a href="categories.php" class="nav-link text-white"><i class="fas fa-stream"></i> Categories</a></li>
                        <li class="nav-item"><a href="admins.php" class="nav-link text-white"><i class="fas fa-user-shield"></i> Admins</a></li>
                        <li class="nav-item"><a href="comments.php" class="nav-link text-white"><i class="fas fa-comments"></i> Comments</a></li>
                        <li class="nav-item"><a href="blog.php" class="nav-link text-white"><i class="fas fa-chart-line"></i> Live Blog</a></li>
                    </ul>
                </div>
                <div class="col-7 col-sm-5 ">
                    <h5>Our Address</h5>
                    <address>
                  121, Clear Water Bay Road<br>
                  Clear Water Bay, Kowloon<br>
                  Karachi 75800, Pakistan<br>
                  <i class="fas fa-phone-alt fa-lg "></i>: +852 1234 5678<br>
                  <i class="fas fa-fax fa-lg "></i>: +852 8765 4321<br>
                  <i class="fas fa-envelope fa-lg "></i>: <a href="mailto:danishulhassan7@gmail.com ">danishulhassan7@gmail.com</a>
               </address>
                </div>
                <div class="col-12 col-sm-4 align-self-center ">
                    <div class="text-center ">
                        <a class="btn btn-social-icon btn-google " href="http://google.com/+ "><i class="fab fa-google-plus-square fa-lg "></i></a>
                        <a class="btn btn-social-icon btn-facebook " href="http://www.facebook.com/profile.php?id="><i class=" fab fa-facebook-square fa-lg "></i></a>
                        <a class="btn btn-social-icon btn-linkedin " href="http://www.linkedin.com/in/ "><i class="fab fa-linkedin fa-lg "></i></a>
                        <a class="btn btn-social-icon btn-twitter " href="http://twitter.com/ "><i class="fab fa-twitter-square fa-lg "></i></a>
                        <a class="btn btn-social-icon btn-google " href="http://youtube.com/ "><i class="fab fa-youtube fa-lg "></i></a>
                        <a class="btn btn-social-icon " href="mailto: "><i class="fas fa-envelope fa-lg "></i></a>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center ">
                <div class="col-auto copyright ">
                    <p> &copy; Copyrights 2021 Danish Ul Hassan</p>
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
