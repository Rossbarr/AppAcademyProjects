Array.prototype.uniq = function() {
  var elements = [];

  for (let i = 0; i < this.length; i++) {
      if (!elements.includes(this[i])) {
          elements.push(this[i])
      }
  }

  return elements;
}

// console.log([1,2,2,3,3,3].uniq());

Array.prototype.twoSum = function() {
  hash = new Map();

  while (true) {

  }
}