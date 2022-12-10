var Web3= require('web3');   
var web3= new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:8545"));

var fs = require('fs');
var myContractABI = JSON.parse(fs.readFileSync("").toString());  //Fill in the corresponding smart contract abi file path.

var contractAddress = "";   //Fill in the corresponding smart contract address.
var myContract = new web3.eth.Contract(myContractABI, contractAddress);

var pswd = ''//Fill in the function password set when the smart contract is initialized.

myContract.methods.getSeedList(pswd).call((err, result)=>{
    console.log(result);
});

myContract.methods.getHashList(pswd).call((err, result)=>{
    console.log(result);
});