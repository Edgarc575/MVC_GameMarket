<?php
namespace Dao\Facturas;

use Dao\Table;

class Facturas extends Table {
    public static function getFacturas(
        string $partialCod = "",
        string $orderBy = "f.factcod",
        bool $orderDescending = true,
        int $page = 0,
        int $itemsPerPage = 10
    ) {
        $sqlstr = "SELECT f.factcod, f.clicod, c.clinom, f.usercod, u.username, 
                          f.factfecha, f.facttotal, f.factest 
                   FROM factura f 
                   INNER JOIN cliente c ON f.clicod = c.clicod
                   INNER JOIN usuario u ON f.usercod = u.usercod";
        
        $sqlstrCount = "SELECT COUNT(*) as count
                        FROM factura f
                        INNER JOIN cliente c ON f.clicod = c.clicod";
        $conditions = [];
        $params = [];

        if ($partialCod != "") {
            $conditions[] = "(CAST(f.factcod AS CHAR) LIKE :partialCod OR c.clinom LIKE :partialNombre)";
            $params["partialCod"] = "%" . $partialCod . "%";
            $params["partialNombre"] = "%" . $partialCod . "%";
        }

        if (count($conditions) > 0) {
            $where = " WHERE " . implode(" AND ", $conditions);
            $sqlstr .= $where;
            $sqlstrCount .= $where;
        }

        $sqlstr .= " ORDER BY " . $orderBy . ($orderDescending ? " DESC" : " ASC");

        $numeroDeRegistros = self::obtenerUnRegistro($sqlstrCount, $params)["count"];
        $pagesCount = ceil($numeroDeRegistros / $itemsPerPage);
        if ($page > $pagesCount - 1 && $pagesCount > 0) {
            $page = $pagesCount - 1;
        }
        
        $sqlstr .= " LIMIT " . ($page * $itemsPerPage) . ", " . $itemsPerPage;
        
        return [
            "facturas" => self::obtenerRegistros($sqlstr, $params), 
            "total" => $numeroDeRegistros, 
            "page" => $page, 
            "itemsPerPage" => $itemsPerPage
        ];
    }

    public static function getFacturaById(int $factcod) {
        $sqlstr = "SELECT * FROM factura WHERE factcod = :factcod";
        return self::obtenerUnRegistro($sqlstr, ["factcod" => $factcod]);
    }

    public static function insertFactura($clicod, $usercod, $factfecha, $facttotal, $factest) {
        $sqlstr = "INSERT INTO factura (clicod, usercod, factfecha, facttotal, factest) 
                   VALUES (:clicod, :usercod, :factfecha, :facttotal, :factest)";
        return self::executeNonQuery($sqlstr, [
            "clicod" => $clicod, "usercod" => $usercod, 
            "factfecha" => $factfecha, "facttotal" => $facttotal, "factest" => $factest
        ]);
    }

    public static function updateFactura($factcod, $clicod, $usercod, $factfecha, $facttotal, $factest) {
        $sqlstr = "UPDATE factura SET clicod=:clicod, usercod=:usercod, 
                   factfecha=:factfecha, facttotal=:facttotal, factest=:factest 
                   WHERE factcod=:factcod";
        return self::executeNonQuery($sqlstr, [
            "factcod" => $factcod, "clicod" => $clicod, "usercod" => $usercod,
            "factfecha" => $factfecha, "facttotal" => $facttotal, "factest" => $factest
        ]);
    }

    public static function deleteFactura(int $factcod) {
        return self::executeNonQuery("DELETE FROM factura WHERE factcod = :factcod", ["factcod" => $factcod]);
    }
}
