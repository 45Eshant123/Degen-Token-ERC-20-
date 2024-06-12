# Hello solidity

This Solidity program simple "Hello solidity" program that serves as an introductory demonstration of the basic syntax and functionality of the Solidity programming language. It is designed to provide a clear starting point for beginners looking to understand the language and its workings.

## Description

This program showcases a straightforward Solidity contract, a programming language tailored for crafting smart contracts on the Ethereum blockchain. The contract houses a solitary function that simply returns the string "Hello solidity". It stands as a strong foundation for delving into more intricate projects in the future.
## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., Hellosolidity.sol). Copy and paste the following code into the file:

```
pragma solidity ^0.8.0;

contract Hellosolidity {
    function display() public pure returns (string memory) {
        return "Hello Solidity World";
    }
}

```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.0" (or another compatible version), and then click on the "Compile Hellosolidity.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "Hellosolidity" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it by calling the sayHello function. Click on the "Hellosolidity" contract in the left-hand sidebar, and then click on the "display()" function. Finally, click on the "transact" button to execute the function and retrieve the "Hello Hello Solidity World" message.

## Authors

Eshant


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
