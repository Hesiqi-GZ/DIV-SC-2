var Web3= require('web3');   
var web3= new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:8545"));

var fs = require('fs');
var myContractABI = JSON.parse(fs.readFileSync("").toString());  //Fill in the corresponding smart contract abi file path.

var contractAddress = "";   //Fill in the corresponding smart contract address.
var myContract = new web3.eth.Contract(myContractABI, contractAddress);

var pswd = ''  //Fill in the function password set when the smart contract is initialized.

var userData = [
    ['',''],  //The first array element is filled with the database address, and the second array element is filled with the corresponding database update command, the format is: "ABC->DEF".
    ['','']
]

// example:
// ['100001','s8Ihwl8z0g->FSSjlThK4P'],
// ['100002','HPCyeShejW->5SwMm6UgOD'],
// ['100003','nhwiMSXSqu->6q1BgS2ZTp'],
// ['100004','JBJtKiBxl4->QBGXieodBf'],
// ['100005','bNZqW4Fim6->NuxfcCqlLm'],
// ['100006','AlK85EeSBz->tXRGWuWnbB'],
// ['100007','DUnxyVEnRI->n0hbPjcWco'],
// ['100008','dRdrcvT6QN->O6LwlnogzB'],
// ['100009','Myhd8DAlqr->0nLT8bxuQ3'],
// ['100010','2ZiUVsGaqp->dAcBC52Upc'],
// ['100011','hKkjryhemQ->Cn67pikmk4'],
// ['100012','MiESdWxQQ5->tsifh8NzP4'],
// ['100013','sXfAm8SfwE->1kkBBdXt7r'],
// ['100014','kxjtpr6tna->8RRnrDhAFj'],
// ['100015','fAyKz2jAXS->8TB3kbeRSX'],
// ['100016','1eCBZdJ1d4->EZFK9YYwkP'],
// ['100017','450tzPbMAA->MMt0jtXHae'],
// ['100018','pd2ZiCBhNf->W2EfdfkTGb'],
// ['100019','A7iQER0T9J->DkdFa6pjPw'],
// ['100020','Gjr0WGscwp->KWDZe9TTFZ'],
// ['100021','XkeezCeBHi->WFQ0DxHeiC'],
// ['100022','mY8hwrJ0a9->uHgmD5875w'],
// ['100023','jYKFPy5T24->Z008bawWt9'],
// ['100024','xZnNkMrMKX->MAiRtrFAJA'],
// ['100025','1A1p2FdSMB->i6e5Mp9aj5'],
// ['100026','btb8fP7A2i->jiC4mBeylU'],
// ['100027','a8Rsc2P2ap->xwSNtrkrcf'],
// ['100028','w5NEYnaCND->ftcNB6E9YE'],
// ['100029','97xnbcjzPJ->SDYNSPGewN'],
// ['100030','6RpPnsT3mH->TwZZ5KTWs8'],
// ['100031','GXyWiG4167->KpdncDjCnQ'],
// ['100032','SbC9BYX1wi->mSDfNKNaz7'],
// ['100033','1FCGNTKQPB->zmRk5wmCDF'],
// ['100034','pCKr30xc34->PXy5w0b8jD'],
// ['100035','JjszXMR1X9->0Cp0r26vF4'],
// ['100036','NQZPA23QTB->Gmr2cZmBaG'],
// ['100037','Ka4P4Nbiex->9pAWPe0Qzi'],
// ['100038','dZR2CafSxW->6ANm9kDjH7'],
// ['100039','BKbfDw7zJP->NR743ZcmaD'],
// ['100040','pN8jsjh73R->PCWF5Gnyfz'],
// ['100041','pphXF3kzEB->wCSeSyJtfz'],
// ['100042','PQmdTTwDj7->xSbz3bmR2B'],
// ['100043','eMYxybniFY->J3Jn6G9Mhn'],
// ['100044','7T04bk5Qx8->DXXGdsH7m5'],
// ['100045','NnKHZXAGbr->4pkcci4m5N'],
// ['100046','62zEJw6nix->2pXyfBDsin'],
// ['100047','JhMPCh1Wrp->YHMdKiAJQs'],
// ['100048','6zeMeKTKKK->7jWbhTJ7sJ'],
// ['100049','06PDTPD5a9->7jWbhTJ7sJ'],
// ['100050','QC37Mhzk98->9yQnanWQTd']

var n = 8;  //The recommended number of hash values corresponding to each data is 8

//Note that this is a two-dimensional array
var Hash = [[
           ]]  //Fill in the corresponding generated hash value for each data, the recommended number is 8

//Note that this is a two-dimensional array           
var Seed = [[
           ]]  //Fill in the seed of the hash value corresponding to each data, and the number should be consistent with the number of hash values

// example:           
// var Hash = [
//             '0xed9d0fce1e4dc986fe5e7762ce4d5979103a9707bac251265f3f12467fde2ecb',
//             '0xc83e0fc471e3faf8daf90b67e064a72c363c9187de9788930e71a66297e259a7',
//             '0xe66f404f78b6875bb24ff40d80d21b78418607abff2e68d3084f75de4a239095',
//             '0xcaa3c0b48faad3fdbc84d9ecf1d2b6f15be37b2f3c9827f8ee2c3b7596700848',
//             '0x8a30f2af5db424a81f3fd0ca89d9f3e6fc723f88e92020934e4abf52e3a44467',
//             '0x40367c3cc999a9f9e951a1d33211545b84b2d5a63933b0020433000c3bb410fb',
//             '0x327ec29056cc47c24bf922f7dc0f78261dad5c726d7353a4048aa730e8fabe0f',
//             '0xaadce6517555d30fa48cfe5e74741507e87bcd9749fbd935e7094d67f98d5e64'
//            ]
// var Seed = [
//             '4453',
//             '5674',
//             '1226',
//             '0978',
//             '9495',
//             '1297',
//             '7944',
//             '7885'
//            ]

for(i = 0; i < userData.length; i++){
    for(j = 0; j < n; i++){
        myContract.methods.addDataToContract(userData[i][0], userData[i][1], Hash[i][j], Seed[i][j], pswd)
        .send({from: '', gas: 60000000})  //Fill in the corresponding blockchain account address.
        .on('receipt',function(result){
            console.log(result);
        });
    }
}


