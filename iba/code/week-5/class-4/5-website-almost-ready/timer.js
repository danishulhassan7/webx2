
function countDown(el) { // Create a function that recieves the element as argument

  var countDownDate = new Date(el.dataset.date).getTime();

  var x = setInterval(function () {

    var now = new Date().getTime();
    var dif = countDownDate - now;
    var d = Math.floor(dif / (1000 * 60 * 60 * 24));
    var h = Math.floor((dif % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    var m = Math.floor((dif % (1000 * 60 * 60)) / (1000 * 60));
    var s = Math.floor((dif % (1000 * 60)) / 1000);

    var formatted = d + "D " + h + "H " + m + "M " + s + "S ";
    //  var formatted =  `D\u00A0 \u00A0 \u00A0  H\u00A0 \u00A0 \u00A0   M\u00A0 \u00A0 \u00A0 S  <br> \u00A0 ${d} : \u00A0 ${h} : \u00A0  ${m} : \u00A0 ${s} `;


    // Output the result in the argument element
    el.innerHTML = dif < 0 ? "Expired" : formatted;

    // If the count down is over, stop Intervals
    if (dif < 0) {
      clearInterval(x);
    }
  }, 1000);

}

// Init countDown!
[...document.querySelectorAll("[data-date]")].forEach(el => countDown(el));

