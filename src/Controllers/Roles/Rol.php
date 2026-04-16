<?php

namespace Controllers\Roles;

use Controllers\PublicController;
use Dao\Roles\Roles as RolesDao;
use Utilities\Site;
use Utilities\Validators;
use Views\Renderer;

class Rol extends PublicController
{
    private $viewData = [];
    private $mode = "DSP";
    private $modeDescriptions = [
        "DSP" => "Detalle del Rol %s %s",
        "INS" => "Nuevo Rol",
        "UPD" => "Editar Rol %s %s",
        "DEL" => "Eliminar Rol %s %s"
    ];
    private $readonly = "";
    private $showCommitBtn = true;
    private $rol = [
        "rolcod" => 0,
        "roldsc" => "",
        "rolest" => "ACT"
    ];
    private $rol_xss_token = "";

    public function run(): void
    {
        try {
            $this->getData();
            if ($this->isPostBack()) {
                if ($this->validateData()) {
                    $this->handlePostAction();
                }
            }
            $this->setViewData();
            Renderer::render("Roles/rol", $this->viewData);
        } catch (\Exception $ex) {
            Site::redirectToWithMsg("index.php?page=Roles_Roles", $ex->getMessage());
        }
    }

    private function getData()
    {
        $this->mode = $_GET["mode"] ?? "NOF";
        if (isset($this->modeDescriptions[$this->mode])) {
            $this->readonly = ($this->mode === "DEL" || $this->mode === "DSP") ? "readonly" : "";
            $this->showCommitBtn = $this->mode !== "DSP";
            if ($this->mode !== "INS") {
                $this->rol = RolesDao::getRolesById(intval($_GET["rolcod"] ?? 0));
                if (!$this->rol) {
                    throw new \Exception("No se encuentra el Rol", 1);
                }
            }
        } else {
            throw new \Exception("Formulario cargado en modalidad invalida", 1);
        }
    }

    private function validateData()
    {
        $errors = [];
        $this->rol_xss_token = $_POST["rol_xss_token"] ?? "";

        $this->rol["rolcod"] = intval($_POST["rolcod"] ?? 0);
        $this->rol["roldsc"] = strval($_POST["roldsc"] ?? "");
        $this->rol["rolest"] = strval($_POST["rolest"] ?? "");

        if (Validators::IsEmpty($this->rol["roldsc"])) {
            $errors["roldsc_error"] = "El nombre de rol es requerido";
        }
        if (Validators::IsEmpty($this->rol["rolest"])) {
            $errors["rolest_error"] = "El estado de rol es requerido";
        }

        if (count($errors) > 0) {
            foreach ($errors as $key => $value) {
                $this->rol[$key] = $value;
            }
            return false;
        }
        return true;
    }

    private function handlePostAction()
    {
        switch ($this->mode) {
            case "INS":
                $result = RolesDao::insertRoles($this->rol["roldsc"], $this->rol["rolest"]);
                if ($result > 0) {
                    Site::redirectToWithMsg("index.php?page=Roles_Roles", "Rol creado exitosamente");
                }
                break;
            case "UPD":
                $result = RolesDao::updateRoles($this->rol["rolcod"], $this->rol["roldsc"], $this->rol["rolest"]);
                if ($result > 0) {
                    Site::redirectToWithMsg("index.php?page=Roles_Roles", "Rol actualizado exitosamente");
                }
                break;
            case "DEL":
                $result = RolesDao::deleteRoles($this->rol["rolcod"]);
                if ($result > 0) {
                    Site::redirectToWithMsg("index.php?page=Roles_Roles", "Rol eliminado exitosamente");
                }
                break;
        }
    }

    private function setViewData(): void
    {
        $this->viewData["mode"] = $this->mode;
        $this->viewData["rol_xss_token"] = $this->rol_xss_token;
        $this->viewData["FormTitle"] = sprintf(
            $this->modeDescriptions[$this->mode],
            $this->rol["rolcod"],
            $this->rol["roldsc"]
        );
        $this->viewData["showCommitBtn"] = $this->showCommitBtn;
        $this->viewData["readonly"] = $this->readonly;
        $this->viewData["rol"] = $this->rol;
    }
}
