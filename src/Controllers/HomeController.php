<?php
namespace Controllers;
use \Dao\Productos\Productos as ProductsDao;
use \Views\Renderer as Renderer;

class HomeController extends PublicController
{
    public function run() :void
    {
        ProductsDao::getProductos();
        #ProductsDao::getProveedores();

        $viewData = [];
        $viewData["productsOnSale"] = ProductsDao::getDailyDeals();
        $viewData["productsHighlighted"] = ProductsDao::getFeaturedProducts();
        $viewData["productsNew"] = ProductsDao::getNewProducts();
        Renderer::render("home", $viewData);
    }
}
?>