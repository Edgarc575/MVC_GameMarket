<?php

namespace Controllers\Mantenimientos\Productos;
use Controllers\PublicController;
use Views\Renderer;

#Modelo
use Dao\Productos\Productos as ProductosModeloDao;

const LIST_VIEW_TEMPLATE = "Mantenimientos/Productos/ListadoProductos";

class ListadoProductos extends PublicController{
    private array $listaProductos = [];

    public function run(): void{
        $resultado = ProductosModeloDao::getProductos();
        $this->listaProductos = $resultado["productos"] ?? [];
        Renderer::render(LIST_VIEW_TEMPLATE, $this->prepararVistaProductos());
    }

    public function prepararVistaProductos(){
        return [
            "producto"=> $this->listaProductos
        ];
    }


}
