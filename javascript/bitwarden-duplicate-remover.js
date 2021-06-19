const originData = require('./data.json');
const fs = require('fs');

const outputData = {};
outputData.encrypted = originData.encrypted;
outputData.folders = originData.folders;
outputData.items = [originData.items.shift()];
let count = 1;
let unique = 1;
let combine = 0;
for (let originItem of originData.items) {
  count = count + 1;
  for (let outputItem of outputData.items) {
    if (originItem.name === outputItem.name) {
      if (originItem.login.username === outputItem.login.username) {
        if (originItem.login.password !== outputItem.login.password) {
          throw Error(
            `name: ${originItem.name}\nusername: ${originItem.login.username}\npassword: ${originItem.login.password}`
          );
        }
        let uriCount = 0;
        let uriCombine = 0;
        for (let originUri in originItem.login.uris) {
          uriCount = uriCount + 1;
          for (let outputUri in outputItem.login.uris) {
            if (
              originUri['match'] === outputUri['match'] &&
              originUri['uri'] === outputUri['uri']
            ) {
              uriCombine = uriCombine + 1;
              break;
            }
          }
          if (uriCount === uriCombine + 1) {
            outputItem.login.uris.push(originUri);
          }
          if (uriCount !== uriCombine) throw Error(originItem.name);
        }
        combine = combine + 1;
        break;
      }
    }
  }
  if (count === unique + combine + 1) {
    outputData.items.push(originItem);
    unique = unique + 1;
    console.log(`originItem.name: ${originItem.name} username: ${originItem.login.username}`);
  }
  console.log(`count: ${count} unique: ${unique} combine: ${combine}`);
}

console.log(`length: ${outputData.items.length}`);

fs.writeFile('data_new.json', JSON.stringify(outputData), 'utf8', function (error) {
  if (error) {
    console.log(error);
    return false;
  }
  console.log('update data successfully!');
});
