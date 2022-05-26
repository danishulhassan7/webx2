<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>MazdoorHaazir | Edit Profile</title>
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
    <!-- Icons -->
    <link href="css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v3.0.3/css/line.css">
    <!-- Font awesome -->
    <script src="https://use.fontawesome.com/a37c969743.js"></script>
    <!-- Main Css -->
    <link rel="stylesheet" href="css/xpf.css">
    <link rel="stylesheet" href="css/styles.css">


</head>

<body>

    <!-- Navbar Start -->
    <header id="topnav" class="defaultscroll sticky bg-purple">
        <div class="container">
            <!-- Logo container-->
            <div>
                <a class="logo" href="#" style="text-decoration: none !important;">
                    <img src="img/mh-name.png" height="74" alt=""> <span style="color: #ffa903;"></span>
                </a>
            </div>
            <div class="complaint-button">
                <a href="#" class="btn"
                    style="background-color: #ffa903; color: #5c0931; font-weight: bold;">Logout</a>
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
                    <li><a href="#" style="color:white !important">My Profile</a></li>
                    <li><a href="#" class="clr-yellow">Dashboard</a></li>
                    <li><a href="#" style="color:white !important">Profiles</a></li>
                    <li><a href="#" style="color:white !important">Categories</a></li>
                    <li><a href="#" style="color:white !important">Reviews</a></li>

                    <li class="has-submenu">
                        <a href="#" style="color:white !important">Manage</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li class="has-submenu"><a href="#"> Manage Admins </a><span class="submenu-arrow"></span>
                            </li>
                            <li class="has-submenu"><a href="#"> MHP Site <span
                                        class="badge badge-pill badge-success">Live</span></a><span
                                    class="submenu-arrow"></span>
                            </li>
                        </ul>
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


    <!-- Dashboard Starts  -->
    <!-- header  -->
    <header class="bg-purple clr-yellow py-3">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="pt-1"><i class="fas fa-edit text-primary"></i> Edit Profile</h1>
                </div>
            </div>
        </div>
    </header>
    <!-- header ends  -->

    <!-- Main Area  -->
    <div class="container my-2 mb-4">
        <div class="row">
            <div class="offset-lg-1 col-lg-10" style="min-height:400px;">
                <form action="" method="POST">
                    <div class="card bg-purple clr-yellow mb-3">
                        <div class="card-body custom-style">
                            <div class="form-group">
                                <label for="title"><span class="fieldInfo">Title:</span> </label>
                                <input type="text" class="form-control" id="title" name="PostTitle" placeholder="Type title here" value="Title">
                            </div>
                            <div class="form-group">
                            <span class="fieldInfo">Existing Category:</span>
                           updated category <br>
                                <label for="CategoryTitle"><span class="fieldInfo">Chose Category:</span> </label>
                                <select name="Category" id="CategoryTitle" class="form-control">
                                    
                                    <option>  XYZ category </option>
                                </select>
                            </div>
                            <div class="form-group">
                            <span class="fieldInfo"> Exiting Image: </span>
                            <img class="mb-1" src="#" width="80px" height="45px" alt=""> <br>
                            <label for="imageSelect"><span class="fieldInfo">Select Image:</span> </label>
                                <div class="custom-file">
                                <input type="File" class="custom-file-input" name="Image" id="imageSelect">
                                <label for="imageSelect" class="custom-file-label">Select Image:</label>
                                </div>
                            </div>
                            <div class="form-group">
                            <label for="Post"><span class="fieldInfo">Profile:</span> </label>
                            <textarea name="PostDescription" id="Post" cols="80" rows="8" class="form-control">
                            Peofile to be updated
                            </textarea>
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
    <!-- Dashboard Ends  -->



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
    <!-- Icons -->
    <script src="js/feather.min.js"></script>
    <script src="https://unicons.iconscout.com/release/v3.0.3/script/monochrome/bundle.js"></script>
    <!-- Main Js -->
    <script src="js/app.js"></script>
</body>

</html>