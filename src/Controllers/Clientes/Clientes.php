<?php
namespace Controllers\Clientes;

use Controllers\PublicController;
use Utilities\Context;
use Utilities\Paging;
use Dao\Clientes\Clientes as DaoClientes;
use Views\Renderer;

class Clientes extends PublicController
{
  private $partialNombre = "";
  private $pageNumber = 1;
  private $itemsPerPage = 10;
  private $viewData = [];
  private $clientes = [];
  private $clientesCount = 0;
  private $pages = 0;

  public function run(): void
  {
    $this->getParamsFromContext();
    $this->getParams();
    $tmpClientes = DaoClientes::getClientes(
      $this->partialNombre,
      "", 
      false, 
      $this->pageNumber - 1,
      $this->itemsPerPage
    );
    $this->clientes = $tmpClientes["clientes"];
    $this->clientesCount = $tmpClientes["total"];
    $this->pages = $this->clientesCount > 0 ? ceil($this->clientesCount / $this->itemsPerPage) : 1;
    if ($this->pageNumber > $this->pages) {
      $this->pageNumber = $this->pages;
    }
    $this->setParamsToContext();
    $this->setParamsToDataView();
    Renderer::render("clientes/clientes", $this->viewData);
  }

  private function getParams(): void
  {
    $this->partialNombre = isset($_GET["partialNombre"]) ? $_GET["partialNombre"] : $this->partialNombre;
    $this->pageNumber = isset($_GET["pageNum"]) ? intval($_GET["pageNum"]) : $this->pageNumber;
    $this->itemsPerPage = isset($_GET["itemsPerPage"]) ? intval($_GET["itemsPerPage"]) : $this->itemsPerPage;
  }

  private function getParamsFromContext(): void
  {
    $this->partialNombre = Context::getContextByKey("clientes_partialNombre");
    $this->pageNumber = intval(Context::getContextByKey("clientes_page"));
    $this->itemsPerPage = intval(Context::getContextByKey("clientes_itemsPerPage"));
    if ($this->pageNumber < 1) $this->pageNumber = 1;
    if ($this->itemsPerPage < 1) $this->itemsPerPage = 10;
  }

  private function setParamsToContext(): void
  {
    Context::setContext("clientes_partialNombre", $this->partialNombre, true);
    Context::setContext("clientes_page", $this->pageNumber, true);
    Context::setContext("clientes_itemsPerPage", $this->itemsPerPage, true);
  }

  private function setParamsToDataView(): void
  {
    $this->viewData["partialNombre"] = $this->partialNombre;
    $this->viewData["pageNum"] = $this->pageNumber;
    $this->viewData["itemsPerPage"] = $this->itemsPerPage;
    $this->viewData["clientesCount"] = $this->clientesCount;
    $this->viewData["pages"] = $this->pages;
    $this->viewData["clientes"] = $this->clientes;

    $pagination = Paging::getPagination(
      $this->clientesCount,
      $this->itemsPerPage,
      $this->pageNumber,
      "index.php?page=Clientes_Clientes",
      "Clientes_Clientes"
    );
    $this->viewData["pagination"] = $pagination;
  }
}