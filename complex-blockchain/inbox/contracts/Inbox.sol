// SPDX-License-Identifier: RANDOM_TEXT

pragma solidity >=0.4.17 < 0.7.4;

contract Inbox{
    string public message;

    function thisInbox(string memory initialMessage) public{
        message = initialMessage;
    }

    function setMessage(string memory newMessage) public{
        message = newMessage;
    }
}