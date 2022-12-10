// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract DataIntegrity {

    address owner; 
    constructor() { 
        owner = msg.sender; 
    } 

    struct userData {
        string dataAddress;
        string dataOp;
        randomSeed[] randomSeedList;
    }

    struct seedAndAds {
        string dataAddress;
        string seed;
    }

    struct adsAndHash {
        string dataAddress;
        string dataHash;
    }

    struct randomSeed {
        string dataHash;
        string randomDataSeed;
        uint count;
    }

    struct vertifyResult {
        string dataAddress;
        bool boolResult;
    }

    string pwd;

    randomSeed public currentRandomSeed;

    userData public currentData;

    randomSeed[] public tempRandomSeedList;

    userData[] public userList;

    seedAndAds[] public seedList;

    adsAndHash[] public hashList;

    vertifyResult[] public resultsList;
    
    uint private RandNonce = 0;

    function randomNumber() public returns(uint){
        uint rand = uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,RandNonce))) % 100; 
        RandNonce++;
        return rand;
    }

    function setPassword(string memory _pwd) public {
        require(msg.sender == owner);
        pwd = _pwd;
    }

    function isStringEqual(string memory _a, string memory _b) public pure returns (bool) {
        bytes memory a = bytes(_a);
        bytes memory b = bytes(_b);
        if (a.length != b.length) return false;
        for(uint i = 0; i < a.length; i ++) {
            if(a[i] != b[i]) return false;
        }
        return true;
    }

    function isBytes32Equal(bytes32 a, bytes32 b) public pure returns (bool) {
        if (a.length != b.length) return false;
        for(uint i = 0; i < a.length; i ++) {
            if(a[i] != b[i]) return false;
        }
        return true;
    }

    function isHashPoolRunningOut() public view returns (bool) {
        bool flag = false;
        for(uint i = 0; i < userList.length; i++){
            for(uint j = 0; j < userList[i].randomSeedList.length; j++){
                if(userList[i].randomSeedList[j].count < 2){
                    flag = true;
                }
            }
        }
        return flag;
    }

    //uint转string
    function uintToString(uint _i) public returns (string memory  _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k = k-1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }

    function getSHA256(bytes memory data, string memory seed) public view returns(bytes32) {
        bytes memory tempSeed = bytes(seed);
        uint totallen = data.length + tempSeed.length;
        bytes memory input = new bytes(totallen);
        for(uint i = 0; i < data.length; i++){
            input[i] = data[i];
        }
        for(uint j = data.length; j < totallen; j++){
            input[j] = tempSeed[j-data.length];
        }
        bytes32 Hash = sha256(input);
        return Hash;
    }

    function splitDataOp(string memory _dataOp) public view returns(bytes memory){
        bytes memory tempOp = bytes(_dataOp);
        uint i = 0;
        while(tempOp[i] != ">"){
            i++;
        }
        uint bytesCount = tempOp.length-i-1;
        i++;
        bytes memory tempResultB = new bytes(bytesCount);
        for(uint j = 0; j < bytesCount; j++){
            tempResultB[j] = tempOp[i];
            i++;
        }
        return tempResultB;
    }
    
    function addDataToContract(string memory _dataAddress, string memory _dataOp, string[] memory _resultHash, string[] memory _tempRandomSeed, string memory _pwd) public {
        require(isStringEqual(pwd, _pwd));
        for(uint j = 0; j < _resultHash.length; j++){
            currentRandomSeed.dataHash = _resultHash[j];
            currentRandomSeed.randomDataSeed = _tempRandomSeed[j];
            currentRandomSeed.count = 0;
            tempRandomSeedList.push(currentRandomSeed);
        }
        currentData.dataAddress = _dataAddress;
        currentData.dataOp = _dataOp;
        currentData.randomSeedList = tempRandomSeedList;
        uint i = userList.length;
        uint flag = 0;
        if(i > 0){
            i--;
            while(!isStringEqual(userList[i].dataAddress, _dataAddress)){
                if(i > 0) i--;
                else{
                    flag = 1;
                    break;
                }
            }
        }else{
            userList.push(currentData);
        }
        if(flag == 0) userList[i] = currentData;
        else userList.push(currentData);
        delete tempRandomSeedList;
    }

    function checkIfVerifiable(string[] memory adsList, string memory _pwd) public view returns(string memory){
        require(isStringEqual(pwd, _pwd));
        string memory checkResult = "Warning! All hashes of all addresses to be verified are used twice!";
        for(uint i = 0; i < userList.length; i++){
            for(uint j = 0; j < adsList.length; j++){
                if(isStringEqual(userList[i].dataAddress, adsList[j])){
                    for(uint k = 0; k < userList[i].randomSeedList.length; k++){
                        if(userList[i].randomSeedList[k].count < 1){
                            checkResult = "No";
                        }
                    }    
                }
            }
        }
        return checkResult;
    }

    function getSeedtoList(string[] memory adsList, uint prob, string memory _pwd) public {
        require(isStringEqual(pwd, _pwd));
        require(isHashPoolRunningOut());
        // uint index = 0;
        // uint SLlength = seedList.length;
        for(uint i = 0; i < userList.length; i++){
            for(uint j = 0; j < adsList.length; j++){
                if(isStringEqual(userList[i].dataAddress, adsList[j])){
                    uint randNum = randomNumber();
                    if(randNum > prob){
                        string memory choseSeed;
                        for(uint k = 0; k < 8; k++){
                            if(userList[i].randomSeedList[k].count < 1){
                                choseSeed = userList[i].randomSeedList[k].randomDataSeed;
                                userList[i].randomSeedList[k].count++;
                                adsAndHash memory tempHashData = adsAndHash({
                                    dataAddress: adsList[j],
                                    dataHash: userList[i].randomSeedList[k].dataHash
                                });
                                hashList.push(tempHashData);
                                break;
                            }else{
                                uint u_tempChoseSeed = uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,RandNonce))) % 10000;
                                choseSeed = uintToString(u_tempChoseSeed);
                            }
                        }
                        seedAndAds memory tempData = seedAndAds({
                            dataAddress: adsList[j],
                            seed: choseSeed
                        });
                        seedList.push(tempData);
                    }else{
                        uint u_tempFakeSeed = uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,RandNonce))) % 10000;
                        string memory fakeSeed = uintToString(u_tempFakeSeed);
                        seedAndAds memory tempData = seedAndAds({
                            dataAddress: adsList[j],
                            seed: fakeSeed
                        });
                        seedList.push(tempData);
                    }
                    
                    // if(SLlength!=0 && index < SLlength){
                    //     seedList[index] = tempData1;
                    // }
                    // else seedList.push(tempData1);

                    // if(SLlength!=0 && index < SLlength){
                    //     hashList[index] = tempData2;
                    // }
                    // else hashList.push(tempData2);
                    //index++;
                }
            }
        }
    }

    function vertifyHash(string memory _dataAddress, string memory receivedHash) public {
        bool result = false;
        for(uint i = 0; i < hashList.length; i++){
            if(isStringEqual(hashList[i].dataAddress, _dataAddress)){
                if(isStringEqual(hashList[i].dataHash, receivedHash)){
                    result = true; 
                }
                vertifyResult memory tempVertifyResult = vertifyResult({
                    dataAddress: _dataAddress,
                    boolResult: result
                });
                resultsList.push(tempVertifyResult);
                break;
            }
        }
    }

    function checkVertifyResults(string memory _pwd) public view returns(vertifyResult[] memory){
        require(isStringEqual(pwd, _pwd));
        return resultsList;
    }

    function deleteLists(string memory _pwd) public {
        require(isStringEqual(pwd, _pwd));
        delete seedList;
        delete hashList;
        // for(uint i = 0; i < seedList.length; i++){
        //     delete seedList[i];
        // }
        // for(uint j = 0; j < hashList.length; j++){
        //     delete hashList[j];
        // }
        delete resultsList;
    }

    function deleteUserData(string memory _pwd) public {
        require(isStringEqual(pwd, _pwd));
        delete userList;
    }

    function ResetSpecificHashPool(string memory _dataAddress, string[] memory _resultHash, string[] memory _tempRandomSeed, string memory _pwd) public {
        require(isStringEqual(pwd, _pwd));
        for(uint i = 0; i < userList.length; i++){
            if(isStringEqual(userList[i].dataAddress, _dataAddress)){
                for(uint j = 0; j < _resultHash.length; j++){
                    currentRandomSeed.dataHash = _resultHash[j];
                    currentRandomSeed.randomDataSeed = _tempRandomSeed[j];
                    currentRandomSeed.count = 0;
                    tempRandomSeedList.push(currentRandomSeed);
                }
                currentData.dataAddress = userList[i].dataAddress;
                currentData.dataOp = userList[i].dataOp;
                currentData.randomSeedList = tempRandomSeedList;
                userList[i] = currentData;
                break;
            }
        }
        delete tempRandomSeedList;
    }

    function getUserDataLength(string memory _pwd) public view returns(uint) {
        require(isStringEqual(pwd, _pwd));
        uint UDlength = userList.length;
        return UDlength;
    }

    function getTempRandomSeedList(string memory _pwd) public view returns(randomSeed[] memory){
        require(isStringEqual(pwd, _pwd));
        return tempRandomSeedList;
    }

    function getDataList(string memory _pwd) public view returns(userData[] memory){
        require(isStringEqual(pwd, _pwd));
        return userList;
    }

    function getRandomHashesInDataList(string memory _pwd, uint idx) public view returns(randomSeed[] memory){
        require(isStringEqual(pwd, _pwd));
        return userList[idx].randomSeedList;
    }

    function getSeedList(string memory _pwd) public view returns(seedAndAds[] memory){
        require(isStringEqual(pwd, _pwd));
        return seedList;
    }

    function getHashList(string memory _pwd) public view returns(adsAndHash[] memory){
        require(isStringEqual(pwd, _pwd));
        return hashList;
    }

    function getElementInList(uint _index, string memory _pwd) public view returns(userData memory){
        require(isStringEqual(pwd, _pwd) == true);
        userData memory tempData = userList[_index];
        return tempData;
    }

    function getBRLength(string memory _pwd) public view returns(uint){
        require(isStringEqual(pwd, _pwd));
        return resultsList.length;
    }

    function getAddress(string memory _pwd) public view returns(address){
        require(isStringEqual(pwd, _pwd));
        return owner;
    }

}