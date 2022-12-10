var Web3= require('web3');   
var web3= new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:8545"));

var fs = require('fs');
var myContractABI = JSON.parse(fs.readFileSync("").toString());  //Fill in the corresponding smart contract abi file path.

var contractAddress = "";   //Fill in the corresponding smart contract address.
var myContract = new web3.eth.Contract(myContractABI, contractAddress);

var pswd = ''//Fill in the function password set when the smart contract is initialized.

var adsNeedToVertify = []  //Fill in the address corresponding to the data that you want to check whether the hash value has been consumed.

//example:
//["100001","100007", "100012", "100017", "100018", "100022", "100026", "100031", "100036", "100043"]

myContract.methods.checkIfVerifiable(adsNeedToVertify, pswd).call((err, result)=>{
    console.log(result);
});
