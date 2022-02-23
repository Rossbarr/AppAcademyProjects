const { read } = require('fs');
const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function biscuitsAndTea () {
  let first, second;

  reader.question('Would you like some tea? ', (res) => {
    first = res;
    console.log('You replied:', res);
    reader.question('Would you like some biscuits? ', (res) => {
      second = res;
      console.log('You replied:', res);
      const firstres = (first === 'yes') ? 'do' : 'don\'t';
      const secondres = (second === 'yes') ? 'do' : 'don\'t';
    
      console.log('So you', firstres, 'want tea and', secondres, 'want biscuits?');
      reader.close();
    
    })  
  });


}

biscuitsAndTea();