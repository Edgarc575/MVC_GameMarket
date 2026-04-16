<?php
namespace Dao\Security;

if (version_compare(phpversion(), '7.4.0', '<')) {
    define('PASSWORD_ALGORITHM', 1);
} else {
    define('PASSWORD_ALGORITHM', '2y');
}

use Exception;

class Security extends \Dao\Table
{
    static public function getusuario($filter = "", $page = -1, $items = 0)
    {
        $sqlstr = "";
        if ($filter == "" && $page == -1 && $items == 0) {
            $sqlstr = "SELECT * FROM usuario;";
        } else {
            if ($page == -1 && $items == 0) {
                $sqlstr = sprintf("SELECT * FROM usuario %s;", $filter);
            } else {
                $offset = (($page - 1) * $items);
                $sqlstr = sprintf(
                    "SELECT * FROM usuario %s limit %d, %d;",
                    $filter,
                    $offset,
                    $items
                );
            }
        }
        return self::obtenerRegistros($sqlstr, array());
    }

    static public function newUsuario($email, $password)
    {
        if (!\Utilities\Validators::IsValidEmail($email)) {
            throw new Exception("Correo no es válido");
        }
        if (!\Utilities\Validators::IsValidPassword($password)) {
            throw new Exception("Contraseña debe ser almenos 8 caracteres, 1 número, 1 mayúscula, 1 símbolo especial");
        }

        $newUser = self::_usuariotruct();
        $hashedPassword = self::_hashPassword($password);

        unset($newUser["usercod"]);
        unset($newUser["userfching"]);
        unset($newUser["userpswdchg"]);

        $newUser["useremail"] = $email;
        $newUser["username"] = "John Doe";
        $newUser["userpswd"] = $hashedPassword;
        $newUser["userpswdest"] = Estados::ACTIVO;
        $newUser["userpswdexp"] = date('Y-m-d', time() + 7776000); 
        $newUser["userest"] = Estados::ACTIVO;
        $newUser["useractcod"] = hash("sha256", $email.time());
        $newUser["usertipo"] = UsuarioTipo::PUBLICO;

        $sqlIns = "INSERT INTO `usuario` (`useremail`, `username`, `userpswd`,
            `userfching`, `userpswdest`, `userpswdexp`, `userest`, `useractcod`,
            `userpswdchg`, `usertipo`)
            VALUES
            ( :useremail, :username, :userpswd,
            now(), :userpswdest, :userpswdexp, :userest, :useractcod,
            now(), :usertipo);";

        return self::executeNonQuery($sqlIns, $newUser);
    }

    static public function getUsuarioByEmail($email)
    {
        $sqlstr = "SELECT * from `usuario` where `useremail` = :useremail ;";
        $params = array("useremail"=>$email);
        return self::obtenerUnRegistro($sqlstr, $params);
    }

    static private function _saltPassword($password)
    {
        return hash_hmac("sha256", $password, \Utilities\Context::getContextByKey("PWD_HASH"));
    }

    static private function _hashPassword($password)
    {
        return password_hash(self::_saltPassword($password), PASSWORD_ALGORITHM);
    }

    static public function verifyPassword($raw_password, $hash_password)
    {
        return password_verify(self::_saltPassword($raw_password), $hash_password);
    }

    static private function _usuariotruct()
    {
        return array(
            "usercod"      => "",
            "useremail"    => "",
            "username"     => "",
            "userpswd"     => "",
            "userfching"   => "",
            "userpswdest"  => "",
            "userpswdexp"  => "",
            "userest"      => "",
            "useractcod"   => "",
            "userpswdchg"  => "",
            "usertipo"     => "",
        );
    }

    static public function getFeature($fncod)
{
    $sqlstr = "SELECT * FROM funciones WHERE funurl = :funurl LIMIT 1;";
    $featuresList = self::obtenerRegistros($sqlstr, array("funurl"=>$fncod));
    return count($featuresList) > 0;
}

    static public function addNewFeature($fncod, $fndsc, $fnest, $fntyp = "CTR")
{
    $sqlCheck = "SELECT 1 FROM funciones WHERE funurl = :funurl LIMIT 1;";
    $exists = self::obtenerUnRegistro($sqlCheck, array("funurl" => $fncod));

    if (!$exists) {
        $sqlins = "INSERT INTO funciones (fundsc, funurl, funest)
                   VALUES (:fundsc, :funurl, :funest);";

        return self::executeNonQuery($sqlins, array(
            "fundsc" => $fndsc,
            "funurl" => $fncod,
            "funest" => $fnest
        ));
    }
    return 0;
}


   static public function getFeatureByUsuario($userCod, $fncod)
{
    $sqlstr = "SELECT f.funcod 
        FROM funciones f
        INNER JOIN funciones_roles fr ON f.funcod = fr.funcod
        INNER JOIN roles_usuarios ru ON fr.rolcod = ru.rolcod
        WHERE ru.usercod = :usercod 
          AND f.funurl = :funurl
        LIMIT 1;";

    $resultados = self::obtenerRegistros($sqlstr, array(
        "usercod"=> $userCod,
        "funurl" => $fncod
    ));

    return count($resultados) > 0;
}

    static public function getRol($rolcod)
    {
        $sqlstr = "SELECT * from roles where rolcod=:rolcod;";
        $featuresList = self::obtenerRegistros($sqlstr, array("rolcod" => $rolcod));
        return count($featuresList) > 0;
    }

    static public function addNewRol($rolcod, $roldsc, $rolest)
    {
        $sqlins = "INSERT INTO `roles` (`rolcod`, `roldsc`, `rolest`)
        VALUES (:rolcod, :roldsc, :rolest);";

        return self::executeNonQuery($sqlins, array(
                "rolcod" => $rolcod,
                "roldsc" => $roldsc,
                "rolest" => $rolest
            ));
    }

    static public function isUsuarioInRol($userCod, $rolename)
{
    $sqlstr = "SELECT r.rolcod 
        FROM roles r
        INNER JOIN roles_usuarios ru ON r.rolcod = ru.rolcod
        WHERE ru.usercod = :usercod 
          AND r.roldsc = :roldsc
        LIMIT 1;";

    $resultados = self::obtenerRegistros($sqlstr, array(
        "usercod" => $userCod,
        "roldsc" => $rolename
    ));

    return count($resultados) > 0;
}

    static public function getRolesByUsuario($userCod)
    {
        $sqlstr = "SELECT a.* FROM roles a 
                   INNER JOIN roles_usuarios b on a.rolcod = b.rolcod 
                   WHERE a.rolest = 'ACT' and b.usercod=:usercod;";
        
        return self::obtenerRegistros($sqlstr, array("usercod" => $userCod));
    }

    static public function removeRolFromUser($userCod, $rolcod)
    {
        $sqldel = "DELETE FROM roles_usuarios WHERE rolcod=:rolcod and usercod=:usercod;";
        return self::executeNonQuery($sqldel, array("rolcod"=>$rolcod, "usercod"=>$userCod));
    }

    static public function removeFeatureFromRol($funcod, $rolcod)
    {
        $sqldel = "DELETE FROM funciones_roles WHERE funcod=:funcod and rolcod=:rolcod;";
        return self::executeNonQuery($sqldel, array("funcod" => $funcod, "rolcod" => $rolcod));
    }

    static public function getUnAssignedRoles($userCod)
{
    $sqlstr = "SELECT *
        FROM roles
        WHERE rolest = 'ACT'
        AND rolcod NOT IN (
            SELECT rolcod
            FROM roles_usuarios
            WHERE usercod = :usercod
        );";

    return self::obtenerRegistros($sqlstr, array(
        "usercod" => $userCod
    ));
}

static public function addRolToUser($userCod, $rolcod)
{
    $sqlins = "INSERT INTO roles_usuarios (rolcod, usercod)
        SELECT :rolcod, :usercod
        WHERE NOT EXISTS (
            SELECT 1 FROM roles_usuarios
            WHERE rolcod = :rolcod AND usercod = :usercod
        );";

    return self::executeNonQuery($sqlins, array(
        "rolcod" => $rolcod,
        "usercod" => $userCod
    ));
}

   // static public function getUnAssignedFeatures($rolcod) {}
   // static public function getUnAssignedRoles($userCod) {}

    private function __construct() {}
    private function __clone() {}
}
