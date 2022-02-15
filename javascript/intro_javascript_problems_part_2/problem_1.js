function printCallback (array) {
  array.forEach(element => {
    console.log("Mx.", element, "Jingleheimer Schmidt")
  });
}

function titleize (array, printFn) {
  array = array.map( word => word[0].toUpperCase() + word.slice(1).toLowerCase() );

  printFn(array);
}

titleize(["mARY", "brian", "LEO"], printCallback);