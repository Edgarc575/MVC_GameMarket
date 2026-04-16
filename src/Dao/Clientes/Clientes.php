<?php
namespace Dao\Clientes;

use Dao\Table;

class Clientes extends Table {
    public static function getClientes(
        string $partialNombre = "",
        string $orderBy = "",
        bool $orderDescending = false,
        int $page = 0,
        int $itemsPerPage = 10
    ) {
        $sqlstr = "SELECT c.clicod, c.clinom, c.clitel, c.cliemail, c.clidir, c.cliest FROM cliente c";
        $sqlstrCount = "SELECT COUNT(*) as count FROM cliente c";
        $conditions = [];
        $params = [];

        if ($partialNombre != "") {
            $conditions[] = "c.clinom LIKE :partialNombre";
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
            "clientes" => $registros, 
            "total" => $numeroDeRegistros, 
            "page" => $page, 
            "itemsPerPage" => $itemsPerPage
        ];
    }

    public static function getClienteById(int $clicod) {
        $sqlstr = "SELECT * FROM cliente WHERE clicod = :clicod";
        $params = ["clicod" => $clicod];
        return self::obtenerUnRegistro($sqlstr, $params);
    }

    public static function insertCliente($clinom, $clitel, $cliemail, $clidir, $cliest) {
        $sqlstr = "INSERT INTO cliente (clinom, clitel, cliemail, clidir, cliest) 
                   VALUES (:clinom, :clitel, :cliemail, :clidir, :cliest)";
        $params = [
            "clinom" => $clinom, 
            "clitel" => $clitel, 
            "cliemail" => $cliemail, 
            "clidir" => $clidir,
            "cliest" => $cliest
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function updateCliente($clicod, $clinom, $clitel, $cliemail, $clidir, $cliest) {
        $sqlstr = "UPDATE cliente SET clinom=:clinom, clitel=:clitel, 
                   cliemail=:cliemail, clidir=:clidir, cliest=:cliest 
                   WHERE clicod=:clicod";
        $params = [
            "clicod" => $clicod,
            "clinom" => $clinom,
            "clitel" => $clitel,
            "cliemail" => $cliemail,
            "clidir" => $clidir,
            "cliest" => $cliest
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function deleteCliente(int $clicod) {
        $sqlstr = "DELETE FROM cliente WHERE clicod = :clicod";
        $params = ["clicod" => $clicod];
        return self::executeNonQuery($sqlstr, $params);
    }
}