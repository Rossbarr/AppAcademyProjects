function stop () {
  console.log("stop");
}

setTimeout(() => {console.log("HAMMERTIME");}, 5000);

setTimeout(stop, 2000)

function hammerTime (time) {
  setTimeout(() => {console.log(time + " is HAMMERTIME")}, time);
}

hammerTime(3000);