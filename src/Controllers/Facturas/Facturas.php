<?php
namespace Controllers\Facturas;

use Controllers\PublicController;
use Utilities\Context;
use Utilities\Paging;
use Dao\Facturas\Facturas as DaoFacturas;
use Views\Renderer;

class Facturas extends PublicController
{
  private $partialCod = "";
  private $pageNumber = 1;
  private $itemsPerPage = 12;
  private $viewData = [];

  public function run(): void
  {
    $this->partialCod = $_GET["partialCod"] ?? Context::getContextByKey("fact_filter") ?: "";
    $this->pageNumber = intval($_GET["pageNum"] ?? Context::getContextByKey("fact_page") ?: 1);
    
    $tmpData = DaoFacturas::getFacturas($this->partialCod, "f.factcod", true, $this->pageNumber - 1, $this->itemsPerPage);
    
    Context::setContext("fact_filter", $this->partialCod, true);
    Context::setContext("fact_page", $this->pageNumber, true);
    
    $this->viewData = [
        "partialCod" => $this->partialCod,
        "facturas" => $tmpData["facturas"],
        "pagination" => Paging::getPagination($tmpData["total"], $this->itemsPerPage, $this->pageNumber, "index.php?page=Facturas_Facturas", "Facturas_Facturas")
    ];
    Renderer::render("facturas/facturas", $this->viewData);
  }
}