// function validate() {

//     var username = document.getElementById('username').value;
//     var email = document.getElementById('email').value;
//     var password = document.getElementById('password').value;
//     var cpassword = document.getElementById('cpassword').value;

//     if (username == "") {
//         document.getElementById('username_err').innerHTML = "**Name is Mandatory";
//         document.getElementById('username').focus();
//         return false;
//     } else if (email == "") {
//         document.getElementById('email_err').innerHTML = "**Email is Mandatory";
//         document.getElementById('email').focus();
//         return false;
//     } else if (password == "") {
//         document.getElementById('password_err').innerHTML = "**Password is Mandatory";
//         document.getElementById('password').focus();
//         return false;
//     } else if (cpassword == "") {
//         document.getElementById('cpassword_err').innerHTML = "**Confirm Password is Mandatory";
//         document.getElementById('cpassword').focus();
//         return false;
//     }

//     // First and Last Name Validation 

//     // var valid = false;
//     // var exp = /^[A-Za-z\s]{3,30}$/;
//     // var name = document.getElementById('firstname').value;
//     // var result = exp.test(name);

//     // if (result) {
//     //     return true;
//     // } else {
//     //     document.getElementById('fname_err').innerHTML = "**Enter only characters min of  3 and max of 30 characters";
//     //     document.getElementById('firstname').focus();
//     //     return false;
//     // }





//     //Regular Expressions validations 
//     //Email Validation


//     var exp = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
//     var result = exp.test(email);
//     if (!result) {
//         document.getElementById('email_err').innerHTML = "**Please Enter a Valid Email";
//         document.getElementById('email').focus();
//         return false;
//     }


//     ///Pasword Validation
//     exp = /^[0-9\s]{11}$/;
//     result = exp.test(phone);

//     if (!result) {
//         document.getElementById('phone_err').innerHTML = "**Must be Numeric and should be of max 11 digits";
//         document.getElementById('phone').focus();
//         return false;
//     }



//     //Feedback validation
//     exp = /^[A-Za-z0-9\s]+$/;
//     result = exp.test(feedback);

//     if (!result) {
//         document.getElementById('feedback_err').innerHTML = "**Must be aplhanumeric and should be less than 1500 characters";
//         document.getElementById('feedback').focus();
//         return false;
//     }




//     // alert("Validation Successfull");
//     return true;
// }