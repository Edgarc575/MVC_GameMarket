<?php

namespace Controllers\Mantenimientos\Productos;
use Dao\Productos\Productos as ProductosDao;
use Controllers\PublicController;
use Utilities\Site;
use Views\Renderer;

const PRODUCTOS_FORMULARIO_URL = "index.php?page=Mantenimientos-Productos-FormularioProductos";
const PRODUCTOS_LISTADO_URL = "index.php?page=Mantenimientos-Productos-ListadoProductos";
class FormularioProductos extends PublicController{

    private array $VerDatos = [];

    private array $modes =[
        "INS" => "Nuevo Producto",
        "UPD" => "Actualizar %s %s",
        "DSP" => "Detalle de %S %S",
        "DEL" => "Eliminando %s %s"
    ];

    private $id;
    private $nombre;
    private $descripcion;
    private $precio;
    private $stock;
    private $proveedorid;
    private $estado;

    private $mode;

    #main
    public function run(): void{

        $this->CargarPagina();
        Renderer::render("Mantenimientos/FormularioProductos",$this->VerDatos);
    }

    public function CargarPagina(){
        $this->mode = $_GET["mode"] ?? '';
        if(!isset($this->modes[$this->mode])){
            Site::redirectToWithMsg(PRODUCTOS_LISTADO_URL, "Error al cargar el formulario de Productos, Intenar Nuevamente");
        }
        $this->id = intval($_GET["prodcod"] ?? '0');
        if($this->mode !=="INS" && $this->id <=0){
            Site::redirectToWithMsg(PRODUCTOS_LISTADO_URL, "Error al cargar el formulario de Productos, Se requiere Id");
        }
    }
}
