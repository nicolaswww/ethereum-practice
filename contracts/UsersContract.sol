pragma solidity ^0.4.24;

contract UsersContract {

    // estructura de contrato
    struct User {
        string name;
        string surName;
    }

    // coleccion de usuarios (mapping): permite enlazar direcciones de ethereum a usuarios. Para cada direccion representaremos un usuario
    mapping(address => User) private users;
    mapping(address => bool) private joinedUsers;
    address[] total;

    event onUserJoined(address, string);

    // con esta funcion los usuarios van a poder registrarse para pasar a formar parte de nuestro mapping de usuarios
    function join(string name, string surName) public {
        // valida que el usuario no se haya registrado previamente
        require(!userJoined(msg.sender));

        // usamos address de la persona que está enviando la transacción
        // la key (msg.sender) viene representado en la address
        User storage user = users[msg.sender];
        user.name = name;
        user.surName = surName;

        /*
        Utilizando memory se podrían realizar cambios en memoria que solo afectarían a este scope:
        User memory user = users[msg.sender];
        user.name = name;
        user.surName = surName;

        Si se utiliza storage los cambios realizados si persisten.
        */

        // guarda usuarios registrados para evitar que vuelvan a hacerlo
        joinedUsers[msg.sender] = true;

        // registro de array de todas las direcciones
        total.push(msg.sender);

        // emite evento al unirse un usuario
        emit onUserJoined(msg.sender, string(abi.encodePacked(name, " ", surName)));
    }

    // devuelve nombre y apellido del usuario que hace la transacción
    // view: solamente recupera datos, no hace modificaciones
    function getUser(address addr) public view returns (string, string) {
        // valida que el usuario esté registrado
        require(userJoined(msg.sender));

        // se usa memory ya que solo se consultan datos, no se modifican
        User memory user = users[addr];
        return (user.name, user.surName);
    }

    // retorna si la dirección ha sido registrada
    function userJoined(address addr) private view returns (bool) {
        return joinedUsers[addr];
    }

    // retorna cantidad de usuarios
    function totalUsers() public view returns (uint) {
        return total.length;
    }

}