<?php
namespace Controllers\Checkout;

use Controllers\PublicController;
use Dao\Catalogo\Catalogo as DaoCatalogo;
use Utilities\Cart\Cart;
use Utilities\Site;

class Add extends PublicController
{
    public function run(): void
    {
        $prodcod = intval($_POST['prodcod'] ?? $_GET['prodcod'] ?? 0);
        $qty = intval($_POST['qty'] ?? $_GET['qty'] ?? 1);
        $producto = DaoCatalogo::getProductoById($prodcod);

        if (!$producto || $producto['prodest'] !== 'ACT') {
            Site::redirectToWithMsg('index.php?page=Catalogo_Catalogo', 'Producto no disponible');
        }

        if (intval($producto['prodstock']) <= 0) {
            Site::redirectToWithMsg('index.php?page=Catalogo_Catalogo', 'Producto sin stock');
        }

        Cart::addItem($producto, $qty);
        Site::redirectToWithMsg('index.php?page=Catalogo_Catalogo', 'Producto agregado al carrito');
    }
}
