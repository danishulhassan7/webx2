<!DOCTYPE html>
<html lang="en">
<head>
    <title>PHP - Task26</title>
</head>
<body>
    <?php
        echo '<h1> Hello World from PHP </h1>';

        echo "<h1>Variables</h1>";

        $num1  = 5;
        $num2 = 4;
        $addition = $num1 + $num2;
        $subtraction = $num1 - $num2;
        $multiply = $num1 * $num2;
        $division = $num1 / $num2;
        $mod = $num1 % $num2;
        echo 'Addition: of ', $num1, ' and ' , $num2 , ' is: ',  '<b>' , $addition, '</b> <br>';
        echo 'Subtraction: of ', $num1, ' and ' , $num2 , ' is: ',  '<b>' , $subtraction, '</b> <br>';
        echo 'Multiplication: of ', $num1, ' and ' , $num2 , ' is: ',  '<b>' , $multiply, '</b> <br>';
        echo 'Division: of ', $num1, ' and ' , $num2 , ' is: ',  '<b>' , $division, '</b> <br>';
        echo 'Modulus: of ', $num1, ' and ' , $num2 , ' is: ',  '<b>' , $mod, '</b> <br>';


        //printing fullname using function

        echo "<h1>Functions</h1>";

        function fullName($firstName, $lastName) {
            echo "Full Name: $firstName $lastName <br>";
        }
        fullName("Virat", "Kohli");
        fullName("Babar", "Azam");


        //Arrays in PHP

        echo "<h1>Arrays</h1>";

        $players = array('Marnus', 'Steve', 'Kane', 'Joe', 'Baber');
        echo "<h1>Test Cricket Latest Rankings: Top-" , count($players), "</h1>";
        
        echo "Number-1: <b>$players[0]</b> <br>";
        echo "Number-2: <b>$players[1]</b> <br>";
        echo "Number-3: <b>$players[2]</b> <br>";
        echo "Number-4: <b>$players[3]</b> <br>";
        echo "Number-5: <b>$players[4]</b> <br>";


    ?>
</body>
</html>