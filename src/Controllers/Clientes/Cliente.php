<?php
namespace Controllers\Clientes;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Clientes\Clientes as ClientesDao;
use Utilities\Site;
use Utilities\Validators;

class Cliente extends PublicController
{
    private $viewData = [];
    private $mode = "DSP";
    private $modeDescriptions = [
        "DSP" => "Detalle de Cliente %s %s",
        "INS" => "Nuevo Cliente",
        "UPD" => "Editar Cliente %s %s",
        "DEL" => "Eliminar Cliente %s %s"
    ];
    private $readonly = "";
    private $showCommitBtn = true;
    private $cliente = [
        "clicod" => 0,
        "clinom" => "",
        "clitel" => "",
        "cliemail" => "",
        "clidir" => "",
        "cliest" => "ACT"
    ];
    private $cliente_xss_token = "";

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
            Renderer::render("clientes/cliente", $this->viewData);
        } catch (\Exception $ex) {
            Site::redirectToWithMsg(
                "index.php?page=Clientes_Clientes",
                $ex->getMessage()
            );
        }
    }

    private function getData()
    {
        $this->mode = $_GET["mode"] ?? "NOF";
        if (isset($this->modeDescriptions[$this->mode])) {
            $this->readonly = ($this->mode === "DEL" || $this->mode === "DSP") ? "readonly" : "";
            $this->showCommitBtn = $this->mode !== "DSP";
            if ($this->mode !== "INS") {
                $this->cliente = ClientesDao::getClienteById(intval($_GET["clicod"]));
                if (!$this->cliente) {
                    throw new \Exception("No se encontró el Cliente", 1);
                }
            }
        } else {
            throw new \Exception("Formulario cargado en modalidad invalida", 1);
        }
    }

    private function validateData()
    {
        $errors = [];
        $this->cliente_xss_token = $_POST["cliente_xss_token"] ?? "";
     
        $this->cliente["clicod"] = intval($_POST["clicod"] ?? "");
        $this->cliente["clinom"] = strval($_POST["clinom"] ?? "");
        $this->cliente["clitel"] = strval($_POST["clitel"] ?? "");
        $this->cliente["cliemail"] = strval($_POST["cliemail"] ?? "");
        $this->cliente["clidir"] = strval($_POST["clidir"] ?? "");
        $this->cliente["cliest"] = strval($_POST["cliest"] ?? "");

        if (Validators::IsEmpty($this->cliente["clinom"])) {
            $errors["clinom_error"] = "El nombre es requerido";
        }
        if (!Validators::IsValidEmail($this->cliente["cliemail"])) {
            $errors["cliemail_error"] = "Correo electrónico no es válido";
        }

        if (count($errors) > 0) {
            foreach ($errors as $key => $value) {
                $this->cliente[$key] = $value;
            }
            return false;
        }
        return true;
    }

    private function handlePostAction()
    {
        switch ($this->mode) {
            case "INS":
                $result = ClientesDao::insertCliente(
                    $this->cliente["clinom"], $this->cliente["clitel"],
                    $this->cliente["cliemail"], $this->cliente["clidir"], $this->cliente["cliest"]
                );
                if ($result > 0) {
                    Site::redirectToWithMsg("index.php?page=Clientes_Clientes", "Cliente creado exitosamente");
                }
                break;
            case "UPD":
                $result = ClientesDao::updateCliente(
                    $this->cliente["clicod"], $this->cliente["clinom"], $this->cliente["clitel"],
                    $this->cliente["cliemail"], $this->cliente["clidir"], $this->cliente["cliest"]
                );
                if ($result > 0) {
                    Site::redirectToWithMsg("index.php?page=Clientes_Clientes", "Cliente actualizado exitosamente");
                }
                break;
            case "DEL":
                $result = ClientesDao::deleteCliente($this->cliente["clicod"]);
                if ($result > 0) {
                    Site::redirectToWithMsg("index.php?page=Clientes_Clientes", "Cliente eliminado exitosamente");
                }
                break;
        }
    }

    private function setViewData(): void
    {
        $this->viewData["mode"] = $this->mode;
        $this->viewData["cliente_xss_token"] = $this->cliente_xss_token;
        $this->viewData["FormTitle"] = sprintf(
            $this->modeDescriptions[$this->mode],
            $this->cliente["clicod"],
            $this->cliente["clinom"]
        );
        $this->viewData["showCommitBtn"] = $this->showCommitBtn;
        $this->viewData["readonly"] = $this->readonly;
        $this->viewData["cliente"] = $this->cliente;
    }
}