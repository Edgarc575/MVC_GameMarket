<?php
namespace Controllers\Checkout;

use Controllers\PublicController;
use Views\Renderer;

class Cancel extends PublicController
{
    public function run(): void
    {
        Renderer::render('checkout/error', [
            'message' => 'El pago fue cancelado por el usuario.',
            'orderjson' => ''
        ]);
    }
}
