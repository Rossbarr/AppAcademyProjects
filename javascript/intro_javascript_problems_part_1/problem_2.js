function fizzBuzz (array) {
  new_array = []
  for (let i = 0; i < array.length; i++) {
    div3 = array[i] % 3 == 0;
    div5 = array[i] % 5 == 0;
    if ((div3 || div5) && !(div3 && div5)) {
      new_array.push(array[i])
    }
  }

  return new_array;
}

console.log(fizzBuzz([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15]));

function isPrime (int) {
  if (int == 1) {
    return false;
  }
  for (let i = 2; i*i <= int; i++) {
    if (int % i == 0) {
      return false;
    }
  }
  return true;
}

console.log(isPrime(1))
console.log(isPrime(2))
console.log(isPrime(10))
console.log(isPrime(15485863))
console.log(isPrime(3548563))

function sumOfNPrimes (int) {
  sum = 0;
  count = 0
  for (let i = 0; count <= int; i++) {
    if (isPrime(i)) {
      sum += i;
      count += 1;
    }
  }

  return sum;
}

console.log(sumOfNPrimes(0))
console.log(sumOfNPrimes(1))
console.log(sumOfNPrimes(4))