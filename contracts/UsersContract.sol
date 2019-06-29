pragma solidity ^0.4.24;

contract UsersContract {

    struct User {
        string name;
        string surName;
    }

    mapping(address => User) private users;
    mapping(address => bool) private joinedUsers;
    address[] total;

    event OnUserJoined(address, string);

    /**
     * users join
     * @param name {string} - user name
     * @param surName {string} - user surname
     */
    function join(string name, string surName) public {
        require(!userJoined(msg.sender), "Account already joined");

        User storage user = users[msg.sender];
        user.name = name;
        user.surName = surName;

        joinedUsers[msg.sender] = true;
        total.push(msg.sender);
        emit OnUserJoined(msg.sender, string(abi.encodePacked(name, " ", surName)));
    }

    /**
     * get user by address
     * @param addr {string} - user address
     * @return {string} - full user name
     */
    function getUser(address addr) public view returns (string, string) {
        require(userJoined(msg.sender), "Account must be join");

        User memory user = users[addr];
        return (user.name, user.surName);
    }

    /**
     * check if the user joined
     * @param addr {string} - user address
     * @return {boolean} - user are joined
     */
    function userJoined(address addr) private view returns (bool) {
        return joinedUsers[addr];
    }

    /**
     * return users quantity
     * @return {number} - users
     */
    function totalUsers() public view returns (uint) {
        return total.length;
    }

}