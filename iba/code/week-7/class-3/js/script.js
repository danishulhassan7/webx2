

function gettingMarksheetData() {
    // Getting Student Name Data
    var studentName, showStudentName;
    studentName = document.forms['marksheetData']['studentName'].value;
    showStudentName = document.getElementById('showStudentName');
    showStudentName.innerHTML = '<b>Student Name: </b>'+ studentName;


    // Getting Student Age Data
    var studentAge, showStudentAge;
    studentAge = document.forms['marksheetData']['studentAge'].value;
    showStudentAge = document.getElementById('showStudentAge');
    showStudentAge.innerHTML = '<b>Student Age: </b>'+ studentAge;

    // Getting Student Marks Data
    //Course-1
    var mathsMarks, showMathsMarks;
    mathsMarks = document.forms['marksheetData']['mathsMarks'].value;
    showMathsMarks = document.getElementById('showMathsMarks');
    showMathsMarks.innerHTML = '<b>Math Marks: </b>'+ mathsMarks;

    //Course-2
    var scienceMarks, showScienceMarks;
    scienceMarks = document.forms['marksheetData']['scienceMarks'].value;
    showScienceMarks = document.getElementById('showScienceMarks');
    showScienceMarks.innerHTML = '<b>Science Marks: </b>'+ scienceMarks;

    //Course-3
    var historyMarks, showHistoryMarks;
    historyMarks = document.forms['marksheetData']['historyMarks'].value;
    showHistoryMarks = document.getElementById('showHistoryMarks');
    showHistoryMarks.innerHTML = '<b>History Marks: </b>'+ historyMarks;

    //Course-4
    var englishMarks, showEnglishMarks;
    englishMarks = document.forms['marksheetData']['englishMarks'].value;
    showEnglishMarks = document.getElementById('showEnglishMarks');
    showEnglishMarks.innerHTML = '<b>English Marks: </b>'+ englishMarks;

    //Course-5
    var physicsMarks, showPhysicsMarks;
    physicsMarks = document.forms['marksheetData']['physicsMarks'].value;
    showPhysicsMarks = document.getElementById('showPhysicsMarks');
    showPhysicsMarks.innerHTML = '<b>Physics Marks: </b>'+ physicsMarks;

    // Total & Percentage

    var totalMarks, percentage, obtainedMarks;

    totalMarks = 500;
    obtainedMarks = parseInt(mathsMarks) + parseInt(scienceMarks) + parseInt(historyMarks) + parseInt(englishMarks) + parseInt(physicsMarks);
    console.log('Obtained Marks', obtainedMarks);

    percentage = (obtainedMarks/totalMarks) * 100;
    console.log('Percentage', percentage);

}
