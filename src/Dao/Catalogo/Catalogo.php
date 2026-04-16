<?php
namespace Dao\Catalogo;

use Dao\Table;

class Catalogo extends Table
{
    public static function getProductosActivos(string $filtro = ''): array
    {
        $sql = "SELECT p.prodcod, p.prodnom, p.proddsc, p.prodprecio, p.prodstock, p.prodest
                FROM producto p
                WHERE p.prodest = 'ACT'";
        $params = [];

        if ($filtro !== '') {
            $sql .= " AND (p.prodnom LIKE :filtro OR p.proddsc LIKE :filtro)";
            $params['filtro'] = '%' . $filtro . '%';
        }

        $sql .= ' ORDER BY p.prodnom ASC';
        return self::obtenerRegistros($sql, $params);
    }

    public static function getProductoById(int $prodcod)
    {
        $sql = "SELECT p.prodcod, p.prodnom, p.proddsc, p.prodprecio, p.prodstock, p.prodest
                FROM producto p
                WHERE p.prodcod = :prodcod LIMIT 1";
        return self::obtenerUnRegistro($sql, ['prodcod' => $prodcod]);
    }
}
