// // SPDX-License-Identifier: MIT

// pragma solidity ^0.8.16;

// contract CallAnything {

//     // Storage variables
//     address public s_someAddress;
//     uint256 public s_amount;

//     function transfer(address someAddress, uint256 amount) public {
//         s_someAddress = someAddress;
//         s_amount = amount;
//         }

//     function getSelectorOne() public pure returns(bytes4 selector){
//         selector = bytes4(keccak256(bytes("transfer(address, uint256)")));
//         return selector;
//         } 

//     function getDataToCallTransfer(address someAddress, uint256 amount) public pure returns(bytes memory){
//         return abi.encodeWithSelector(getSelectorOne(), someAddress, amount);
//         }

//     function callTransferFunctionDirectly(address someAddress, uint256 amount) public returns(bytes4, bool){
//         (bool success, bytes memory returnData) = address(this).call(
//             // getDataToCallTransfer(someAddress, amount));
//             abi.encodeWithSelector(getSelectorOne(), someAddress, amount));
//             return (bytes4(returnData), success);
//         }
// }

pragma solidity ^0.8.16;

contract CallAnything {

    // Storage variables
    address public s_someAddress;
    uint256 public s_amount;

    function transfer(address someAddress, uint256 amount) public {
        s_someAddress = someAddress;
        s_amount = amount;
    }

    function getSelectorOne() public pure returns(bytes4 selector){
        return bytes4(keccak256("transfer(address,uint256)"));
    } 

    function getDataToCallTransfer(address someAddress, uint256 amount) public pure returns(bytes memory){
        return abi.encodeWithSelector(getSelectorOne(), someAddress, amount);
    }

    function callTransferFunctionDirectly(address someAddress, uint256 amount) public returns(bytes4, bool success){
        (bool success, bytes memory returnData) = address(this).call(abi.encodeWithSelector(getSelectorOne(), someAddress, amount));
        return (bytes4(returnData), success);
    }
}
