# Building a layer-2 DAPP on top of Blochchain

## Introduction
A Dapp, or decentralized application, is a software application that runs on a distributed network. It’s not hosted on a centralized server, but instead on a peer-to-peer decentralized network, such as Ethereum. Dapp we have developed is accessed by different users where each user forms a joint account with other users of interest, i.e., with whom they want to transact.

## Files
The submitted repository consists of 4 main files:
  - Payment.sol
    - This file contains the code for the contract written in solidity
  - client.py
    - This contains the python file which fires up transactions and also contains the code for the requires analysis
    - It uses the file graph.py as a helper file and hence both of these should be placed in the same directory(or remember to refactor the path changes if you need to)
  - graph.py
    - This is a helper file which contains code to draw the graphs for analysis
  - Report.pdf
    - Reports the findings and analysis of our experiments

## Running instructions
To run the code, follow the setup instructions mentioned here https://docs.google.com/document/d/1IfIwdF6vhf4KYP1OYTwFmgqtdHO6nT7m0JaMH1xCIYo/edit

Here are the key steps:  
- Once the truffle has been setup, move the Payments.sol file to contracts/ directory
- Make sure you have the 2_deploy_contracts.js file provided in the problem statement in the migrations folder
- Now compile the contract using `truffle compile`
- Start ganache by running the command `ganache-cli`
- Run `truffle migrate` to deploy the contract
- Copy the contract address to client.py
- Now, to see the analysis, run client.py





===========================================

CS - 765 Assignment 3 Setup Instructions


1. The assignment requires the following tools:
   1. nodeJS
   2. Truffle: Its a framework to compile and deploy contracts
   3. Ganache : Its the local ethereum blockchain
https://trufflesuite.com/docs/ganache/quickstart/ or instead of ganache-ui, you can install ganache-cli.
   4. Web3 python package
For ubuntu: Installing Truffle requires a few additional steps. https://community.infura.io/t/installing-truffle-on-ubuntu/5113
   2. After installing required tools download the HW3 tar file and extract it.
   1. Run the ganache-cli using cmd “ganache-cli”(ubuntu) or “ganache”(windows). Ganache will run the ethereum blockchain locally to which you must deploy the contract and interact with.
   2. Run ‘truffle init’ in HW3 folder. It will create a few folders and config files.
   3. Run ‘truffle create contract Payment’ to create a Payment.sol under contracts/Payment.sol
   4. Then after writing solidity code as per assignment in Payment.sol compile it using ‘truffle compile’
   5. For deploying the contract you must copy the 2_deploy_contracts.js to the /migrations folder. If you have edited the contract filename you must update it in the js file as it points to Payment.sol
   6. Make sure ganache is running before deploying the contract.
   7. Run “truffle migrate” to deploy the contract.
   8. Contract address will be printed in the terminal after successful deployment. Copy this contract address to the client.py deployed_contract_address=”paste-contract-address”
   9. Install web3 python package globally.
   10. Run the client.py. By default it returns True if it is successfully connected to the ganache.
   11. Then you need to add code to the client.py as per assignment.


Note:
By default Ganache-Cli installed through npm will point to port 8545 whereas ganache-ui will point to 7545.
Truffle must connect to the appropriate ganache port as per installation.
By default Truffle connects to 7545. To make it 8545 you must uncomment line#67-71 in truffle-config.js. 






Hint:
   1. Use the client.py to find the path between nodes/users using appropriate graph traversal algorithms.
   2. Use the smart contract to do other functions like balance transfer etc.
   3. Basic theory behind the tools is that Ganache is the local copy of private ethereum blockchain where we need to deploy contracts. It will use RPC call (e.g 127.0.0.1:8545) to interact with other programs.  Truffle is the framework needed to compile and deploy contracts to the ethereum blockchain. When a smart contract is deployed it creates a contract address and contract json file. We need a client program (e.g client.py) to call functions to this contract deployed on ganache(ethereum). Again it will require the ganache port number (e.g 127.0.0.1:8545)  to connect to the ganache. The client file will require the contract address and location of the contract json file to successfully interact with the deployed contract. Once a contract is deployed it can’t be edited. If you want to edit you must redeploy the edited contract. To test the smart contract before deploying to ganache you can use https://remix.ethereum.org/        






Tutorials:
   1. https://medium.com/haloblock/deploy-your-own-smart-contract-with-truffle-and-ganache-cli-beginner-tutorial-c46bce0bd01e
   2. https://web3py.readthedocs.io/en/stable/quickstart.html
   3. https://www.freecodecamp.org/news/learn-solidity-handbook/
   4. https://www.tutorialspoint.com/solidity/index.htm
   5. https://medium.com/coinmonks/creating-and-deploying-smart-contracts-using-truffle-and-ganache-ffe927fa70ae
   6. If you forgot to note the contract address during deployment
https://ethereum.stackexchange.com/questions/34570/how-to-know-the-contract-address-which-truffle-is-deploying-with
   7.
