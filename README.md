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