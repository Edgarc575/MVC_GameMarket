<?php
namespace Dao\Usuarios;

use Dao\Table;

class Usuarios extends Table {
    public static function getUsuarios(
        string $partialNombre = "",
        string $orderBy = "",
        bool $orderDescending = false,
        int $page = 0,
        int $itemsPerPage = 10
    ) {
        $sqlstr = "SELECT usercod, useremail, username, userpswd, userfching, userpswdest, userpswdexp, userest, useractcod, userpswdchg, usertipo FROM usuario";
        $sqlstrCount = "SELECT COUNT(*) as count FROM usuario";
        $conditions = [];
        $params = [];

        if ($partialNombre != "") {
            $conditions[] = "useremail LIKE :partialNombre";
            $params["partialNombre"] = "%" . $partialNombre . "%";
        }

        if (count($conditions) > 0) {
            $where = " WHERE " . implode(" AND ", $conditions);
            $sqlstr .= $where;
            $sqlstrCount .= $where;
        }

        if ($orderBy != "") {
            $sqlstr .= " ORDER BY " . $orderBy;
            if ($orderDescending) {
                $sqlstr .= " DESC";
            }
        }

        $numeroDeRegistros = self::obtenerUnRegistro($sqlstrCount, $params)["count"];
        $pagesCount = ceil($numeroDeRegistros / $itemsPerPage);
        if ($page > $pagesCount - 1 && $pagesCount > 0) {
            $page = $pagesCount - 1;
        }
        
        $sqlstr .= " LIMIT " . ($page * $itemsPerPage) . ", " . $itemsPerPage;
        $registros = self::obtenerRegistros($sqlstr, $params);
        
        return [
            "usuarios" => $registros,
            "total" => $numeroDeRegistros, 
            "page" => $page, 
            "itemsPerPage" => $itemsPerPage
        ];
    }

    public static function getUsuarioById(int $usercod) {
        $sqlstr = "SELECT * FROM usuario WHERE usercod = :usercod";
        $params = ["usercod" => $usercod];
        return self::obtenerUnRegistro($sqlstr, $params);
    }

    public static function insertUsuario($useremail, $username, $userpswd, $userfching, $userpswdest, $userpswdexp, $userest, $useractcod, $userpswdchg, $usertipo) {
        $sqlstr = "INSERT INTO usuario (useremail, username, userpswd, userfching, userpswdest, userpswdexp, userest, useractcod, userpswdchg, usertipo ) 
                   VALUES (:useremail, :username, :userpswd, :userfching, :userpswdest, :userpswdexp, :userest, :useractcod, :userpswdchg, :usertipo)";
        $params = [
            "useremail" => $useremail, 
            "username" => $username, 
            "userpswd" => $userpswd, 
            "userfching" => $userfching,
            "userpswdest" => $userpswdest,
            "userpswdexp" => $userpswdexp,
            "userest" => $userest,
            "useractcod" => $useractcod,
            "userpswdchg" => $userpswdchg,
            "usertipo" => $usertipo
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function updateUsuario($usercod, $useremail, $username, $userpswd, $userfching, $userpswdest, $userpswdexp, $userest, $useractcod, $userpswdchg, $usertipo) {
        $sqlstr = "UPDATE usuario SET useremail=:useremail, 
                   username=:username, userpswd=:userpswd, userfching=:userfching, userpswdest=:userpswdest, userpswdexp=:userpswdexp, userest=:userest, useractcod=:useractcod, userpswdchg=:userpswdchg, usertipo=:usertipo 
                   WHERE usercod=:usercod";
        $params = [
            "usercod" => $usercod,
            "useremail" => $useremail, 
            "username" => $username, 
            "userpswd" => $userpswd, 
            "userfching" => $userfching,
            "userpswdest" => $userpswdest,
            "userpswdexp" => $userpswdexp,
            "userest" => $userest,
            "useractcod" => $useractcod,
            "userpswdchg" => $userpswdchg,
            "usertipo" => $usertipo
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function deleteUsuario(int $usercod) {
        $sqlstr = "DELETE FROM usuario WHERE usercod = :usercod";
        $params = ["usercod" => $usercod];
        return self::executeNonQuery($sqlstr, $params);
    }
}
