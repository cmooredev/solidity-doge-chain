// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

contract HelloDogechain {

    string message;
    address public lastMessenger;
    address owner;

    mapping(address => uint) helloPlace;

    constructor() {
        owner = msg.sender;
        message = "Hello Dogechain!";
    }

    function getMessage() public view returns(string memory) {
        return message;
    }

    receive() external payable {
        // React to receiving ether
        require(msg.value > 0.01 ether, "You need to send at least 0.01");
        lastMessenger = msg.sender;
        helloPlace[msg.sender] += msg.value;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawMoney() public {
        require(msg.sender == owner);
        address payable to = payable(msg.sender);
        to.transfer(getBalance());
    }

    function setHelloFrens(string memory newHello) public payable {
        require(helloPlace[msg.sender] != 0);
        require(msg.sender == lastMessenger);
        message = newHello;
    }

    function splitPot() public payable {
        uint totalPot = address(this).balance;

        require(totalPot > 100 * (10**18));
        require(msg.sender == lastMessenger);
        address payable firstHalf = payable(lastMessenger);
        firstHalf.transfer(getBalance()/2);
        address payable secondHalf = payable(owner);
        secondHalf.transfer(getBalance());
    }

}
