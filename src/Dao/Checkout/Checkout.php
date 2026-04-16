<?php
namespace Dao\Checkout;

use Dao\Table;

class Checkout extends Table
{
    public static function findOrCreateCliente(string $username, string $email): int
    {
        $cliente = self::obtenerUnRegistro(
            'SELECT clicod FROM cliente WHERE cliemail = :cliemail LIMIT 1',
            ['cliemail' => $email]
        );

        if ($cliente) {
            return intval($cliente['clicod']);
        }

        $conn = self::getConn();
        $sql = "INSERT INTO cliente (clinom, clitel, cliemail, clidir, cliest)
                VALUES (:clinom, '', :cliemail, '', 'ACT')";
        $stmt = $conn->prepare($sql);
        $stmt->execute([
            ':clinom' => $username,
            ':cliemail' => $email
        ]);

        return intval($conn->lastInsertId());
    }

    public static function createInvoiceFromCart(
        int $userId,
        int $clienteId,
        array $cartItems,
        string $paypalOrderId,
        string $paypalCaptureId,
        array $paypalResponse
    ): int {
        $conn = self::getConn();
        $conn->beginTransaction();

        try {
            $total = 0;
            foreach ($cartItems as $item) {
                $total += floatval($item['subtotal']);
            }
            $total = round($total, 2);

            $stmtFactura = $conn->prepare(
                "INSERT INTO factura (clicod, usercod, factfecha, facttotal, factest)
                 VALUES (:clicod, :usercod, NOW(), :facttotal, 'PAG')"
            );
            $stmtFactura->execute([
                ':clicod' => $clienteId,
                ':usercod' => $userId,
                ':facttotal' => $total
            ]);
            $factcod = intval($conn->lastInsertId());

            $stmtDetalle = $conn->prepare(
                "INSERT INTO factura_detalle (factcod, prodcod, factdetcant, factdetprecio, factdetsub)
                 VALUES (:factcod, :prodcod, :cantidad, :precio, :subtotal)"
            );

            $stmtStock = $conn->prepare(
                "UPDATE producto
                 SET prodstock = CASE WHEN prodstock >= :cantidad THEN prodstock - :cantidad ELSE 0 END
                 WHERE prodcod = :prodcod"
            );

            foreach ($cartItems as $item) {
                $stmtDetalle->execute([
                    ':factcod' => $factcod,
                    ':prodcod' => intval($item['prodcod']),
                    ':cantidad' => intval($item['quantity']),
                    ':precio' => floatval($item['prodprecio']),
                    ':subtotal' => floatval($item['subtotal'])
                ]);

                $stmtStock->execute([
                    ':cantidad' => intval($item['quantity']),
                    ':prodcod' => intval($item['prodcod'])
                ]);
            }

            $stmtPaypal = $conn->prepare(
                "INSERT INTO paypal_transaccion (factcod, paypalorderid, paypalcaptureid, montototal, moneda, estado, payloadjson, fching)
                 VALUES (:factcod, :paypalorderid, :paypalcaptureid, :montototal, :moneda, :estado, :payloadjson, NOW())"
            );
            $stmtPaypal->execute([
                ':factcod' => $factcod,
                ':paypalorderid' => $paypalOrderId,
                ':paypalcaptureid' => $paypalCaptureId,
                ':montototal' => $total,
                ':moneda' => 'USD',
                ':estado' => 'COMPLETED',
                ':payloadjson' => json_encode($paypalResponse, JSON_UNESCAPED_UNICODE)
            ]);

            $conn->commit();
            return $factcod;
        } catch (\Throwable $ex) {
            if ($conn->inTransaction()) {
                $conn->rollBack();
            }
            throw $ex;
        }
    }
}
