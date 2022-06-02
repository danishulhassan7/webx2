<!-- Including a Connection of Database (db.php) -->
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
if(isset($_POST["Submit"])){
  $Category = $_POST["CategoryTitle"];
  $Admin = $_SESSION["AdminName"];
  // Creating Date and Time Functions
  date_default_timezone_set("Asia/Karachi");
  $CurrentTime = time();
  $DateTime = strftime("%B %d, %Y %H:%M:%S",$CurrentTime);

  if(empty($Category)){
    $_SESSION["ErrorMessage"]= "All fields must be filled out";
    Redirect_to("categories.php");
  }elseif (strlen($Category)<3) {
    $_SESSION["ErrorMessage"]= "Category title should be greater than 2 characters";
    Redirect_to("categories.php");
  }elseif (strlen($Category)>49) {
    $_SESSION["ErrorMessage"]= "Category title should be less than than 50 characters";
    Redirect_to("categories.php");
  }else{
    // Query to insert catoegry data in Database when everything is fine
    global $ConnectingDB; // creating a global variable of DB connection (Because if php has previous release of before 5.7)
    $sql = "INSERT INTO category(title,author,datetime)";
    $sql .= "VALUES(:categoryName,:adminName,:dateTime)";
    $stmt =  $ConnectingDB->prepare($sql);
    $stmt->bindValue(':categoryName',$Category);
    $stmt->bindValue(':adminName',$Admin);
    $stmt->bindValue(':dateTime',$DateTime);

    $Execute=$stmt->execute();

    if($Execute){
        $_SESSION["SuccessMessage"] = "Category with Id : ".$ConnectingDB->lastInsertId()." Added Succesfully";
        Redirect_to("categories.php");
    }else {
        $_SESSION["ErrorMessage"] = "Something went Wrong, Try Again";
        Redirect_to("categories.php");
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
    <title>MHP | Categories</title>

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
                    <h1><i class="fas fa-edit text-primary"></i> Manage Categories </h1>
                </div>
            </div>
        </div>
    </header>
    <!-- header ends  -->

    <!-- Main Area  -->
    <div class="container my-2 mb-4">
        <div class="row">
            <div class="offset-lg-1 col-lg-10" style="min-height:400px;">
            <!-- Adding a php file to call functions (SESSION) -->
            <?php 
            echo ErrorMessage();
            echo SuccessMessage();
            ?>
                <form action="categories.php" method="POST" class="">
                    <div class="card bg-dark text-light mb-3">
                        <div class="card-header">
                            <h1>Add New Category</h1>
                        </div>
                        <div class="card-body custom-style">
                            <div class="form-group">
                                <label for="title"><span class="fieldInfo">Category Title:</span> </label>
                                <input type="text" class="form-control" id="CategoryTitle" name="CategoryTitle" placeholder="Type title here">
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

                <h2>Existing Categories</h2>
            <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th>No. </th>
                        <th>Date & Time</th>
                        <th>Category Name</th>
                        <th>Creator Name</th>
                        <th>Action</th>
                    </tr>
                </thead>
            <?php
            global $ConnectingDB;
            $sql = "SELECT * FROM category ORDER BY id desc";
            $Execute = $ConnectingDB->query($sql);
            $SrNo = 0;
            while($DataRows = $Execute->fetch()){
                $CategoryId= $DataRows["id"];
                $CategoryDate = $DataRows["datetime"];
                $CategoryName = $DataRows["title"];
                $CreatorName = $DataRows["author"];
                $SrNo++;
                // if(strlen($CommenterName)>10) {
                //     $CommenterName = substr($CommenterName,0,10).'...';
                // }
                // if(strlen($DateTimeOfComment)>10) {
                //     $DateTimeOfComment = substr($DateTimeOfComment,0,11).'...';
                // }
            ?>
            <tbody>
                <tr>
                    <td><?php echo htmlentities($SrNo); ?></td>
                    <td><?php echo htmlentities($CategoryDate); ?></td>
                    <td><?php echo htmlentities($CategoryName); ?></td>
                    <td><?php echo htmlentities($CreatorName); ?></td>
                    <td><a href="DeleteCategory.php?id=<?php echo htmlentities($CategoryId); ?>" class="btn btn-danger">Delete</a></td>
                </tr>
            </tbody>
            <?php } ?>
         </table>
         </div>
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