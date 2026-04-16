<?php

namespace Controllers\Usuarios;

use Controllers\PublicController;
use Dao\Usuarios\Usuarios as UsuariosDao;
use Utilities\Context;
use Utilities\Paging;
use Views\Renderer;

class Usuarios extends PublicController
{
    private $partialNombre = "";
    private $pageNumber = 1;
    private $itemsPerPage = 10;
    private $viewData = [];
    private $usuarios = [];
    private $usuariosCount = 0;
    private $pages = 0;

    public function run(): void
    {
        $this->getParamsFromContext();
        $this->getParams();
        $tmpUsuarios = UsuariosDao::getUsuarios(
            $this->partialNombre,
            "",
            false,
            $this->pageNumber - 1,
            $this->itemsPerPage
        );
        $this->usuarios = $tmpUsuarios["usuarios"];
        $this->usuariosCount = $tmpUsuarios["total"];
        $this->pages = $this->usuariosCount > 0 ? ceil($this->usuariosCount / $this->itemsPerPage) : 1;
        if ($this->pageNumber > $this->pages) {
            $this->pageNumber = $this->pages;
        }
        $this->setParamsToContext();
        $this->setParamsToDataView();
        Renderer::render("Usuarios/usuarios", $this->viewData);
    }

    private function getParams(): void
    {
        $this->partialNombre = isset($_GET["partialNombre"]) ? $_GET["partialNombre"] : $this->partialNombre;
        $this->pageNumber = isset($_GET["pageNum"]) ? intval($_GET["pageNum"]) : $this->pageNumber;
        $this->itemsPerPage = isset($_GET["itemsPerPage"]) ? intval($_GET["itemsPerPage"]) : $this->itemsPerPage;
    }

    private function getParamsFromContext(): void
    {
        $this->partialNombre = Context::getContextByKey("usuarios_partialNombre");
        $this->pageNumber = intval(Context::getContextByKey("usuarios_page"));
        $this->itemsPerPage = intval(Context::getContextByKey("usuarios_itemsPerPage"));
        if ($this->pageNumber < 1) {
            $this->pageNumber = 1;
        }
        if ($this->itemsPerPage < 1) {
            $this->itemsPerPage = 10;
        }
    }

    private function setParamsToContext(): void
    {
        Context::setContext("usuarios_partialNombre", $this->partialNombre, true);
        Context::setContext("usuarios_page", $this->pageNumber, true);
        Context::setContext("usuarios_itemsPerPage", $this->itemsPerPage, true);
    }

    private function setParamsToDataView(): void
    {
        $this->viewData["partialNombre"] = $this->partialNombre;
        $this->viewData["pageNum"] = $this->pageNumber;
        $this->viewData["itemsPerPage"] = $this->itemsPerPage;
        $this->viewData["usuariosCount"] = $this->usuariosCount;
        $this->viewData["pages"] = $this->pages;
        $this->viewData["usuarios"] = $this->usuarios;

        $pagination = Paging::getPagination(
            $this->usuariosCount,
            $this->itemsPerPage,
            $this->pageNumber,
            "index.php?page=Usuarios_Usuarios",
            "Usuarios_Usuarios"
        );
        $this->viewData["pagination"] = $pagination;
    }
}
