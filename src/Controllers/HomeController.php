<?php
namespace Controllers;
use \Dao\Productos\ProductoModelo as ProductosDao;
use \Views\Renderer as Renderer;

class HomeController extends PublicController
{
    public function run() :void
    {
        ProductosDao::obtenerNombreProducto();
        #ProductsDao::getProveedores();

        $viewData = [];
        $viewData["productsOnSale"] = ProductosDao::getDailyDeals();
        $viewData["productsHighlighted"] = ProductosDao::getFeaturedProducts();
        $viewData["productsNew"] = ProductosDao::getNewProducts();
        Renderer::render("home", $viewData);
    }
}
?>