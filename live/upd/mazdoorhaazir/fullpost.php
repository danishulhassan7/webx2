<!-- Including a Connection of Database (db.php) -->
<?php require_once("includes/db.php");?>
<!-- Including a Function from functions.php  -->
<?php require_once("includes/functions.php");?>
<!-- Including a Session file sessions.php  -->
<?php require_once("includes/sessions.php");?>
<?php $SearchQueryParameter = $_GET["id"]; ?>

<?php
if(isset($_POST["Submit"])){
  $Name = $_POST["CommenterName"];
  $Email= $_POST["CommenterEmail"];
  $Comment = $_POST["CommenterThoughts"];
  // Creating Date and Time Functions
  date_default_timezone_set("Asia/Karachi");
  $CurrentTime = time();
  $DateTime = strftime("%B %d, %Y %H:%M:%S",$CurrentTime);

  if(empty($Name) || empty($Email)|| empty($Comment)){
    $_SESSION["ErrorMessage"]= "All fields must be filled out";
    Redirect_to("fullpost.php?id={$SearchQueryParameter}");
  }elseif (strlen($Comment)>500) {
    $_SESSION["ErrorMessage"]= "Comment length should be less than 500 characters";
    Redirect_to("fullpost.php?id={$SearchQueryParameter}");
  }else{
    // Query to insert comment  in Database when everything is fine
    global $ConnectingDB; // creating a global variable of DB connection (Because if php has previous release of before 5.7)
    $sql = "INSERT INTO comments(datetime,name,email,comment,approvedby,status,post_id)";
    $sql .= "VALUES(:dateTime,:name,:email,:comment,'Pending','OFF',:postIdFromURL)";
    $stmt =  $ConnectingDB->prepare($sql);
    $stmt->bindValue(':dateTime',$DateTime);
    $stmt->bindValue(':name',$Name);
    $stmt->bindValue(':email',$Email);
    $stmt->bindValue(':comment',$Comment);
    $stmt->bindValue(':postIdFromURL',$SearchQueryParameter);
    $Execute=$stmt->execute();

    if($Execute){
        $_SESSION["SuccessMessage"] = "Comment Submitted Succesfully";
        Redirect_to("fullpost.php?id={$SearchQueryParameter}");
    }else {
        $_SESSION["ErrorMessage"] = "Something went Wrong, Try Again";
        Redirect_to("fullpost.php?id={$SearchQueryParameter}");
    }
  }
} //Ending of Submit Button If-Condition
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>MazdoorHaazir | HomePage</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description"
        content="Mazdoor Haazir is a platform that connects customers to the skilled, experienced and reliable service professionals in their own locality. “Mazdoor Haazir” is the one-stop destination for all areas needs which includes cemetery, concrete laborers at your doorstep." />
    <meta name="keywords"
        content="MazdoorHaazir, Online Labour, Cemetery, Labour, Local Labour, Mazdoor, Mistri, Karachi" />
    <meta name="author" content="MazdoorHaazir" />
    <meta name="email" content="danishulhassan7@gmail.com" />
    <!-- GoogleFonts -->
    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;400&family=Sansita+Swashed:wght@300&display=swap"
        rel="stylesheet">
    <!-- favicon -->
    <link rel="shortcut icon" href="img/mh.png">
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- OWL Slider -->
    <link rel="stylesheet" href="css/owl.carousel.min.css" />
    <link rel="stylesheet" href="css/owl.theme.default.min.css" />
    <!-- AOS Animation -->
    <link href="css/aos.css" rel="stylesheet" type="text/css" />
    <!-- Icons -->
    <link href="css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v3.0.3/css/line.css">
    <!-- Main Css -->
    <link rel="stylesheet" href="css/xpf.css">

</head>

<body>

    <!-- Navbar Start -->
    <header id="topnav" class="defaultscroll sticky">
        <div class="container">
            <!-- Logo container-->
            <div>
                <a class="logo" href="index.php" style="text-decoration: none !important;">
                    <img src="img/mh-name.png" height="74" alt=""> <span style="color: #ffa903;"></span>
                </a>
            </div>
            <div class="complaint-button">
                <a href="complaints.php" class="btn"
                    style="background-color: #ffa903; color: #5c0931; font-weight: bold;">Complaint</a>
            </div>
            <!--end login button-->
            <!-- End Logo container-->
            <div class="menu-extras">
                <div class="menu-item">
                    <!-- Mobile menu toggle-->
                    <a class="navbar-toggle">
                        <div class="lines">
                            <span></span>
                            <span></span>
                            <span></span>
                        </div>
                    </a>
                    <!-- End mobile menu toggle-->
                </div>
            </div>

            <div id="navigation">
                <!-- Navigation Menu-->
                <ul class="navigation-menu">
                    <li><a href="index.php" class="clr-yellow">Home</a></li>
                    <li><a href="about.php">About</a></li>
                    <li><a href="contact.php">Contact</a></li>
                    <li><a href="policy.php">T&C</a></li>
                    <li><a href="userlogin.php">Sign Up</a></li>

                    <li class="has-submenu">
                        <a href="pro.php" class="">Profiles</a><span class="menu-arrow"></span>
                        <!-- <ul class="submenu">
                            <li class="has-submenu"><a href="dd-account.php"> Account <span
                                        class="badge badge-pill badge-success">MHP</span></a><span
                                    class="submenu-arrow"></span>
                            </li>
                            <li class="has-submenu"><a href="dd-help.php"> Help center </a><span class="submenu-arrow"></span>
                            </li>
                        </ul> -->
                    </li>
                </ul>
                <!--end navigation menu-->
                <div class="buy-menu-btn d-none">
                    <a href="#" class="btn btn-primary">Hire Labour</a>
                </div>
                <!--end login button-->
            </div>
            <!--end navigation-->
        </div>
        <!--end container-->
    </header>
    <!--end header-->
    <!-- Navbar End -->
    <!-- Posts Area  -->
    <div class="container mt-5 pt-5">
        <div class="row mt-4 pt-5">
            <!-- Main Area of 8 columns  -->
            <div class="col-sm-8">
                <!-- <h3>The Complete Responsive Blogging CMS</h3>
                <h4 class="lead text-secondary small mb-5">This Blogging site is created by<em>Danish Ul Hassan</em></h4> -->
                <?php 
                echo ErrorMessage();
                echo SuccessMessage();
                ?>
            <?php
            global $ConnectingDB;
            // Sql Query when search button is active
            if(isset($_GET["SearchButton"])){
                $Search = $_GET["Search"];
                $sql = "SELECT * FROM posts
                WHERE datetime LIKE :search
                OR title LIKE :search
                OR category LIKE :search
                OR post LIKE :search";
                $stmt = $ConnectingDB->prepare($sql);
                $stmt->bindValue(':search','%'.$Search.'%');
                $stmt->execute();

            } 
            // The default Sql entries 
            else {
                $PostIdFromURL = $_GET["id"];
                if(!isset($PostIdFromURL)){
                    $_SESSION["ErrorMessage"] = "Sorry, Bad Request ! ";
                    Redirect_to("Blog.php");
                }
                $sql = "SELECT * FROM posts WHERE id = '$PostIdFromURL' ";
                $stmt = $ConnectingDB->query($sql);
                $Result = $stmt->rowcount();
                if($Result != 1){
                    $_SESSION["ErrorMessage"] = "Sorry, Bad Request ! ";
                    Redirect_to("Blog.php?page=1");
                }
            }
            while($DataRows = $stmt->fetch()){
                $PostId        = $DataRows["id"];
                $DateTime  = $DataRows["datetime"];
                $PostTitle = $DataRows["title"];
                $Category  = $DataRows["category"];
                $Admin     = $DataRows["author"];
                $Image     = $DataRows["image"];
                $PostDescription = $DataRows["post"];
            ?> 
            <!-- Displaying Posts from DB  -->
            <div class="card mb-4">
                <img src="uploads/<?php echo htmlentities($Image); ?>" style="width:100%; height:360px;" alt="" class="img-fluid card-img-top">
                <div class="card-body">
                    <h4 class="card-title"><?php echo htmlentities($PostTitle); ?></h4>
                    <small class="text-muted">Category: <span class="text-dark"><a href="Blog.php?category=<?php echo htmlentities($Category); ?>"><?php echo htmlentities($Category); ?></a></span> & Written by <span class="text-dark"><a href="Profile.php?aname=<?php echo htmlentities($Admin); ?>"><?php echo htmlentities($Admin); ?></a></span> On <span class="text-dark"><?php echo htmlentities($DateTime) ?></span></small>
                
                    <hr>
                    <p class="card-text">
                        <?php echo nl2br($PostDescription); ?>
                        <!-- This nl2bbr function change the plain text into straight html  -->
                    </p>
                </div>
                </div>
                <?php } ?> 
                <span class="fieldInfo2 display-4">Comments <i class="fas fa-comment-alt"></i></span>
                <br><br>
                <!-- // end of while loop -->

                <!-- Fetching existing comment Starts -->

                <?php
                    global $ConnectingDB;
                    $sql = "SELECT * FROM comments
                     WHERE post_id='$SearchQueryParameter' AND status='ON'";
                    $stmt = $ConnectingDB->query($sql);
                    while($DataRows = $stmt->fetch()){
                        $CommentDate = $DataRows['datetime'];
                        $CommenterName = $DataRows['name'];
                        $CommentContent = $DataRows['comment'];
                ?>

                <div>
                    <div class="media CommentBlock">
                        <img src="images/user.jpg" class="img-fluid d-block img-thumbnail" alt="">
                        <div class="media-body ml-2">
                            <h6 class="lead"><?php echo $CommenterName; ?></h6>
                            <p class="small"><?php echo $CommentDate; ?></p>
                            <p><?php echo $CommentContent; ?></p>
                        </div>
                    </div>
                </div>
                 <hr>

             <?php } ?> 
              <!-- // Ending of While loop  -->
                <!-- // Fetching Existing comments End  -->

                <!-- Comment Section Starts  -->
                <div class="">
                    <form action="fullpost.php?id=<?php echo $SearchQueryParameter ?>" method="POST">
                        <div class="card mb-3">
                            <div class="card-header">
                                <h5 class="fieldInfo2"><i class="fas fa-comment"></i> Share your thoughts about this post</h5>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text fieldInfo2"><i class="fas fa-user"></i></span>
                                        </div>
                                        <input type="text" class="form-control" name="CommenterName" placeholder="Name" id="CommenterName">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text fieldInfo2"><i class="fas fa-envelope"></i></span>
                                        </div>
                                        <input type="email" class="form-control" name="CommenterEmail" placeholder="Email" id="CommenterEmail">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <textarea name="CommenterThoughts" class="form-control" id="CommenterThoughts" cols="80" rows="6" placeholder="Your thoughts?"></textarea>
                                </div>
                                <div class="">
                                    <button type="submit" name="Submit" class="btn btn-primary">Submit</button>
                                </div>

                            </div>
                        </div>
                    </form>
                </div>
                <!-- // Comment Section Ends  -->

            </div>
            <!-- Main Area Ends  -->

                        <!-- Side Area of Columns  -->
                        <div class="col-sm-4">
                <div class="card mt-4">
                    <div class="card-body">
                        <img src="img/cs.png" class="d-block img-fluid mb-3" alt="Blog Guide">
                        <div class="text-center">
                        Mazdoor Haazir is a platform that connects customers to the skilled, experienced and reliable service professionals in their own locality. “Mazdoor Haazir” is the one-stop destination for all areas needs which includes cemetery, concrete laborers at your doorstep.
                        </div>
                    </div>
                </div>
                <br>
                <!-- Card-1 Ends  -->
                <!-- <div class="card">
                    <div class="card-header bg-dark text-light">
                        <h2 class="lead">Sign Up!</h2>
                    </div>
                    <div class="card-body">
                        <button type="button" class="btn btn-success btn-block text-center text-white mb-4" name="button">
                        Join the Forum
                        </button>
                        <button type="button" class="btn btn-danger btn-block text-center text-white mb-4" name="button">
                        Login
                        </button>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" name="" placeholder="Enter your email" value="">
                            <div class="input-group-append">
                            <button type="button" class="btn btn-primary btn-sm text-center text-white" name="button">
                            Subscribe Now
                            </button>
                            </div>
                        </div>
                    </div>
                </div> -->
                <br>
                <!-- Card-2 Ends  -->
                <div class="card">
                    <div class="card-header bg-primary text-light">
                        <h2 class="lead">Categories</h2>
                    </div>
                    <div class="card-body">
                        <?php
                        global $ConnectingDB;
                        $sql = "SELECT * FROM category ORDER BY id desc";
                        $stmt = $ConnectingDB->query($sql);
                        while($DataRows= $stmt->fetch()){
                            $CategoryId = $DataRows["id"];
                            $CategoryName = $DataRows["title"];
                        ?>
                        <a href="pro.php?category=<?php echo $CategoryName; ?>">
                        <span class="heading"><?php echo $CategoryName; ?></span>
                        </a>
                        <br>
                        <?php } ?>
                    </div>
                </div>
                <br>
                <!-- Card-3 Ends  -->
                <div class="card">
                <div class="card-header bg-info text-white">
                    <h2 class="lead">Recent Posts</h2>
                </div>
                <div class="card-body">
                <?php
                global $ConnectingDB;
                $sql = "SELECT * FROM posts ORDER BY id desc LIMIT 0,5";
                $stmt = $ConnectingDB->query($sql);
                while($DataRows = $stmt->fetch()){
                    $Id = $DataRows["id"];
                    $Title = $DataRows["title"];
                    $DateTime = $DataRows["datetime"];
                    $Image = $DataRows["image"];
                ?>
                <div class="media">
                    <img src="uploads/<?php echo htmlentities($Image); ?>" class="d-block img-fluid align-self-start" width="90px" height="94" alt="Recent Blog Post">
                    <div class="media-body ml-2">
                        <a  style="text-decoration:none;" href="fullpost.php?id=<?php echo htmlentities($Id); ?>" target="_blank">
                        <h6 class="lead"><?php echo htmlentities($Title); ?></h6>
                        </a>
                        <p class="small"> <?php echo htmlentities($DateTime); ?> </p>
                    </div>
                </div>
                <hr>
                <?php } ?>
                </div>
                </div>
                <!-- Card-4 Ends  -->
            </div>
            <!-- Side Area Ends  -->
        </div>
    </div>
    <!-- Posts Area Ends  -->

    <!-- Footer Start -->
    <footer class="footer footer-bar">
        <div class="container text-center">
            <div class="row align-items-center">
                <div class="col-sm-6">
                    <div class="text-sm-left">
                        <p class="mb-0">©
                            <script>document.write(new Date().getFullYear())</script> MazdoorHaazir, All rights
                            reserved.
                        </p>
                    </div>
                </div>
                <!--end col-->

                <div class="col-sm-6 mt-4 mt-sm-0 pt-2 pt-sm-0">
                    <ul class="list-unstyled social-icon social mb-0 mt-4">
                        <li class="list-inline-item"><a href="#" class="rounded"><i data-feather="facebook"
                                    class="fea icon-sm fea-social"></i></a></li>
                        <li class="list-inline-item"><a href="#" class="rounded"><i data-feather="instagram"
                                    class="fea icon-sm fea-social"></i></a></li>
                        <li class="list-inline-item"><a href="#" class="rounded"><i data-feather="twitter"
                                    class="fea icon-sm fea-social"></i></a></li>
                        <li class="list-inline-item"><a href="#" class="rounded"><i data-feather="linkedin"
                                    class="fea icon-sm fea-social"></i></a></li>
                    </ul>
                </div>
                <!--end col-->
            </div>
            <!--end row-->
        </div>
        <!--end container-->
    </footer>
    <!--end footer-->
    <!-- Footer End -->

    <!-- Back to top -->
    <a href="#" class="btn btn-icon btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
    <!-- Back to top -->

    <!-- javascript -->
    <script src="js/jquery-3.5.1.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/jquery.easing.min.js"></script>
    <script src="js/scrollspy.min.js"></script>
    <!-- Typed -->
    <script src="js/typed.js"></script>
    <script src="js/typed.init.js"></script>
    <!-- OWL SLIDER -->
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/owl.init.js"></script>
    <!-- AOS Animation -->
    <script src="js/aos.js "></script>
    <!-- Icons -->
    <script src="js/feather.min.js"></script>
    <script src="https://unicons.iconscout.com/release/v3.0.3/script/monochrome/bundle.js"></script>
    <!-- Main Js -->
    <script src="js/app.js"></script>
    <!-- Animation Js -->
    <script>
        AOS.init({
            easing: 'ease-in-out-sine',
            duration: 1000
        });
    </script>
</body>

</html>