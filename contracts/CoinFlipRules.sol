pragma solidity ^0.5.0;

contract CoinFlip {
    struct Game {
        address playerOne;
        address playerTwo;
        GameState state;
    }
    mapping (uint256 => Game) allGames;
    enum GameState { NEW, FINISHED }

    modifier isNewGame (uint256 uid) {
        require (allGames[uid].state == GameState.NEW);
        _;
    }

    modifier validPlayer(uint256 uid, address winner) {
        require (allGames[uid].playerTwo == winner || allGames[uid].playerOne == winner);
        _;
    }

    function newGame(uint256 uid, address dst) public {
        allGames[uid] = Game(msg.sender, dst, GameState.NEW);
    }

    function gameEnded(uint256 uid, address winner) public validPlayer(uid,winner) isNewGame(uid) {
        allGames[uid].state = GameState.FINISHED;
    }

}