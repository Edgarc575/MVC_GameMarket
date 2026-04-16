<?php

namespace Controllers\Proveedores;

use Controllers\PublicController;
use Dao\Proveedores\Proveedores as ProveedoresDao;
use Utilities\Site;
use Utilities\Validators;
use Views\Renderer;

class Proveedor extends PublicController
{
    private $viewData = [];
    private $mode = "DSP";
    private $modeDescriptions = [
        "DSP" => "Detalle de Proveedor %s %s",
        "INS" => "Nuevo Proveedor",
        "UPD" => "Editar Proveedor %s %s",
        "DEL" => "Eliminar Proveedor %s %s"
    ];
    private $readonly = "";
    private $showCommitBtn = true;
    private $proveedor = [
        "provcod" => 0,
        "provnom" => "",
        "provtel" => "",
        "provemail" => "",
        "provdir" => "",
        "provest" => "ACT"
    ];
    private $proveedor_xss_token = "";

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
            Renderer::render("Proveedor/proveedor", $this->viewData);
        } catch (\Exception $ex) {
            Site::redirectToWithMsg(
                "index.php?page=Proveedores_Proveedores",
                $ex->getMessage()
            );
        }
    }

    private function getData()
    {
        $this->mode = $_GET["mode"] ?? "NOF";
        if (isset($this->modeDescriptions[$this->mode])) {
            $this->readonly = $this->mode === "DEL" || $this->mode === "DSP" ? "readonly" : "";
            $this->showCommitBtn = $this->mode !== "DSP";
            if ($this->mode !== "INS") {
                $this->proveedor = ProveedoresDao::getProveedorById(intval($_GET["provcod"]));
                if (!$this->proveedor) {
                    throw new \Exception("No se encontrÃ³ el Proveedor", 1);
                }
            }
        } else {
            throw new \Exception("Formulario cargado en modalidad invalida", 1);
        }
    }

    private function validateData()
    {
        $errors = [];
        $this->proveedor_xss_token = $_POST["proveedor_xss_token"] ?? "";

        $this->proveedor["provcod"] = intval($_POST["provcod"] ?? "");
        $this->proveedor["provnom"] = strval($_POST["provnom"] ?? "");
        $this->proveedor["provtel"] = strval($_POST["provtel"] ?? "");
        $this->proveedor["provemail"] = strval($_POST["provemail"] ?? "");
        $this->proveedor["provdir"] = strval($_POST["provdir"] ?? "");
        $this->proveedor["provest"] = strval($_POST["provest"] ?? "");

        if (Validators::IsEmpty($this->proveedor["provnom"])) {
            $errors["provnom_error"] = "El nombre es requerido";
        }
        if (!Validators::IsValidEmail($this->proveedor["provemail"])) {
            $errors["provemail_error"] = "Correo electrÃ³nico no es vÃ¡lido";
        }

        if (count($errors) > 0) {
            foreach ($errors as $key => $value) {
                $this->proveedor[$key] = $value;
            }
            return false;
        }
        return true;
    }

    private function handlePostAction()
    {
        switch ($this->mode) {
            case "INS":
                $result = ProveedoresDao::insertProveedor(
                    $this->proveedor["provnom"],
                    $this->proveedor["provtel"],
                    $this->proveedor["provemail"],
                    $this->proveedor["provdir"],
                    $this->proveedor["provest"]
                );
                if ($result > 0) {
                    Site::redirectToWithMsg("index.php?page=Proveedores_Proveedores", "Proveedor creado exitosamente");
                }
                break;
            case "UPD":
                $result = ProveedoresDao::updateProveedor(
                    $this->proveedor["provcod"],
                    $this->proveedor["provnom"],
                    $this->proveedor["provtel"],
                    $this->proveedor["provemail"],
                    $this->proveedor["provdir"],
                    $this->proveedor["provest"]
                );
                if ($result > 0) {
                    Site::redirectToWithMsg("index.php?page=Proveedores_Proveedores", "Proveedor actualizado exitosamente");
                }
                break;
            case "DEL":
                $result = ProveedoresDao::deleteProveedor($this->proveedor["provcod"]);
                if ($result > 0) {
                    Site::redirectToWithMsg("index.php?page=Proveedores_Proveedores", "Proveedor eliminado exitosamente");
                }
                break;
        }
    }

    private function setViewData(): void
    {
        $this->viewData["mode"] = $this->mode;
        $this->viewData["proveedor_xss_token"] = $this->proveedor_xss_token;
        $this->viewData["FormTitle"] = sprintf(
            $this->modeDescriptions[$this->mode],
            $this->proveedor["provcod"],
            $this->proveedor["provnom"]
        );
        $this->viewData["showCommitBtn"] = $this->showCommitBtn;
        $this->viewData["readonly"] = $this->readonly;
        $this->viewData["proveedor"] = $this->proveedor;
    }
}
