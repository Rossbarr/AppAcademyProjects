function getRandomInt(max) {
  return Math.floor(Math.random() * max);
}

function Elephant (name, height, tricks) {
  this.name = name;
  this.height = height;
  this.tricks = tricks;
}

Elephant.prototype.trumpet = function () {
  console.log(this.name, "the elephant goes 'phrRRRRRRRRRRR!!!!!!!'");
}

Elephant.prototype.grow = function () {
  this.height += 12;
}

Elephant.prototype.addTrick = function (trick) {
  this.tricks.push(trick);
}

Elephant.prototype.play = function () {
  console.log(this.name, "is ", this.tricks[getRandomInt(this.tricks.length)]);
}

ele = new Elephant('Salgat', 12, ['jumping'])
console.log(ele.name)
console.log(ele.height)
ele.play()
ele.grow()
console.log(ele.height)
ele.addTrick('eating')
ele.play()
ele.play()
ele.play()