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

// ele = new Elephant('Salgat', 12, ['jumping'])
// console.log(ele.name)
// console.log(ele.height)
// ele.play()
// ele.grow()
// console.log(ele.height)
// ele.addTrick('eating')
// ele.play()
// ele.play()
// ele.play()

let ellie = new Elephant("Ellie", 185, ["giving human friends a ride", "playing hide and seek"]);
let charlie = new Elephant("Charlie", 200, ["painting pictures", "spraying water for a slip and slide"]);
let kate = new Elephant("Kate", 234, ["writing letters", "stealing peanuts"]);
let micah = new Elephant("Micah", 143, ["trotting", "playing tic tac toe", "doing elephant ballet"]);

let herd = [ellie, charlie, kate, micah];

function paradeHelper (elephant) {
  console.log(elephant.name, 'is trotting by!');
}

herd.forEach(element => {
  paradeHelper(element);
});