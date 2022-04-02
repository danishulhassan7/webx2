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
            return x;
        },
        per: function () {
            var x = parseInt(this.c1) + parseInt(this.c2) + parseInt(this.c3) + parseInt(this.c4) + parseInt(this.c5);
            var total = 500;
            var p = (x / total) * 100;
            return p
        },
    }


    studentResultData.push(studata);
    document.forms[0].reset();

    console.log(studata.obt());
    console.log(studata.per());

    document.getElementById('obtm').innerHTML += studata.obt() + '<br>';
    document.getElementById('perm').innerHTML += studata.per().toFixed() + '%' + '<br>';


    console.log('added', { studentResultData });
    let pre = document.querySelector('#sec');
    if (pre) {
        pre.textContent = studentResultData;
    }

    pre.textContent = '\n' + JSON.stringify(studentResultData);


    //saving to localStorage
    localStorage.setItem('MystudataList', JSON.stringify(studentResultData));

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



