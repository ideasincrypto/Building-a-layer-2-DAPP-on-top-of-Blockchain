import json
from web3 import Web3
import networkx as nx
import numpy as np
import random
from graph import visualize_network,plot_success
import winsound
import matplotlib.pyplot as plt
# Set frequency to 2000 Hertz
frequency = 1500
# Set duration to 1500 milliseconds (1.5 seconds)
duration = 1500


#connect to the local ethereum blockchain
provider = Web3.HTTPProvider('http://127.0.0.1:8545')
w3 = Web3(provider)
#check if ethereum is connected
print(w3.is_connected())

#replace the address with your contract address (!very important)
deployed_contract_address = '0xc7aFbBe82fc3B36AD709c35E1c682fA99b20c057'

#path of the contract json file. edit it with your contract json file
compiled_contract_path ="build/contracts/Payment.json"
with open(compiled_contract_path) as file:
    contract_json = json.load(file)
    contract_abi = contract_json['abi']
contract = w3.eth.contract(address = deployed_contract_address, abi = contract_abi)



'''
#Calling a contract function createAcc(uint,uint,uint)
txn_receipt = contract.functions.createAcc(1, 2, 5).transact({'txType':"0x3", 'from':w3.eth.accounts[0], 'gas':2409638})
txn_receipt_json = json.loads(w3.to_json(txn_receipt))
print(txn_receipt_json) # print transaction hash

# print block info that has the transaction)
print(w3.eth.get_transaction(txn_receipt_json)) 

#Call a read only contract function by replacing transact() with call()

'''

#Add your Code here

for i in range(100):
    contract.functions.registerUser(i,"abc"+str(i)).transact({'txType':"0x3", 'from':w3.eth.accounts[0], 'gas':2409638})
G = nx.barabasi_albert_graph(n = 100, m = 5, seed=10374196, initial_graph = None)
list_of_edges=G.edges()
# print(list_of_edges)
winsound.Beep(frequency, duration)
for key,value in list_of_edges:
#    print(key,value)
   balance_user=int(np.random.exponential(10))

#    print(balance_user)
   contract.functions.createAcc(key,value,balance_user).transact({'txType':"0x3", 'from':w3.eth.accounts[0], 'gas':2409638})
group_succ_txn=[]
tot_txn=0
success_txn=0
winsound.Beep(frequency, duration)
for _ in range(1000):
    tot_txn+=1
    tf = random.sample(range(0,100),2)
    try:
        status=contract.functions.sendAmount(tf[0],tf[1]).transact({'txType':"0x3", 'from':w3.eth.accounts[0], 'gas':6721974})
        # print(status)
        success_txn+=1
    
    except:
        pass
    
    # print(type(status))
    # if(status):
    #     success_txn+=1


    if(tot_txn%100==0):
        # print(success_txn,tot_txn)
        group_succ_txn.append(success_txn)
        success_txn=0
        tot_txn=0

    
# for key,value in list_of_edges:
#     try:
#         contract.functions.closeAccount(key,value).transact({'txType':"0x3", 'from':w3.eth.accounts[0], 'gas':2409638})
#     except:
#         print("account closing failed")
# plot_success(group_succ_txn)
winsound.Beep(frequency, duration)
winsound.Beep(frequency, duration)
winsound.Beep(frequency, duration)
print(group_succ_txn)
# x = list(range(100,1100,100))
# y = group_succ_txn
# plt.bar(x,y,50)
# plt.show()
# print(success_txn)
visualize_network(G)

