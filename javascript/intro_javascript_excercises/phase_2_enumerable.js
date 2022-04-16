Array.prototype.myEach = function(callback) {
  for (let i = 0; i < this.length; i++) {
    this[i] = callback(this[i]);
  }
}

Array.prototype.myMap = function(callback) {
  const new_array = this.slice(0);
  new_array.myEach(callback);
  return new_array;
}

Array.prototype.myReduce = function(callback, initial_value) {
  if (initial_value) {
    acc = initial_value;
    for (let i = 0; i < this.length; i++) {
      acc = callback(this[i], acc);
    }
  } else {
    acc = this[0];
    for (let i = 1; i < this.length; i++) {
      acc = callback(this[i], acc);
    }
  }
  return acc;
}

const array = [1,2,3];
const new_array = array.myMap(function(i) { return i+1; });
console.log(array);
console.log(new_array);

const ans1 = [1, 2, 3].myReduce(function(acc, el) {return acc + el})
const ans2 = [1, 2, 3].myReduce(function(acc, el) {return acc + el;}, 25)

console.log(ans1);
console.log(ans2);
