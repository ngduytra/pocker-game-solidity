// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./struct.sol";
import "./token.sol";

// import "./RandomNumberConsumerV2.sol";
// import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
// import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract Poker is PokerStruct, Token {
    uint battleTotal;
    mapping(uint => address) public battleToOwner;
    Battle[] public battles;

    // Event
    event CreateBattle(address owner, address betToken, uint amount, uint id);
    event JoinBattleEvent(
        address owner,
        address player,
        address betToken,
        uint amount
    );
    event ExecuteBattle(
        address indexed owner,
        address player,
        address betToken,
        address winner,
        uint amount,
        uint256 aa
    );
    event ClaimBattleEvent(address claimer, uint battle, uint amount);

    // modifier checkERC20(address _tokenAddress) {
    //     require(isERC20(_tokenAddress), "Invalid token");
    //     _;
    // }

    modifier battleOwner(uint battleid) {
        Battle memory battle = battles[battleid];
        require(battle.owner == msg.sender);
        _;
    }

    // checkERC20(_token)

    function createBattle(address _token, uint _amount) public {
        Token token = Token(_token);

        require(_amount > 0, "Game is not free");
        require(token.balanceOf(msg.sender) > _amount, "Not enough balance!");

        token.transferFrom(msg.sender, address(this), _amount);

        battles.push(
            Battle(
                msg.sender,
                address(0),
                address(0),
                _token,
                _amount,
                BattleState.Wait
            )
        );
        uint id = battles.length - 1;
        battleToOwner[id] = msg.sender;

        emit CreateBattle(msg.sender, _token, _amount, id);
    }

    function joinBattle(uint _battleId) public {
        Battle storage battle = battles[_battleId];
        Token token = Token(battle.bet_token);
        require(
            token.balanceOf(msg.sender) > battle.amount,
            "Not enough balance!"
        );
        require(battle.state == BattleState.Wait, "Can't join now!");

        token.transferFrom(msg.sender, address(this), battle.amount);

        battle.player = msg.sender;
        battle.state = BattleState.Playing;

        emit JoinBattleEvent(
            battle.owner,
            msg.sender,
            battle.bet_token,
            battle.amount
        );
    }

    function executeBattle(uint _battleId) public battleOwner(_battleId) {
        Battle storage battle = battles[_battleId];
        require(battle.state == BattleState.Playing, "No One joined!");

        // requestRandomWords();
        uint random = 70;

        if (random > 50) {
            battle.winner = battle.owner;
        } else {
            battle.winner = battle.player;
        }

        battle.state = BattleState.Finish;

        emit ExecuteBattle(
            battle.owner,
            battle.player,
            battle.bet_token,
            battle.winner,
            battle.amount,
            random
        );
    }

    function claimBattle(uint _battleId) public {
        Battle storage battle = battles[_battleId];
        require(battle.state == BattleState.Finish, "Game not finished!");
        require(battle.winner == msg.sender, "You are a thief!");

        Token token = Token(battle.bet_token);
        token.transfer(battle.winner, battle.amount * 2);

        battle.state = BattleState.Claimed;

        emit ClaimBattleEvent(battle.winner, _battleId, battle.amount);
    }
}
