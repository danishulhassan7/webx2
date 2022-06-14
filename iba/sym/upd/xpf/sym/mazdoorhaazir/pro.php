<?php require_once("includes/db.php");?>
<!-- Including a Function from functions.php  -->
<?php require_once("includes/functions.php");?>
<!-- Including a Session file sessions.php  -->
<?php require_once("includes/sessions.php");?>

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
            <div class="complaint-button mt-3">
            <ul class="navbar-nav ml-auto">
                    <form action="pro.php" class="form-inline d-none d-sm-block">
                        <div class="form-group"> 
                            <input type="text" name="Search" placeholder="Type here"  class="form-control mr-2">
                            <button class="btn btn-primary" name="SearchButton"><i class="fas fa-search"></i> Search</button>
                        </div>
                    </form>
                </ul>
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
                    <li><a href="index.php">Home</a></li>
                    <li><a href="about.php">About</a></li>
                    <li><a href="contact.php">Contact</a></li>
                    <li><a href="policy.php">T&C</a></li>
                    <li><a href="userlogin.php">Sign Up</a></li>

                    <li class="has-submenu">
                        <a href="#" class="" class="clr-yellow">Profiles</a><span class="men-arrow"></span>
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
        <div class="row mt-5 pt-4">
            <!-- Main Area of 8 columns  -->
            <div class="col-sm-8">
                <h3>The MazdoorHaazir Platform</h3>
                <h4 class="lead text-secondary small mb-5">This website is developed by<em>Danish & Hammad</em></h4>
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
            // Query When Pagination is Active i.e Blog.php?page=1 
            elseif(isset($_GET["page"])){
                $Page = $_GET["page"];
                if($Page == 0 || $Page < 1){
                    $ShowPostFrom = 0;
                } else {
                    $ShowPostFrom = ($Page * 5)-5;
                }
                $sql = "SELECT * FROM posts ORDER BY id desc LIMIT $ShowPostFrom,5";
                $stmt = $ConnectingDB->query($sql);
            }
            //Query When category is active from side area in URL Tab
            elseif(isset($_GET["category"])){
                $Category = $_GET["category"];
                $sql = "SELECT * FROM posts WHERE category='$Category' ORDER BY id desc";
                $stmt = $ConnectingDB->query($sql);
            }
            // The default Sql entries 
            else {
                $sql = "SELECT * FROM posts ORDER BY id desc LIMIT 0,5";
                $stmt = $ConnectingDB->query($sql);
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
                    <small class="text-muted">Category: <span class="text-dark"><a href="pro.php?category=<?php echo htmlentities($Category); ?>"><?php echo htmlentities($Category); ?></a></span> & Written by <span class="text-dark"><a href="Profile.php?aname=<?php echo htmlentities($Admin); ?>"><?php echo htmlentities($Admin); ?></a></span> On <span class="text-dark"><?php echo htmlentities($DateTime) ?></span></small>
                    <span style="float:right"; class="badge badge-secondary text-light">
                    <?php echo ApproveCommentsAccordingToPost($PostId); ?>
                    Comments
                    </span>
                
                    <hr>
                    <p class="card-text">
                        <?php 
                            if(strlen($PostDescription)>150){
                                $PostDescription = substr($PostDescription,0,150)."...";
                                echo $PostDescription;
                            }
                        ?>
                    </p>
                    <a href="fullpost.php?id=<?php echo $PostId; ?>" style="float:right">
                        <span class="btn btn-info">Read more >></span>
                    </a>
                </div>
                </div>
                <br>
                <?php } ?> 
                <!-- // end of while loop -->

                <!-- Pagination  -->
                <nav>
                <ul class="pagination pagination-lg">
                <!-- Creating Backward Button  -->
                <?php if(isset($Page)) { 
                        if($Page > 1){ ?> 
                    <li class="page-item">
                    <a href="pro.php?page=<?php echo $Page - 1; ?>" class="page-link">&laquo;</a>
                    </li> 
                    <?php } }?>
                    <?php
                        global $ConnectingDB;
                        $sql = "SELECT COUNT(*) FROM posts";
                        $stmt = $ConnectingDB->query($sql);
                        $RowPagination = $stmt->fetch();
                        $TotalPosts = array_shift($RowPagination);
                        // echo $TotalPosts."<br>";
                        $PostPagination = $TotalPosts/5;
                        $PostPagination = ceil($PostPagination);
                        // echo $PostPagination;
                        for($i = 1; $i <= $PostPagination; $i++) {
                            if(isset($Page)){
                                // if($i == $Page) {
                    ?>
                    <li class="page-item">
                    <a href="pro.php?page=<?php echo $i; ?>" class="page-link"><?php echo $i; ?></a>
                    </li>
                    <?php
                    } else {
                            ?>
                    <li class="page-item">
                    <a href="pro.php?page=<?php echo $i; ?>" class="page-link"><?php echo $i; ?></a>
                    </li>                    
                        <?php }  }?> 

                    <!-- Creating Forward Button  -->
                    <?php if(isset($Page) && !empty($Page)) { 
                        if($Page+1 <= $PostPagination){ ?> 
                    <li class="page-item">
                    <a href="pro.php?page=<?php echo $Page + 1; ?>" class="page-link">&raquo;</a>
                    </li> 
                    <?php } }?>
                </ul>
                </nav>
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