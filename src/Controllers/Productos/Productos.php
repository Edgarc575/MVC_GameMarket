<?php
namespace Controllers\Productos;

use Controllers\PublicController;
use Utilities\Context;
use Utilities\Paging;
use Dao\Productos\Productos as DaoProductos;
use Views\Renderer;

class Productos extends PublicController
{
  private $partialNombre = "";
  private $pageNumber = 1;
  private $itemsPerPage = 10;
  private $viewData = [];

  public function run(): void
  {
    $this->partialNombre = $_GET["partialNombre"] ?? Context::getContextByKey("prod_filter") ?: "";
    $this->pageNumber = intval($_GET["pageNum"] ?? Context::getContextByKey("prod_page") ?: 1);
    
    $tmpData = DaoProductos::getProductos($this->partialNombre, "p.prodnom", false, $this->pageNumber - 1, $this->itemsPerPage);
    $tmpData["productos"] = array_map(function ($producto) {
      $producto["prodimg"] = $producto["prodimg"] ?? "";
      return $producto;
    }, $tmpData["productos"]);
    
    Context::setContext("prod_filter", $this->partialNombre, true);
    Context::setContext("prod_page", $this->pageNumber, true);
    
    $this->viewData = [
        "partialNombre" => $this->partialNombre,
        "productos" => $tmpData["productos"],
        "pagination" => Paging::getPagination($tmpData["total"], $this->itemsPerPage, $this->pageNumber, "index.php?page=Productos_Productos", "Productos_Productos")
    ];
    Renderer::render("productos/productos", $this->viewData);
  }
}
