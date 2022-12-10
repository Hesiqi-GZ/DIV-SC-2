# DIV-SC-2
A Data Integrity Verification Scheme for Centralized Database Using Smart Contract and Game Theory

Author: Siqi He, Xiaofei Xing, Guojun Wang

This demo only contains smart contract code and web3.js operation code for server and user.

After downloading the above code, you first need to create a private blockchain environment to deploy the smart contract code for testing. We recommend you to use Ganache(Available for download at https://trufflesuite.com/ganache/) to quickly build a usable private chain.

After the private chain is generated, you can use Remix(https://remix.ethereum.org/) to deploy smart contracts online. It should be noted that after you successfully deploy the smart contract, you need to call the setPassword() function in the smart contract to generate a password for the rest of the functions that only you know, otherwise the rest of the functions may be called by users other than you, causing Security Risk.

Then, you can execute web3.js code to implement data update and validation operations. All code files are marked with the desired execution order before the file name. It should be noted that for the convenience of demonstration and in order to show the portability of DIV-SC, we do not introduce a database to perform the operation of the database service provider, which can be replaced by any user through the corresponding web.js code file.

Please note that you need to fill in important elements such as the address of the smart contract you deployed, the path of the contract abi file, and the address of the blockchain account in the corresponding vacancies in the web3.js file (explained in the code comments).

At last, if you want to build a more convincing permissioned blockchain environment, we recommend you to use Go Ethereum 1.10.17(Available for download at https://github.com/ethereum/go-ethereum/releases). After setting up, you can use another computer that has joined the permissioned blockchain to perform the operations of the database service provider.
