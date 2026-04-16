<?php
namespace Controllers\Catalogo;

use Controllers\PublicController;
use Dao\Catalogo\Catalogo as DaoCatalogo;
use Utilities\Cart\Cart;
use Views\Renderer;

class Catalogo extends PublicController
{
    public function run(): void
    {
        $filtro = trim(strval($_GET['q'] ?? ''));
        $productos = DaoCatalogo::getProductosActivos($filtro);

        foreach ($productos as &$producto) {
            $producto['sin_stock'] = intval($producto['prodstock']) <= 0;
        }

        Renderer::render('catalogo/catalogo', [
            'q' => $filtro,
            'productos' => $productos,
            'cartCount' => Cart::getCount(),
            'cartTotal' => number_format(Cart::getTotal(), 2)
        ]);
    }
}
