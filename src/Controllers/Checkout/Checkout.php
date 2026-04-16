<?php
namespace Controllers\Checkout;

use Controllers\PublicController;
use Utilities\Cart\Cart;
use Utilities\Context;
use Utilities\Security;
use Utilities\Site;
use Utilities\Paypal\PayPalOrder;
use Utilities\PayPal\PayPalRestApi;
use Views\Renderer;

class Checkout extends PublicController
{
    public function run(): void
    {
        if ($this->isPostBack() && (($_POST['action'] ?? '') === 'pay')) {
            $this->createPaypalOrder();
            return;
        }

        if ($this->isPostBack() && isset($_POST['items']) && is_array($_POST['items'])) {
            foreach ($_POST['items'] as $prodcod => $qty) {
                Cart::updateItem(intval($prodcod), intval($qty));
            }
        }

        $items = Cart::getItemsForView();
        Renderer::render('checkout/checkout', [
            'items' => $items,
            'hasItems' => count($items) > 0,
            'cartCount' => Cart::getCount(),
            'cartTotal' => number_format(Cart::getTotal(), 2),
            'isLogged' => Security::isLogged()
        ]);
    }

    private function createPaypalOrder(): void
    {
        if (!Security::isLogged()) {
            Site::redirectToWithMsg('index.php?page=Sec_Login', 'Debes iniciar sesión para pagar');
        }

        $items = Cart::getItemsForView();
        if (count($items) === 0) {
            Site::redirectToWithMsg('index.php?page=Catalogo_Catalogo', 'Tu carrito está vacío');
        }

        $baseDir = rtrim(Context::getContextByKey('BASE_DIR'), '/');
        $baseUrl = (isset($_SERVER['HTTPS']) ? 'https' : 'http') . '://' . $_SERVER['HTTP_HOST'] . $baseDir;
        $returnUrl = $baseUrl . '/index.php?page=Checkout_Accept';
        $cancelUrl = $baseUrl . '/index.php?page=Checkout_Cancel';

        $order = new PayPalOrder('GM-' . time(), $cancelUrl, $returnUrl);
        foreach ($items as $item) {
            $order->addItem(
                $item['prodnom'],
                substr($item['proddsc'], 0, 120),
                strval($item['prodcod']),
                number_format(floatval($item['prodprecio']), 2, '.', ''),
                '0.00',
                strval($item['quantity']),
                'PHYSICAL_GOODS'
            );
        }

        $api = new PayPalRestApi(
            Context::getContextByKey('PAYPAL_CLIENT_ID'),
            Context::getContextByKey('PAYPAL_CLIENT_SECRET'),
            strtoupper(Context::getContextByKey('PAYPAL_CLIENT_ENV')) === 'PRD' ? 'production' : 'sandbox'
        );

        $response = $api->createOrder($order);

        if (!isset($response->links) || !is_array($response->links)) {
            Site::redirectToWithMsg('index.php?page=Checkout_Checkout', 'No fue posible generar la orden en PayPal');
        }

        foreach ($response->links as $link) {
            if (($link->rel ?? '') === 'approve') {
                header('Location: ' . $link->href);
                die();
            }
        }

        Site::redirectToWithMsg('index.php?page=Checkout_Checkout', 'PayPal no devolvió un enlace de aprobación');
    }
}
