const cowsay = require('cowsay');

// Message to be displayed by cowsay
const message = "Hello, world!";

// Use cowsay to generate the cow message
console.log(cowsay.say({
    text: message,
    e: "oO",  // Eyes
    T: "U "   // Tongue
}));
