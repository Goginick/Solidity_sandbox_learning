//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;


//This contract imitates a betting process of CSGO-roulette-2017-alike
//Each bet beholds to a participant
//Each participant have a Name, Bet and Percent

//Percent of the each Participant should change with every change of the pool
contract PoolOfNumbers {


//Struct of a Gamble Pool
struct Pool{
    uint totalAmount;     //Total amount of money in the Gamble Pool
    uint numOfParticipants; //Number of participants of the Gamble Pool
    string[] participants; //Array of participants in order of their entrance
    uint[] bets; //Array of participant's bets in order of their entrance
    uint[] percents;
    bool isEnded; //Is Pool already closed?
}

//Variables for store a pools
uint numOfPools;    //how many pools were
mapping (uint => Pool) pools; //map of past pools

//Create a new Gamble Pool
function newPool() public returns (uint poolID){

    poolID = numOfPools++; //returning variable
    pools[poolID].isEnded = false;
    //Pool storage pool = pools[poolID]; //creating a pool. Need to check it existance(more for production)
}

//Participate in Gamble Pool
function participate(uint poolID, string memory name, uint bet) public{
    require(poolID <= numOfPools, "Session of Gambling Pool didn't start yet!");
    Pool storage pool = pools[poolID];    

    pool.participants.push(name);
    pool.bets.push(bet);
    delete pool.percents;

    pool.numOfParticipants += 1;
    pool.totalAmount += bet;


//Next block is a bercent of winning chance calculator. consider output x.00. hundredth shit.  
    uint currentPercent;
    for(uint i=0; i < pool.numOfParticipants; i++){
        if(pool.numOfParticipants == 1){currentPercent = 100; pool.percents.push(currentPercent);}
        else{
            currentPercent = ((100*pool.bets[i])*100 / pool.totalAmount); pool.percents.push(currentPercent);
        }
        

    }

    
}

//Logger function to show current state of Pool
function showPool(uint poolID) public view returns(uint totalAmount, uint numOfParticipants, uint[] memory participantPercents){
require(poolID <= numOfPools, "Session of Gambling Pool didn't start yet!");

    Pool storage pool = pools[poolID];
    participantPercents = pool.percents;
    totalAmount = pool.totalAmount;
    numOfParticipants = pool.numOfParticipants;
}

//Roll the lottery
// function roll(uint poolID) public returns(uint[] memory percentsOfWinning){
// require(poolID <= numOfPools, "Session of Gambling Pool didn't start yet!");

  
// }






}