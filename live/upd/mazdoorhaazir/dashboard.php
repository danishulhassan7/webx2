<!-- Including a Connection of Database (db.php) -->
<?php require_once("includes/db.php");?>
<!-- Including a Function from functions.php  -->
<?php require_once("includes/functions.php");?>
<!-- Including a Session file sessions.php  -->
<?php require_once("includes/sessions.php");?>
<!-- Function To Confirm the Login of Admin  -->
<?php
$_SESSION["TrackingURL"] = $_SERVER["PHP_SELF"];
Confirm_Login(); 
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
    <title>Dashboard</title>

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
            <div class="row pt-2">
                <div class="col-md-12">
                    <h1><i class="fas fa-cog text-primary"></i> Dashboard </h1>
                </div>
                <div class="col-lg-3 mb-2">
                    <a href="AddNewPost.php" class="btn btn-primary btn-block">
                        <i class="fas fa-edit"></i> Add New Profile
                    </a>
                </div>
                <div class="col-lg-3 mb-2">
                    <a href="categories.php" class="btn btn-info btn-block">
                        <i class="fas fa-folder-plus"></i> Add New Category
                    </a>
                </div>
                <div class="col-lg-3 mb-2">
                    <a href="Admins.php" class="btn btn-warning btn-block">
                        <i class="fas fa-user-plus"></i> Add New Admin
                    </a>
                </div>
                <div class="col-lg-3 mb-2">
                    <a href="Comments.php" class="btn btn-success btn-block">
                        <i class="fas fa-check"></i> Approve Reviews
                    </a>
                </div>
            </div>
        </div>
    </header>
    <!-- header ends  -->

    <!-- Main Area  -->
    <section class="container  py-2 mb-4">
        <!-- Adding a php file to call functions (SESSION) -->
    <?php 
            echo ErrorMessage();
            echo SuccessMessage();
            ?>
        <div class="row">
            <!-- left side area start  -->
            <div class="col-lg-2">
                <div class="card text-center bg-dark text-white mb-3">
                    <div class="card-body">
                        <h1 class="lead">Profiles</h1>
                        <h4 class="display-5">
                        <i class="fab fa-readme"></i>
                        <?php 
                        TotalPosts();
                        ?>
                        </h4>
                    </div>
                </div>

                <div class="card text-center bg-dark text-white mb-3">
                    <div class="card-body">
                        <h1 class="lead">Categories</h1>
                        <h4 class="display-5">
                        <i class="fas fa-folder"></i>
                        <?php 
                        TotalCategories();
                        ?>
                        </h4>
                    </div>
                </div>

                <div class="card text-center bg-dark text-white mb-3">
                    <div class="card-body">
                        <h1 class="lead">Admins</h1>
                        <h4 class="display-5">
                        <i class="fas fa-users"></i>
                        <?php 
                        TotalAdmins();
                        ?>
                        </h4>
                    </div>
                </div>

                <div class="card text-center bg-dark text-white mb-3">
                    <div class="card-body">
                        <h1 class="lead">Reviews</h1>
                        <h4 class="display-5">
                        <i class="fas fa-comments"></i>
                        <?php 
                        TotalComments();
                        ?>
                        </h4>
                    </div>
                </div>
            </div>
            <!-- left side area ends  -->

            <!-- right area starts  -->
            <div class="col-lg-10">
                <h1>Top Profiles</h1>
                <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th>No. </th>
                            <th>Title</th>
                            <th>Date & Time</th>
                            <th>Author</th>
                            <th>Comments</th>
                            <th>Details</th>
                        </tr>
                    </thead>
                    <?php
                    $SrNo = 0;
                    global $ConnectingDB;
                    $sql = "SELECT * FROM posts ORDER BY id desc LIMIT 0,5";
                    $stmt = $ConnectingDB->query($sql);
                    while($DataRows = $stmt->fetch()){
                        $PostId = $DataRows["id"];
                        $DateTime = $DataRows["datetime"];
                        $Author = $DataRows["author"];
                        $Title = $DataRows["title"];
                        $SrNo++;
                    ?>
                    <tbody>
                        <tr>
                            <td><?php echo $SrNo; ?></td>
                            <td><?php echo $Title; ?></td>
                            <td><?php echo $DateTime; ?></td>
                            <td><?php echo $Author; ?></td>
                            <td>
                                <?php
                                $Total = ApproveCommentsAccordingToPost($PostId);
                                if($Total > 0){
                                    ?>
                                    <span class="badge badge-success">
                                    <?php 
                                    echo $Total;
                                    ?>
                                    </span>
                                <?php } ?> 

                                <?php
                                $Total = DisApproveCommentsAccordingToPost($PostId);
                                if($Total > 0){
                                    ?>
                                    <span class="badge badge-danger">
                                    <?php 
                                    echo $Total;
                                    ?>
                                    </span>
                                <?php } ?> 
                            </td>
                            <td>
                            <a target="_blank" href="fullpost.php?id=<?php echo $PostId; ?>">
                            <span class="btn btn-info">Preview</span>
                            </a>
                            </td>
                        </tr>
                    </tbody>
                    <?php } ?>
                </table>
                </div>
            </div>
            <!-- right area ends  -->
        </div>
    </section>
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