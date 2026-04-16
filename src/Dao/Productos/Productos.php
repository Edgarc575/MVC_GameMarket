<?php
namespace Dao\Productos;

use Dao\Table;

class Productos extends Table
{
    public static function getProductos(
        string $partialNombre = "",
        string $orderBy = "",
        bool $orderDescending = false,
        int $page = 0,
        int $itemsPerPage = 10
    ) {
        $sqlstr = "SELECT p.prodcod, p.prodnom, p.proddsc, p.prodprecio, p.prodstock, p.provcod, p.prodest FROM producto p";
        $sqlstrCount = "SELECT COUNT(*) as count FROM producto p";
        $conditions = [];
        $params = [];

        if ($partialNombre != "") {
            $conditions[] = "p.prodnom LIKE :partialNombre";
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
            "productos" => $registros,
            "total" => $numeroDeRegistros,
            "page" => $page,
            "itemsPerPage" => $itemsPerPage
        ];
    }

    public static function getProductoById(int $prodcod)
    {
        $sqlstr = "SELECT * FROM producto WHERE prodcod = :prodcod";
        $params = ["prodcod" => $prodcod];
        return self::obtenerUnRegistro($sqlstr, $params);
    }

    public static function insertProducto($prodnom, $proddsc, $prodprecio, $prodstock, $provcod, $prodest)
    {
        $sqlstr = "INSERT INTO producto (prodnom, proddsc, prodprecio, prodstock, provcod, prodest)
                   VALUES (:prodnom, :proddsc, :prodprecio, :prodstock, :provcod, :prodest)";
        $params = [
            "prodnom" => $prodnom,
            "proddsc" => $proddsc,
            "prodprecio" => $prodprecio,
            "prodstock" => $prodstock,
            "provcod" => $provcod,
            "prodest" => $prodest
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function updateProducto($prodcod, $prodnom, $proddsc, $prodprecio, $prodstock, $provcod, $prodest)
    {
        $sqlstr = "UPDATE producto
                   SET prodnom = :prodnom,
                       proddsc = :proddsc,
                       prodprecio = :prodprecio,
                       prodstock = :prodstock,
                       provcod = :provcod,
                       prodest = :prodest
                   WHERE prodcod = :prodcod";
        $params = [
            "prodcod" => $prodcod,
            "prodnom" => $prodnom,
            "proddsc" => $proddsc,
            "prodprecio" => $prodprecio,
            "prodstock" => $prodstock,
            "provcod" => $provcod,
            "prodest" => $prodest
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function deleteProducto(int $prodcod)
    {
        $sqlstr = "DELETE FROM producto WHERE prodcod = :prodcod";
        $params = ["prodcod" => $prodcod];
        return self::executeNonQuery($sqlstr, $params);
    }
}
