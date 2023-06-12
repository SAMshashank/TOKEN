// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.7.0 <0.9.0;


//EIP-20: ERC-20 Token Standard
// https://eips.ethereum.org/EIPS/eip-20
// founder address  0x016b37526D3a335eA56c08C36c9114dA1d9C3Daa
//contract address 0x5C61A1dd848830a7A41ac590De9b36B283cef8D1

interface ERC20Interface{
 function totalSupply() external view returns (uint);
 function balanceOf(address tokenOwner) external view returns (uint balance);
 function transfer(address to, uint tokens) external returns (bool success);
 function allowance(address tokenOwner, address spender) external view returns (uint remaining);
 function approve(address spender, uint tokens) external returns (bool success);
 function transferFrom(address from, address to, uint tokens) external returns (bool success);
 event Transfer(address indexed  from, address indexed  to , uint tokens);
 event Approval(address indexed tokenOwner,address indexed  spender, uint tokens);
}

contract BlocK is ERC20Interface{
     string public name="ShashankKushwaha";   //name of token
     string public symbol="SK";
     string public decimal="2";
     uint public override totalSupply;// here i am overriding the above function which is written in interface
    address public founder;
     mapping (address=>uint) public balances;// this make records of balances which is refer to particular address
     mapping(address=>mapping (address=>uint)) allowed;
     constructor(){
         totalSupply=10000000000;
         founder=msg.sender;
         balances[founder]=totalSupply;


     }
     function balanceOf(address tokenOwner) public view override  returns(uint balance){
         return balances[tokenOwner];
     }

function transfer(address to ,uint tokens) public override  returns (bool success){
    require(balances[msg.sender]>=tokens);
    balances[to]+=tokens;
    balances[msg.sender]-=tokens;
    emit Transfer(msg.sender,to,tokens);
    return true;
}
function approve(address spender,uint tokens)public override returns (bool success){
    require(balances[msg.sender]>=tokens);
    require(tokens>0);
    allowed[msg.sender][spender]=tokens;//allowed come from mapping
    emit Approval(msg.sender, spender, tokens);
    return true;
}
function allowance(address tokenOwner,address spender)public view  override  returns (uint noOfTokens){
    return allowed[tokenOwner][spender];
}
function transferFrom(address from ,address to,uint tokens) public  override  returns(bool success){
    require(allowed[from][to]>=tokens);
    require(balances[from]>=tokens);
    balances[from]-=tokens;
    balances[to]+=tokens;
    return true;
}
}
//openZepplin library for token test