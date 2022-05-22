// Easy as calling destroy

interface ISimpleToken {
    function transfer(address _to, uint256 _amount) external;

    function destroy(address payable _to) external;
}

interface IRecovery {
    function generateToken(string memory _name, uint256 _initialSupply)
        external;
}

