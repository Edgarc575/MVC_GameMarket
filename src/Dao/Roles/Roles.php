<?php
namespace Dao\Roles;

use Dao\Table;

class Roles extends Table
{
    public static function getRoles(
        string $partialNombre = "",
        string $orderBy = "",
        bool $orderDescending = false,
        int $page = 0,
        int $itemsPerPage = 10
    ) {
        $sqlstr = "SELECT rolcod, roldsc, rolest FROM roles";
        $sqlstrCount = "SELECT COUNT(*) as count FROM roles";
        $conditions = [];
        $params = [];

        if ($partialNombre != "") {
            $conditions[] = "roldsc LIKE :partialNombre";
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
            "roles" => $registros,
            "total" => $numeroDeRegistros,
            "page" => $page,
            "itemsPerPage" => $itemsPerPage
        ];
    }

    public static function getRolesById(int $rolcod)
    {
        $sqlstr = "SELECT * FROM roles WHERE rolcod = :rolcod";
        return self::obtenerUnRegistro($sqlstr, ["rolcod" => $rolcod]);
    }

    public static function insertRoles($roldsc, $rolest)
    {
        $sqlstr = "INSERT INTO roles (roldsc, rolest) VALUES (:roldsc, :rolest)";
        return self::executeNonQuery($sqlstr, [
            "roldsc" => $roldsc,
            "rolest" => $rolest
        ]);
    }

    public static function updateRoles($rolcod, $roldsc, $rolest)
    {
        $sqlstr = "UPDATE roles SET roldsc = :roldsc, rolest = :rolest WHERE rolcod = :rolcod";
        return self::executeNonQuery($sqlstr, [
            "rolcod" => $rolcod,
            "roldsc" => $roldsc,
            "rolest" => $rolest
        ]);
    }

    public static function deleteRoles(int $rolcod)
    {
        return self::executeNonQuery("DELETE FROM roles WHERE rolcod = :rolcod", ["rolcod" => $rolcod]);
    }
}
