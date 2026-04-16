<?php
namespace Controllers\Productos;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Productos\Productos as ProductosDao;
use Dao\Proveedores\Proveedores as ProveedoresDao;
use Utilities\Site;
use Utilities\Validators;

class Producto extends PublicController
{
    private $viewData = [];
    private $mode = "DSP";
    private $modeDescriptions = [
        "DSP" => "Detalle de Producto %s %s",
        "INS" => "Nuevo Producto",
        "UPD" => "Editar Producto %s %s",
        "DEL" => "Eliminar Producto %s %s"
    ];
    private $readonly = "";
    private $showCommitBtn = true;
    private $producto = [
        "prodcod" => 0, "prodnom" => "", "proddsc" => "",
        "prodprecio" => 0.00, "prodstock" => 0, "provcod" => "", "prodest" => "ACT", "prodimg" => ""
    ];
    private $producto_xss_token = "";

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
            Renderer::render("productos/producto", $this->viewData);
        } catch (\Exception $ex) {
            Site::redirectToWithMsg("index.php?page=Productos_Productos", $ex->getMessage());
        }
    }

    private function getData()
    {
        $this->mode = $_GET["mode"] ?? "NOF";
        if (isset($this->modeDescriptions[$this->mode])) {
            $this->readonly = ($this->mode === "DEL" || $this->mode === "DSP") ? "readonly" : "";
            $this->showCommitBtn = $this->mode !== "DSP";
            if ($this->mode !== "INS") {
                $producto = ProductosDao::getProductoById(intval($_GET["prodcod"]));
                if (!$producto) {
                    throw new \Exception("No se encontro el Producto");
                }
                $this->producto = array_merge($this->producto, $producto);
            }
        } else {
            throw new \Exception("Modalidad invalida");
        }
    }

    private function validateData()
    {
        $errors = [];
        $this->producto_xss_token = $_POST["producto_xss_token"] ?? "";
        $this->producto = array_merge($this->producto, $_POST);
        $this->producto["prodcod"] = intval($this->producto["prodcod"] ?? 0);
        $this->producto["prodprecio"] = floatval($this->producto["prodprecio"] ?? 0);
        $this->producto["prodstock"] = intval($this->producto["prodstock"] ?? 0);

        $provcod = trim(strval($this->producto["provcod"] ?? ""));
        if ($provcod === "" || $provcod === "0") {
            $this->producto["provcod"] = null;
        } else {
            $this->producto["provcod"] = intval($provcod);
            if (!ProveedoresDao::getProveedorById($this->producto["provcod"])) {
                $errors["provcod_error"] = "El proveedor indicado no existe";
            }
        }

        if (Validators::IsEmpty($this->producto["prodnom"])) {
            $errors["prodnom_error"] = "Nombre requerido";
        }
        if (floatval($this->producto["prodprecio"]) <= 0) {
            $errors["prodprecio_error"] = "Precio debe ser mayor a 0";
        }

        if (count($errors) > 0) {
            $this->producto = array_merge($this->producto, $errors);
            return false;
        }
        return true;
    }

    private function handlePostAction()
    {
        $res = 0;
        switch ($this->mode) {
            case "INS":
                $res = ProductosDao::insertProducto($this->producto["prodnom"], $this->producto["proddsc"], $this->producto["prodprecio"], $this->producto["prodstock"], $this->producto["provcod"], $this->producto["prodest"]);
                break;
            case "UPD":
                $res = ProductosDao::updateProducto($this->producto["prodcod"], $this->producto["prodnom"], $this->producto["proddsc"], $this->producto["prodprecio"], $this->producto["prodstock"], $this->producto["provcod"], $this->producto["prodest"]);
                break;
            case "DEL":
                $res = ProductosDao::deleteProducto($this->producto["prodcod"]);
                break;
        }
        if ($res > 0) {
            Site::redirectToWithMsg("index.php?page=Productos_Productos", "Operacion exitosa");
        }
    }

    private function setViewData(): void
    {
        $this->producto["prodest_ACT"] = $this->producto["prodest"] === "ACT";
        $this->producto["prodest_INA"] = $this->producto["prodest"] === "INA";

        $this->viewData = [
            "mode" => $this->mode,
            "producto_xss_token" => $this->producto_xss_token,
            "FormTitle" => sprintf($this->modeDescriptions[$this->mode], $this->producto["prodcod"], $this->producto["prodnom"]),
            "showCommitBtn" => $this->showCommitBtn,
            "readonly" => $this->readonly,
            "producto" => $this->producto
        ];
    }
}
