<?php
namespace Dao\Proveedores;

use Dao\Table;

class Proveedores extends Table {
    public static function getProveedores(
        string $partialNombre = "",
        string $orderBy = "",
        bool $orderDescending = false,
        int $page = 0,
        int $itemsPerPage = 10
    ) {
        $sqlstr = "SELECT p.provcod, p.provnom, p.provtel, p.provemail, p.provdir, p.provest FROM proveedor p";
        $sqlstrCount = "SELECT COUNT(*) as count FROM proveedor p";
        $conditions = [];
        $params = [];

        if ($partialNombre != "") {
            $conditions[] = "p.provnom LIKE :partialNombre";
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
            "proveedores" => $registros, 
            "total" => $numeroDeRegistros, 
            "page" => $page, 
            "itemsPerPage" => $itemsPerPage
        ];
    }

    public static function getProveedorById(int $provcod) {
        $sqlstr = "SELECT * FROM proveedor WHERE provcod = :provcod";
        $params = ["provcod" => $provcod];
        return self::obtenerUnRegistro($sqlstr, $params);
    }

    public static function insertProveedor($provnom, $provtel, $provemail, $provdir, $provest) {
        $sqlstr = "INSERT INTO proveedor (provnom, provtel, provemail, provdir, provest) 
                   VALUES (:provnom, :provtel, :provemail, :provdir, :provest)";
        $params = [
            "provnom" => $provnom, 
            "provtel" => $provtel, 
            "provemail" => $provemail, 
            "provdir" => $provdir,
            "provest" => $provest
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function updateProveedor($provcod, $provnom, $provtel, $provemail, $provdir, $provest) {
        $sqlstr = "UPDATE proveedor SET provnom=:provnom, provtel=:provtel, 
                   provemail=:provemail, provdir=:provdir, provest=:provest 
                   WHERE provcod=:provcod";
        $params = [
            "provcod" => $provcod,
            "provnom" => $provnom,
            "provtel" => $provtel,
            "provemail" => $provemail,
            "provdir" => $provdir,
            "provest" => $provest
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function deleteProveedor(int $provcod) {
        $sqlstr = "DELETE FROM proveedor WHERE provcod = :provcod";
        $params = ["provcod" => $provcod];
        return self::executeNonQuery($sqlstr, $params);
    }
}