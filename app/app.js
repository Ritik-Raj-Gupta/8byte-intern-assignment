const express = require('express');
const app = express();
app.get('/', (req, res) => {
res.send('8byte Intern Assignment Successfully Deployed, testing ci pipeline run');
});
app.listen(3000, () => {
console.log('Server running on port 3000');
});