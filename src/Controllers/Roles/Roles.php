<?php

namespace Controllers\Roles;

use Controllers\PublicController;
use Dao\Roles\Roles as DaoRoles;
use Utilities\Context;
use Utilities\Paging;
use Views\Renderer;

class Roles extends PublicController
{
    private $partialNombre = "";
    private $pageNumber = 1;
    private $itemsPerPage = 10;
    private $viewData = [];
    private $roles = [];
    private $rolesCount = 0;
    private $pages = 0;

    public function run(): void
    {
        $this->getParamsFromContext();
        $this->getParams();
        $tmpRoles = DaoRoles::getRoles(
            $this->partialNombre,
            "",
            false,
            $this->pageNumber - 1,
            $this->itemsPerPage
        );
        $this->roles = $tmpRoles["roles"];
        $this->rolesCount = $tmpRoles["total"];
        $this->pages = $this->rolesCount > 0 ? ceil($this->rolesCount / $this->itemsPerPage) : 1;
        if ($this->pageNumber > $this->pages) {
            $this->pageNumber = $this->pages;
        }
        $this->setParamsToContext();
        $this->setParamsToDataView();
        Renderer::render("Roles/roles", $this->viewData);
    }

    private function getParams(): void
    {
        $this->partialNombre = isset($_GET["partialNombre"]) ? $_GET["partialNombre"] : $this->partialNombre;
        $this->pageNumber = isset($_GET["pageNum"]) ? intval($_GET["pageNum"]) : $this->pageNumber;
        $this->itemsPerPage = isset($_GET["itemsPerPage"]) ? intval($_GET["itemsPerPage"]) : $this->itemsPerPage;
    }

    private function getParamsFromContext(): void
    {
        $this->partialNombre = Context::getContextByKey("roles_partialNombre");
        $this->pageNumber = intval(Context::getContextByKey("roles_page"));
        $this->itemsPerPage = intval(Context::getContextByKey("roles_itemsPerPage"));
        if ($this->pageNumber < 1) {
            $this->pageNumber = 1;
        }
        if ($this->itemsPerPage < 1) {
            $this->itemsPerPage = 10;
        }
    }

    private function setParamsToContext(): void
    {
        Context::setContext("roles_partialNombre", $this->partialNombre, true);
        Context::setContext("roles_page", $this->pageNumber, true);
        Context::setContext("roles_itemsPerPage", $this->itemsPerPage, true);
    }

    private function setParamsToDataView(): void
    {
        $this->viewData["partialNombre"] = $this->partialNombre;
        $this->viewData["pageNum"] = $this->pageNumber;
        $this->viewData["itemsPerPage"] = $this->itemsPerPage;
        $this->viewData["rolesCount"] = $this->rolesCount;
        $this->viewData["pages"] = $this->pages;
        $this->viewData["roles"] = $this->roles;

        $pagination = Paging::getPagination(
            $this->rolesCount,
            $this->itemsPerPage,
            $this->pageNumber,
            "index.php?page=Roles_Roles",
            "Roles_Roles"
        );
        $this->viewData["pagination"] = $pagination;
    }
}