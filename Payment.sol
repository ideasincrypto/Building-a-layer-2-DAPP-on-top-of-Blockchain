// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract Payment {
  constructor() {
  }

    struct User {
        uint32 user_id;
        string user_name;
        bool exists;
        uint32 balance;
        mapping(uint32 => JointAcc) jointAccounts;
        uint32[] jointAccountsList;
        uint32 numJointAccounts;
    }

    struct JointAcc {
        uint32 user_id;
        uint32 balance;
    }

uint32 public numTotalUsers = 0;
string public name2 = "Payment";
  // Mapping of user IDs to users
  mapping(uint32 => User) public users;

//   // Mapping of joint account IDs to joint accounts
//   mapping(uint32 => JointAcc) public jointAccounts;

  event Transfer(address indexed from, address indexed to, uint32 value);

  // Event to indicate that a user has been registered
  event UserRegistered(uint32 indexed userId, string name);

  // Event to indicate that a joint account has been created
  event JointAccountCreated(uint32 indexed jointAccountId, uint32 indexed userId1, uint32 indexed userId2);

  //Event to indicate that a joint account has been closed
 event JointAccountClosed(uint32 indexed jointAccountId, uint32 indexed userId1, uint32 indexed userId2);

 error InsufficientBalance(uint32 requested, uint32 available);
  
  function registerUser(uint32 userId, string memory name) public {
    // Check if the user already exists
    require(!users[userId].exists, "User ID already exists");

      // Create a new user with the specified ID, name, and balance
    //   User memory newUser = User({
    //       user_id: userId,
    //       user_name: name,
    //       exists: true,
    //       balance: 0
    //   });

        User storage newUser = users[userId];
        newUser.user_id = userId;
        newUser.user_name = name;
        newUser.exists = true;
        newUser.balance = 0;
        newUser.numJointAccounts = 0;
        newUser.jointAccountsList = new uint32[](0);
        // Add the new user to the mapping
        numTotalUsers++;

        name2 = "faknfkn";

        // require(users[userId].exists,users[userId].user_name);
      // Emit a UserRegistered event to indicate that the user has been registered
      emit UserRegistered(userId, name);
  } 
  
  function createAcc(uint32 userId1, uint32 userId2, uint32 init_balance) public {
    // Check if both users exist
    // uint32 a = 21;
    // bytes memory b = new bytes(a);
    require(users[0].exists, name2);
    require(users[userId2].exists, "User 2 does not exist");

    User storage user1 = users[userId1];
    User storage user2 = users[userId2];
    // Check if the joint account already exists
    require(!checkJointAccountExists(userId1, userId2), "Joint account already exists");

    // Create a new joint account with the specified user IDs and a balance of 0
    JointAcc memory newJointAccount_u1 = JointAcc({
        user_id: userId2,
        balance: init_balance/2
        // balance: 100
    });
    JointAcc memory newJointAccount_u2 = JointAcc({
        user_id: userId1,
        balance: init_balance/2
        // balance: 100
    });

    // Add the new joint account to the mapping
    user1.jointAccounts[userId2] = newJointAccount_u1;
    user1.jointAccountsList.push(userId2);
    user1.numJointAccounts++;
    user2.jointAccounts[userId1] = newJointAccount_u2;
    user2.jointAccountsList.push(userId1);
    user2.numJointAccounts++;
    user1.balance += init_balance/2;
    user2.balance += init_balance/2;
    
    // Emit a JointAccountCreated event to indicate that the joint account has been created
    emit JointAccountCreated(userId1*userId2, userId1, userId2);
  }

  // Helper function to check if a joint account already exists between two users
  function checkJointAccountExists(uint32 userId1, uint32 userId2) internal view returns (bool) {
    // Check if the joint account exists in the mapping
    return (users[userId1].jointAccounts[userId2].user_id == userId2 && users[userId2].jointAccounts[userId1].user_id == userId1);
  }


  function findShortestPath(uint32 fromUserId, uint32 toUserId) internal view returns (uint32[] memory,uint32) {
    // Check if both users exist
    require(users[fromUserId].exists, "From user does not exist");
    require(users[toUserId].exists, "To user does not exist");

    // Initialize the shortest path to be an empty array
    uint32[] memory shortestPath = new uint32[](0);

    // If the sender and receiver are the same user, return the shortest path as an array containing the user ID
    if (fromUserId == toUserId) {
        shortestPath = new uint32[](1);
        shortestPath[0] = fromUserId;
        return (shortestPath,1);
    }

    // Initialize the queue to be an empty array
    uint32[100] memory queue;
    uint32 queue_size = 0;
    // queue = new uint32[](0);

    // Initialize the visited array to be an array of 100 false values
    bool[100] memory visited;

    // Initialize the parent array to be an array of 100 0 values
    uint32[100] memory parent;
    
    // Initialize the distance array to be an array of 100 0 values
    // uint32[100] memory distance;

    // Add the sender's user ID to the queue
    queue[queue_size++] = fromUserId;
    parent[fromUserId]=fromUserId;

    // Mark the sender's user ID as visited
    visited[fromUserId] = true;

    // Set the distance of the sender's user ID to 0
    // distance[fromUserId] = 0;

    // While the queue is not empty
    while (queue_size > 0) {
        // Remove the first element from the queue
        uint32 currUserId = queue[0];
        for (uint i = 0; i < queue_size - 1; i++) {
            queue[i] = queue[i + 1];
        }
        queue_size--;

        // If the current user ID is the receiver's user ID
        if (currUserId == toUserId) {
            // Initialize the shortest path to be an array of the same size as the distance of the receiver's user ID
            shortestPath = new uint32[](100);
            uint32 num=0;

            // Set the last element of the shortest path to be the receiver's user ID
            

            // Set the second last element of the shortest path to be the parent of the receiver's user ID
            
            
            // Iterate backwards through the shortest path
            while(toUserId!=parent[toUserId]) {
                // Set the current element of the shortest path to be the parent of the previous element
                shortestPath[num++] = toUserId;
                // shortestPath[num++] = parent[toUserId];
                toUserId = parent[toUserId];
                
            }
            shortestPath[num++] = toUserId;
            // Return the shortest path
            return (shortestPath,num);
        }

        // Iterate through the joint accounts of the current user
        for (uint i = 0; i < users[currUserId].numJointAccounts; i++) {
            // Get the user ID of the joint account
            uint32 jointUserId = users[currUserId].jointAccounts[users[currUserId].jointAccountsList[i]].user_id;

            // If the joint account has not been visited
            if (!visited[jointUserId]) {
                // Add the joint account to the queue
                queue[queue_size++] = jointUserId;

                // Mark the joint account as visited
                visited[jointUserId] = true;

                // Set the parent of the joint account to be the current user ID
                parent[jointUserId] = currUserId;

                // Set the distance of the joint account to be the distance of the current user ID plus 1
                // distance[jointUserId] = distance[currUserId] + 1;
            }
            
        }

    }
    require(1==2,"no path exists");
    // Return the shortest path
    return (shortestPath,100);
}

    function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
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

  function sendAmount(uint32 fromUserId, uint32 toUserId) public returns (bool){
    uint32 amount = 1;

    // Check if both users exist
    string memory a = uint2str(users[fromUserId].balance);
    require(users[fromUserId].exists, "From user does not exist");
    require(users[toUserId].exists, "To user does not exist");
    
    // Check if the user has sufficient balance to send the amount
    require(users[fromUserId].balance >= amount, a);
    // require(users[fromUserId].balance >= amount, a.toString());
    if(users[fromUserId].balance < amount){
        revert InsufficientBalance({requested:amount,  available:users[fromUserId].balance});
        // return false;
    }

    // Find the shortest path between the two users
    (uint32[] memory path,uint32 num) = findShortestPath(fromUserId, toUserId);

    // Transfer the amount along the path
    require(num<=100,"infi loop");
    for (uint i = 0; i < num - 1; i++) {
        uint32 currUserId = path[i];
        uint32 nextUserId = path[i + 1];
        // require(currUserId>=0,"negative curuserid");
        // require(nextUserId>=0,"negative nextuserid");
        // If a joint account exists between the two users, transfer the amount from the joint account
        if (checkJointAccountExists(currUserId, nextUserId)) {
            // JointAcc storage jointAcc = jointAccounts[jointAccId];
            JointAcc storage jointAccCurr = users[currUserId].jointAccounts[nextUserId];
            // require(jointAcc.balance_u1 >= amount, "Insufficient joint account balance");
            a = uint2str(jointAccCurr.balance);
            require(jointAccCurr.balance >= amount, "Insuffiecient amount in path");
            JointAcc storage jointAccNext = users[nextUserId].jointAccounts[currUserId];

            if(jointAccNext.balance < amount){
                revert InsufficientBalance({requested:amount,  available:jointAccNext.balance});
                // return false;
            }
            jointAccCurr.balance += amount;
            jointAccNext.balance -= amount;
        }
        else
        {
            require(2==1, "Joint account does not exist in the returned path, check");
        }
    }

    // Update the total balances of the two users
    users[fromUserId].balance -= amount;
    users[toUserId].balance += amount;
    // Emit a Transfer event to indicate that the amount has been transferred
    emit Transfer(msg.sender, address(this), amount);
    return true;
}

function removeJointAccount(uint32 userId, uint32 to_userid) internal {
    // Get the user
    User storage user = users[userId];

    // Remove the joint account from the list of joint accounts

    user.jointAccounts[to_userid].user_id = 0;
}

function closeAccount(uint32 userid_1, uint32 userid_2) public {
    // Check if both users exist
    require(users[userid_1].exists, "User 1 does not exist");
    require(users[userid_2].exists, "User 2 does not exist");

    // Check if a joint account exists between the two users
    require(checkJointAccountExists(userid_1, userid_2), "Joint account does not exist");

    // Get the users
    User storage user_1 = users[userid_1];
    User storage user_2 = users[userid_2];

   
    JointAcc storage jointAcc1 = user_1.jointAccounts[userid_2];
    JointAcc storage jointAcc2 = user_2.jointAccounts[userid_1];

    // Check if the joint account is empty
    require(jointAcc1.balance == 0 && jointAcc2.balance == 0, "Joint account is not empty");

    // Remove the joint account from the list of joint accounts for both users
    removeJointAccount(userid_1, userid_2);
    removeJointAccount(userid_2, userid_1);

    // Emit a JointAccountClosed event to indicate that the joint account has been closed
    emit JointAccountClosed(userid_1*userid_2, userid_1, userid_2);
}

}


