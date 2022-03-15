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

// https://www.youtube.com/watch?v=KLlXCFG5TnA ""
Array.prototype.twoSum = function(target = 0) {
  // Check if the value to add is already in the hashmap

  hash = new Map();
  let i = 0;

  do {
    hash.set(this[i], i)
    if (target - this[i])
  } while (i < this.length);
}