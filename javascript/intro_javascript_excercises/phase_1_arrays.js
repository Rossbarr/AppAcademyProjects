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

Array.prototype.twoSum = function(target = 0) {
  const num_pos = {};

  let i = 0;

  do {
    num_pos[this[i]] = i;
    required_num_pos = num_pos[target - this[i]];
    if (required_num_pos != undefined && required_num_pos != i) {
      return [required_num_pos, i]
    }
    i++;
  } while (i < this.length);
}

// console.log([2,3,4,6,5,6].twoSum(9))

Array.prototype.transpose = function() {
  let cols = -Infinity;
  const rows = this.length;
  let index = -1;
  this.forEach(function(a, i) {
    if (a.length > cols) {
      cols = a.length;
      index = i;
    }
  });

  // Create an array of transposed size filled with null
  const new_array = Array(cols).fill(Array(rows).fill(null))

  for (let j = 0; j < cols; j++) {
    new_array[j] = Array(cols);
  }
  for (let i = 0; i < rows; i++) {
    for (let j = 0; j < cols; j++) {
      new_array[j][i] = this[i][j];
    }
  }
  return new_array;
}

console.log([[1,2,3,4],[3,2],[2]].transpose());