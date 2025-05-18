// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HealthcareRecords {
    address owner;

    struct Record {
        uint256 recordID;
        string patientName;
        string diagnosis;
        string treatment;
        uint256 timestamp;
    }

    mapping (uint256 => Record[]) private patientRecords;

    mapping (address => bool) private authorizedProviders;

    modifier onlyOwner() {
        require(msg.sender ==  owner, "only owner can perform this function");
        _;
    }

     modifier onlyAuthorizedProvider() {
        require(authorizedProviders[msg.sender], "Not authorized provider/patient");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function getOwner() public view returns (address){
        return owner;
    }

    function authorizedProvider (address provider) public onlyOwner{
        authorizedProviders[provider] = true;
    }

    function addRecord(uint256 patientID, string memory patientName, string memory diagnosis, string memory treatment ) public onlyAuthorizedProvider {
        uint256 recordID = patientRecords[patientID].length + 1;
        patientRecords[patientID].push(Record (recordID, patientName, diagnosis, treatment ,block.timestamp));
    }

    function getPatinetrecords(uint256 patientID) public view onlyAuthorizedProvider returns (Record[] memory){
        return patientRecords[patientID];
    }
}   


// 0x44bd550f37d1b6bbac011de06082d03d9176705c - contract address~