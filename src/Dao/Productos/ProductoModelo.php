<?php

namespace Dao\Productos;

use Dao\Table;

class ProductoModelo extends Table{

    #Buscar todos los productos registrados
    public static function obtenerProductos(): array{
        $productoslistado = [];
        $sqlstr = "Select * from producto";
        $productoslistado = self::obtenerRegistros($sqlstr,[]);
        return $productoslistado;
    }

    #Buscar un producto por el codigo
    public static function obtenerIdProductos(int $id): array {
        $sqlstr = "Select * from producto where id=:id;";
        $paremtro = ["id"=>$id];
        return self::obtenerUnRegistro($sqlstr,$parametro);
    }
     
    #Buscar un producto por el nombre
    public static function obtenerNombreProducto(string $nombre){
        $sqlstr = "Select * from producto where prodnom=:prodnom;";
        $parametro = ["prodnom"=>$nombre];
    return self::obtenerUnRegistro($sqlstr,$parametro);
    }
    
    #Crear Producto
    public static function crearProducto(
        $nombre,
        $descripcion,
        $precio,
        $stock,
        $idproveedor,
        $estado,
    ):int{
        $sqlstr = "Insert into producto 
        (prodcod,prodnom,proddsc,prodprecio,prodstock,provcod,prodest)
        values (:nombre,:descripcion,:precio,:stock,:idproveedor);";
        $affectedRow = self::executeNonQuery($sqlstr, [
            "prodnom" => $nombre,
            "proddsc" => $descripcion,
            "prodprecio" => $precio,
            "prodstock" => $stock,
            "provcod" => $idproveedor,
            "prodest" => $estado
        ]);
        return $affectedRow;
    }

    #Actualizar Producto
    public static function actualizarProducto(
        $id,
        $nombre,
        $descripcion,
        $precio,
        $stock,
        $idproveedor,
        $estado,
    ):int{
        $sqlstr = "Update producto set prodnom = :nombre, 
        proddsc = :descripcion,
        prodprecio = :precio, prodstock = :stock
        where prodcod =:id;";

        $affectedRow = self::executeNonQuery($sqlstr, [
            "id" =>$id,
            "prodnom" => $nombre,
            "proddsc" => $descripcion,
            "prodprecio" => $precio,
            "prodstock" => $stock,
            "provcod" => $idproveedor,
            "prodest" => $estado
        ]);
        return $affectedRow;
    }

    #Eliminar producto
    public static function eliminarProducto(
        $id
    ): int{
        $sqlstr = "Delete from producto where prodcod = :id;";

        $affectedRow = self::executeNonQuery($sqlstr, ["prodcod" => $id]);
        return $affectedRow;
    }

    

    //  prodcod bigint(10) NOT NULL AUTO_INCREMENT,
    //prodnom varchar(120) DEFAULT NULL,
    //proddsc varchar(255) DEFAULT NULL,
    //prodprecio decimal(10,2) DEFAULT NULL,
    //prodstock int DEFAULT NULL,
    //provcod bigint(10) DEFAULT NULL,
    //prodest char(3) DEFAULT NULL,
    //PRIMARY KEY (prodcod),
    //KEY proveedor_idx (provcod),
    //CONSTRAINT producto_proveedor_fk
    //    FOREIGN KEY (provcod)
     //   REFERENCES proveedor(provcod)
}