pragma solidity ^0.4.24;

contract UsersContract {

    // estructura de contrato
    struct User {
        string name;
        string surName;
    }

    // coleccion de usuarios (mapping): permite enlazar direcciones de ethereum a usuarios. Para cada direccion representaremos un usuario
    mapping(address => User) private users;

    // con esta funcion los usuarios van a poder registrarse para pasar a formar parte de nuestro mapping de usuarios
    function join(string name, string surName) public {
        // usamos address de la persona que está enviando la transacción
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
    }

    // devuelve nombre y apellido del usuario que hace la transacción
    // view: solamente recupera datos, no hace modificaciones
    function getUser(address addr) public view returns (string, string) {
        // se usa memory ya que solo se consultan datos, no se modifican
        User memory user = users[addr];
        return (user.name, user.surName);
    }

}