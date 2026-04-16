<?php
namespace Controllers\Checkout;

use Controllers\PublicController;
use Utilities\Cart\Cart;
use Utilities\Site;

class Clear extends PublicController
{
    public function run(): void
    {
        Cart::clear();
        Site::redirectTo('index.php?page=Checkout_Checkout');
    }
}
