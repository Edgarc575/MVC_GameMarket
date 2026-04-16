<?php

namespace Controllers\Proveedores;

use Controllers\PublicController;
use Dao\Proveedores\Proveedores as DaoProveedores;
use Utilities\Context;
use Utilities\Paging;
use Views\Renderer;

class Proveedores extends PublicController
{
    private $partialNombre = "";
    private $pageNumber = 1;
    private $itemsPerPage = 10;
    private $viewData = [];
    private $proveedores = [];
    private $proveedoresCount = 0;
    private $pages = 0;

    public function run(): void
    {
        $this->getParamsFromContext();
        $this->getParams();
        $tmpProveedores = DaoProveedores::getProveedores(
            $this->partialNombre,
            "",
            false,
            $this->pageNumber - 1,
            $this->itemsPerPage
        );
        $this->proveedores = $tmpProveedores["proveedores"];
        $this->proveedoresCount = $tmpProveedores["total"];
        $this->pages = $this->proveedoresCount > 0 ? ceil($this->proveedoresCount / $this->itemsPerPage) : 1;
        if ($this->pageNumber > $this->pages) {
            $this->pageNumber = $this->pages;
        }
        $this->setParamsToContext();
        $this->setParamsToDataView();
        Renderer::render("Proveedor/proveedores", $this->viewData);
    }

    private function getParams(): void
    {
        $this->partialNombre = isset($_GET["partialNombre"]) ? $_GET["partialNombre"] : $this->partialNombre;
        $this->pageNumber = isset($_GET["pageNum"]) ? intval($_GET["pageNum"]) : $this->pageNumber;
        $this->itemsPerPage = isset($_GET["itemsPerPage"]) ? intval($_GET["itemsPerPage"]) : $this->itemsPerPage;
    }

    private function getParamsFromContext(): void
    {
        $this->partialNombre = Context::getContextByKey("proveedores_partialNombre");
        $this->pageNumber = intval(Context::getContextByKey("proveedores_page"));
        $this->itemsPerPage = intval(Context::getContextByKey("proveedores_itemsPerPage"));
        if ($this->pageNumber < 1) {
            $this->pageNumber = 1;
        }
        if ($this->itemsPerPage < 1) {
            $this->itemsPerPage = 10;
        }
    }

    private function setParamsToContext(): void
    {
        Context::setContext("proveedores_partialNombre", $this->partialNombre, true);
        Context::setContext("proveedores_page", $this->pageNumber, true);
        Context::setContext("proveedores_itemsPerPage", $this->itemsPerPage, true);
    }

    private function setParamsToDataView(): void
    {
        $this->viewData["partialNombre"] = $this->partialNombre;
        $this->viewData["pageNum"] = $this->pageNumber;
        $this->viewData["itemsPerPage"] = $this->itemsPerPage;
        $this->viewData["proveedoresCount"] = $this->proveedoresCount;
        $this->viewData["pages"] = $this->pages;
        $this->viewData["proveedores"] = $this->proveedores;

        $pagination = Paging::getPagination(
            $this->proveedoresCount,
            $this->itemsPerPage,
            $this->pageNumber,
            "index.php?page=Proveedores_Proveedores",
            "Proveedores_Proveedores"
        );
        $this->viewData["pagination"] = $pagination;
    }
}
