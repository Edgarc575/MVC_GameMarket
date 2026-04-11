<?php

namespace Dao\Productos;
use Dao\Table;
class Productos extends Table{


#Conexion 

    #NOTA 4-9-26: SOLO SE ENCUENTRAN REGISTROS EN TABLA DE PROVEEDORES Y PRODUCTOS,
    #YA HICE LAS PRUEBAS CCON LA CONEXION SENCILLA EN HOMECONTROLLER Y FUNCIONA PERFECTAMENTE.
   
    #Proveedores
    public static function obtenerNombreProducto(string $nombre){
        $sqlstr = "Select * from producto where prodnom=:prodnom;";
        $parametro = ["prodnom"=>$nombre];
    return self::obtenerUnRegistro($sqlstr,$parametro);
    }

    #Productos
    public static function getProductos(){
        die(print_r(self::obtenerRegistros("Select * from producto",[])));
    }
    #Clientes
    public static function getClientes(){
        die(print_r(self::obtenerRegistros("Select * from cliente",[])));
    }
    #Usuarios
    public static function getUsuarios(){
        die(print_r(self::obtenerRegistros("Select * from usuario",[])));
    }
    #Roles
    public static function getRoles(){
        die(print_r(self::obtenerRegistros("Select * from roles",[])));
    }
    #Roles usuario
    public static function getRolesUsuario(){
        die(print_r(self::obtenerRegistros("Select * from roles_usuarios",[])));
    }
    #Funciones
    public static function getFunciones(){
        die(print_r(self::obtenerRegistros("Select * from funciones",[])));
    }
    #Funciones Roles
    public static function getFuncionesRoles(){
        die(print_r(self::obtenerRegistros("Select * from funciones_roles",[])));
    }
    #Factura
    public static function getFactura(){
        die(print_r(self::obtenerRegistros("Select * from factura",[])));
    }
    #Factura Detalle
    public static function getFacturaDetalle(){
        die(print_r(self::obtenerRegistros("Select * from factura_detalle",[])));
    }
     #Bitacora
    public static function getBitacora(){
        die(print_r(self::obtenerRegistros("Select * from bitacora",[])));
    }



}