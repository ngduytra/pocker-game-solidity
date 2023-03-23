// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract PokerStruct {
    enum BattleState {
        Wait,
        Playing,
        Finish,
        Claimed
    }

    struct Battle {
        address owner;
        address player;
        address winner;
        address bet_token;
        uint amount;
        BattleState state;
    }
}
