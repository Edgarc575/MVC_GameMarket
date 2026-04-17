<?php
namespace Controllers;
use Dao\Catalogo\Catalogo as CatalogoDao;
use Utilities\Cart\Cart;
use \Views\Renderer as Renderer;

class HomeController extends PublicController
{
    public function run() :void
    {
        $filtro = trim(strval($_GET["q"] ?? ""));
        $productos = CatalogoDao::getProductosActivos($filtro);

        foreach ($productos as &$producto) {
            $producto["sin_stock"] = intval($producto["prodstock"] ?? 0) <= 0;
            $producto["prodimgurl"] = $producto["prodimgurl"] ?? "https://placehold.co/640x360/e5e7eb/111827?text=GameMarket";
        }
        unset($producto);

        Renderer::render("catalogo/catalogo", [
            "q" => $filtro,
            "productos" => $productos,
            "cartCount" => Cart::getCount(),
            "cartTotal" => number_format(Cart::getTotal(), 2)
        ]);
    }
}
?>
