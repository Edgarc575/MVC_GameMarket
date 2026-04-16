<?php
namespace Controllers\Checkout;

use Controllers\PublicController;
use Utilities\Cart\Cart;
use Utilities\Site;

class Remove extends PublicController
{
    public function run(): void
    {
        $prodcod = intval($_GET['prodcod'] ?? $_POST['prodcod'] ?? 0);
        Cart::removeItem($prodcod);
        Site::redirectTo('index.php?page=Checkout_Checkout');
    }
}
