<?php
namespace Controllers\Checkout;

use Controllers\PublicController;
use Dao\Checkout\Checkout as DaoCheckout;
use Utilities\Cart\Cart;
use Utilities\Context;
use Utilities\Security;
use Utilities\Site;
use Utilities\PayPal\PayPalRestApi;
use Views\Renderer;

class Accept extends PublicController
{
    public function run(): void
    {
        if (!Security::isLogged()) {
            Site::redirectToWithMsg('index.php?page=Sec_Login', 'Debes iniciar sesión para completar el pago');
        }

        $orderId = strval($_GET['token'] ?? '');
        if ($orderId === '') {
            Site::redirectToWithMsg('index.php?page=Checkout_Checkout', 'No se recibió la orden de PayPal');
        }

        $api = new PayPalRestApi(
            Context::getContextByKey('PAYPAL_CLIENT_ID'),
            Context::getContextByKey('PAYPAL_CLIENT_SECRET'),
            strtoupper(Context::getContextByKey('PAYPAL_CLIENT_ENV')) === 'PRD' ? 'production' : 'sandbox'
        );

        $capture = $api->captureOrder($orderId);
        $status = $capture->status ?? '';

        if ($status !== 'COMPLETED') {
            Renderer::render('checkout/error', [
                'message' => 'El pago no pudo completarse.',
                'orderjson' => json_encode($capture, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE)
            ]);
            return;
        }

        $user = Security::getUser();
        $clienteId = DaoCheckout::findOrCreateCliente($user['userName'], $user['userEmail']);
        $captureId = $capture->purchase_units[0]->payments->captures[0]->id ?? '';
        $factcod = DaoCheckout::createInvoiceFromCart(
            intval($user['userId']),
            $clienteId,
            Cart::getItemsForView(),
            $orderId,
            $captureId,
            json_decode(json_encode($capture), true)
        );

        Cart::clear();

        Renderer::render('checkout/accept', [
            'factcod' => $factcod,
            'orderjson' => json_encode($capture, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE)
        ]);
    }
}
