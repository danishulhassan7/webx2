

var studentResultData = [];


const addstudata = (ev) => {
    ev.preventDefault();
    let studata = {
        title: document.getElementById("studentName").value,
        email: document.getElementById("studentEmail").value,
        age: document.getElementById("studentAge").value,
        sid: document.getElementById("studentId").value,

        c1: document.getElementById("mathsMarks").value,
        c2: document.getElementById("scienceMarks").value,
        c3: document.getElementById("historyMarks").value,
        c4: document.getElementById("englishMarks").value,
        c5: document.getElementById("physicsMarks").value,
        obt: function () {
            var x = parseInt(this.c1) + parseInt(this.c2) + parseInt(this.c3) + parseInt(this.c4) + parseInt(this.c5);
            return document.getElementById('obtm').innerHTML = 'Obtained Marks: ' + x;

        },
        per: function () {
            var x = parseInt(this.c1) + parseInt(this.c2) + parseInt(this.c3) + parseInt(this.c4) + parseInt(this.c5);
            var total = 500;
            var p = (x / total) * 100;
            return document.getElementById('perm').innerHTML = 'Percentage: ' + p.toFixed() + '%';
        },
    }

    console.log(studata.obt());
    console.log(studata.per());

    // document.getElementById('obtm').innerHTML += studata.obt() + '<br>';
    // document.getElementById('perm').innerHTML += studata.per().toFixed() + '<br>';

    studentResultData.push(studata);
    document.forms[0].reset();


    console.warn('added', { studentResultData });
    let pre = document.querySelector('#sec');
    if (pre) {
        pre.textContent = studentResultData;
    }

    pre.textContent = '\n' + JSON.stringify(studentResultData, '\t', 2);




    //saving to localStorage
    localStorage.setItem('MystudataList', JSON.stringify(studentResultData));

    // console.log(studentResultData[0]['title']);
    // console.log(studentResultData[0]['email']);
    // console.log(studentResultData[0]['age']);
    // console.log(studentResultData[0]['sid']);
    // console.log(studentResultData[0]['c1']);
    // console.log(studentResultData[0]['c2']);
    // console.log(studentResultData[0]['c3']);
    // console.log(studentResultData[0]['c4']);
    // console.log(studentResultData[0]['c5']);
    // console.log(studata.obt());
    // console.log(studata.per());

    var cols = ['title', 'email', 'age', 'sid', 'c1', 'c2', 'c3', 'c4', 'c5'];

    for (var i = 0; i < studentResultData.length; i++) {
    $('table').append('<tr></tr>');

    for (var j = 0; j < cols.length; j++) {
    $('table tr:last-child').append('<td>' + studentResultData[i][cols[j]] + '</td>');
    }
    }

    // Displaying the array of object data in html table

}
document.addEventListener('DOMContentLoaded', () => {
    document.getElementById('showResult').addEventListener('click', addstudata);
});








var data;
var displayBtn = document.getElementById('displayBtn');

// Event Listener
displayBtn.addEventListener('click', display);


function display() {
    if (data == 1) {
        document.getElementById('form').style.display = "inline";
        return data = 0;
    } else {
        document.getElementById('form').style.display = "none";
        return data = 1;
    }
}
