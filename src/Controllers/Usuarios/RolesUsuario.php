<?php
namespace Controllers\Usuarios;

use Controllers\PrivateController;
use Dao\Security\Security as DaoSecurity;
use Views\Renderer;

class RolesUsuario extends PrivateController
{
    private $viewData = [];

    public function run(): void
    {
        $usercod = $_GET["usercod"] ?? 0;

        if (!$usercod) {
            die("Usuario no válido");
        }

        if (isset($_POST["addRol"])) {
            DaoSecurity::addRolToUser($usercod, $_POST["rolcod"]);
        }

        if (isset($_POST["removeRol"])) {
            DaoSecurity::removeRolFromUser($usercod, $_POST["rolcod"]);
        }

        $this->viewData["usercod"] = $usercod;
        $this->viewData["rolesAsignados"] = DaoSecurity::getRolesByUsuario($usercod);
        $this->viewData["rolesDisponibles"] = DaoSecurity::getUnAssignedRoles($usercod);

        Renderer::render("usuarios/rolesusuario", $this->viewData);
    }
}