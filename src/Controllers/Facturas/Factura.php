<?php
namespace Controllers\Facturas;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Facturas\Facturas as FacturasDao;
use Utilities\Site;
use Utilities\Validators;

class Factura extends PublicController
{
    private $viewData = [];
    private $mode = "DSP";
    private $modeDescriptions = [
        "DSP" => "Detalle de Factura #%s",
        "INS" => "Nueva Factura",
        "UPD" => "Editar Factura #%s",
        "DEL" => "Eliminar Factura #%s"
    ];
    private $readonly = "";
    private $showCommitBtn = true;
    private $factura = [
        "factcod" => 0, "clicod" => 0, "usercod" => 0,
        "factfecha" => "", "facttotal" => 0, "factest" => "PEN"
    ];

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
            Renderer::render("facturas/factura", $this->viewData);
        } catch (\Exception $ex) {
            Site::redirectToWithMsg("index.php?page=Facturas_Facturas", $ex->getMessage());
        }
    }

    private function getData()
    {
        $this->mode = $_GET["mode"] ?? "NOF";
        if (isset($this->modeDescriptions[$this->mode])) {
            $this->readonly = ($this->mode === "DEL" || $this->mode === "DSP") ? "readonly" : "";
            $this->showCommitBtn = $this->mode !== "DSP";
            if ($this->mode !== "INS") {
                $this->factura = FacturasDao::getFacturaById(intval($_GET["factcod"]));
                if (!$this->factura) throw new \Exception("Factura no encontrada");
            } else {
                $this->factura["factfecha"] = date("Y-m-d\TH:i");
            }
        } else {
            throw new \Exception("Modalidad inválida");
        }
    }

    private function validateData()
    {
        $errors = [];
        $this->factura = array_merge($this->factura, $_POST);

        if (intval($this->factura["clicod"]) <= 0) $errors["clicod_error"] = "Seleccione un cliente válido";
        if (floatval($this->factura["facttotal"]) < 0) $errors["facttotal_error"] = "El total no puede ser negativo";

        if (count($errors) > 0) {
            $this->factura = array_merge($this->factura, $errors);
            return false;
        }
        return true;
    }

    private function handlePostAction()
    {
        $res = 0;
        switch ($this->mode) {
            case "INS": $res = FacturasDao::insertFactura($this->factura["clicod"], $this->factura["usercod"], $this->factura["factfecha"], $this->factura["facttotal"], $this->factura["factest"]); break;
            case "UPD": $res = FacturasDao::updateFactura($this->factura["factcod"], $this->factura["clicod"], $this->factura["usercod"], $this->factura["factfecha"], $this->factura["facttotal"], $this->factura["factest"]); break;
            case "DEL": $res = FacturasDao::deleteFactura($this->factura["factcod"]); break;
        }
        if ($res > 0) Site::redirectToWithMsg("index.php?page=Facturas_Facturas", "Operación exitosa");
    }

    private function setViewData(): void
    {
        $this->viewData = [
            "mode" => $this->mode,
            "FormTitle" => sprintf($this->modeDescriptions[$this->mode], $this->factura["factcod"]),
            "showCommitBtn" => $this->showCommitBtn,
            "readonly" => $this->readonly,
            "factura" => $this->factura
        ];
    }
}