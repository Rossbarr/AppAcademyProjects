dinnerBreakfast = function () {
  let breakfastOrder = ['scrambled eggs', 'bacon'];

  console.log("I'd like to order", breakfastOrder.join(' and '));

  return (order) => {
    breakfastOrder.push(order);
    console.log("I'd like to order", breakfastOrder.join(' and '));
  }
}


let bfastOrder = dinnerBreakfast();
bfastOrder("chocolate chip pancakes");
bfastOrder("grits");