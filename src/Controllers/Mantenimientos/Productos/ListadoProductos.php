<?php

namespace Controllers\Mantenimientos\Productos;
use Controllers\PublicController;
use Views\Renderer;

#Modelo
use Dao\Productos\ProductoModelo as ProductosModeloDao;

const LIST_VIEW_TEMPLATE = "Mantenimientos/Productos/ListadoProductos";

class ListadoProductos extends PublicController{
    private array $listaProductos = [];

    public function run(): void{
        $this->listaProductos = ProductosModeloDao::obtenerProductos();
        Renderer::render(LIST_VIEW_TEMPLATE, $this->prepararVistaProductos());
    }

    public function prepararVistaProductos(){
        return [
            "producto"=> $this->listaProductos
        ];
    }


}