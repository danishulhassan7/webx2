


var storageArray = [
    {},
    {},
    {},
];


function gettingMarksheetData() {
    // Getting Student Name Data
    var studentName, showStudentName;
    studentName = document.forms['marksheetData']['studentName'].value;
    showStudentName = document.getElementById('showStudentName');
    showStudentName.innerHTML = studentName;

    // Getting Student Email Data
    var studentEmail, showStudentEmail;
    studentEmail = document.forms['marksheetData']['studentEmail'].value;
    showStudentEmail = document.getElementById('showStudentEmail');
    showStudentEmail.innerHTML = studentEmail;


    // Getting Student ID Data
    var studentId, showStudentId;
    studentId = document.forms['marksheetData']['studentId'].value;
    showStudentId = document.getElementById('showStudentId');
    showStudentId.innerHTML = studentId;


    // Getting Student Age Data
    var studentAge, showStudentAge;
    studentAge = document.forms['marksheetData']['studentAge'].value;
    showStudentAge = document.getElementById('showStudentAge');
    showStudentAge.innerHTML = studentAge;

    // Getting Student Marks Data
    //Course-1
    var mathsMarks, showMathsMarks;
    mathsMarks = document.forms['marksheetData']['mathsMarks'].value;
    showMathsMarks = document.getElementById('showMathsMarks');
    showMathsMarks.innerHTML = mathsMarks;

    //Course-2
    var scienceMarks, showScienceMarks;
    scienceMarks = document.forms['marksheetData']['scienceMarks'].value;
    showScienceMarks = document.getElementById('showScienceMarks');
    showScienceMarks.innerHTML = scienceMarks;

    //Course-3
    var historyMarks, showHistoryMarks;
    historyMarks = document.forms['marksheetData']['historyMarks'].value;
    showHistoryMarks = document.getElementById('showHistoryMarks');
    showHistoryMarks.innerHTML = historyMarks;

    //Course-4
    var englishMarks, showEnglishMarks;
    englishMarks = document.forms['marksheetData']['englishMarks'].value;
    showEnglishMarks = document.getElementById('showEnglishMarks');
    showEnglishMarks.innerHTML = englishMarks;

    //Course-5
    var physicsMarks, showPhysicsMarks;
    physicsMarks = document.forms['marksheetData']['physicsMarks'].value;
    showPhysicsMarks = document.getElementById('showPhysicsMarks');
    showPhysicsMarks.innerHTML = physicsMarks;

    // Total & Percentage

    var totalMarks, percentage, obtainedMarks;

    totalMarks = 500;
    obtainedMarks = parseInt(mathsMarks) + parseInt(scienceMarks) + parseInt(historyMarks) + parseInt(englishMarks) + parseInt(physicsMarks);
    document.getElementById('showTotalMarks').innerHTML = obtainedMarks;
    console.log('Obtained Marks', obtainedMarks);


    percentage = (obtainedMarks / totalMarks) * 100;
    document.getElementById('showPercentage').innerHTML = percentage.toFixed(2) + '%';
    console.log('Percentage', percentage);

    // Course Percentage, Grade, and Result: PASS/FAIL

    // percentage of each course
    var mathscoursePercentage = (parseInt(mathsMarks) / 100) * 100;
    document.getElementById('mathsPercentage').innerHTML = mathscoursePercentage.toFixed(2) + '%';

    var sciencecoursePercentage = (parseInt(scienceMarks) / 100) * 100;
    document.getElementById('sciencePercentage').innerHTML = sciencecoursePercentage.toFixed(2) + '%';

    var historycoursePercentage = (parseInt(historyMarks) / 100) * 100;
    document.getElementById('historyPercentage').innerHTML = historycoursePercentage.toFixed(2) + '%';

    var englishcoursePercentage = (parseInt(englishMarks) / 100) * 100;
    document.getElementById('englishPercentage').innerHTML = englishcoursePercentage.toFixed(2) + '%';

    var physicscoursePercentage = (parseInt(physicsMarks) / 100) * 100;
    document.getElementById('physicsPercentage').innerHTML = physicscoursePercentage.toFixed(2) + '%';
    

    // PASS/FAIL (each course)
    if (mathsMarks >= 50) {
        var mathsResult = document.getElementById('mathsResult').innerHTML = 'PASS';
    } else {
        document.getElementById('mathsResult').innerHTML = 'FAIL';
    }
    if (scienceMarks >= 50) {
        var scienceResult = document.getElementById('scienceResult').innerHTML = 'PASS';
    } else {
        document.getElementById('scienceResult').innerHTML = 'FAIL';
    }
    if (historyMarks >= 50) {
        var historyResult = document.getElementById('historyResult').innerHTML = 'PASS';
    } else {
        document.getElementById('historyResult').innerHTML = 'FAIL';
    }
    if (englishMarks >= 50) {
        var englishResult = document.getElementById('englishResult').innerHTML = 'PASS';
    } else {
        document.getElementById('englishResult').innerHTML = 'FAIL';
    }
    if (physicsMarks >= 50) {
        var physicsResult = document.getElementById('physicsResult').innerHTML = 'PASS';
    } else {
        document.getElementById('physicsResult').innerHTML = 'FAIL';
    }


    // Result Status
    if (mathsResult == 'PASS' && scienceResult == 'PASS' && historyResult == 'PASS' && englishResult == 'PASS' && physicsResult == 'PASS') {
        document.getElementById('statusResult').innerHTML = 'Status: PASS';
        document.getElementById('statusResult').style.backgroundColor = "green";
        console.log('Result: P');
    } else {
        document.getElementById('statusResult').innerHTML = 'Status: FAIL';
        console.log('Result: F');
        document.getElementById('statusResult').style.backgroundColor = "red";
    }


    // Grade Calc 
    if (percentage >= 80) {
        document.getElementById('statusGrade').innerHTML = 'Grade: A+';
        document.getElementById('statusGrade').style.backgroundColor = "purple";
        console.log('A+');
    } else if (percentage >= 70 && percentage < 80) {
        document.getElementById('statusGrade').innerHTML = 'Grade: A';
        document.getElementById('statusGrade').style.backgroundColor = "orange";
        console.log('A');
    } else if (percentage >= 60 & percentage < 70) {
        document.getElementById('statusGrade').innerHTML = 'Grade: B';
        document.getElementById('statusGrade').style.backgroundColor = "mediumorchid";
        console.log('B');
    } else if (percentage >= 50 & percentage < 60) {
        document.getElementById('statusGrade').innerHTML = 'Grade: C';
        document.getElementById('statusGrade').style.backgroundColor = "brown";
        console.log('C');
    } 
    //else if (percentage >= 40 & percentage < 50) {
    //     document.getElementById('statusGrade').innerHTML = 'Grade: D';
    //     document.getElementById('statusGrade').style.backgroundColor = "hotpink";
    //     console.log('D');
    // }
     else {
        document.getElementById('statusGrade').innerHTML = 'Grade: F';
        document.getElementById('statusGrade').style.backgroundColor = "magenta";
        console.log('WAH')
    }

}
