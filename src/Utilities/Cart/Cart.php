<?php
namespace Utilities\Cart;

class Cart
{
    private const SESSION_KEY = 'shopping_cart';

    public static function getCart(): array
    {
        return $_SESSION[self::SESSION_KEY] ?? [];
    }

    public static function addItem(array $product, int $qty = 1): void
    {
        $cart = self::getCart();
        $productId = intval($product['prodcod']);
        $stock = max(0, intval($product['prodstock'] ?? 0));
        $qty = max(1, $qty);

        if (isset($cart[$productId])) {
            $qty += intval($cart[$productId]['quantity']);
        }

        $qty = min($qty, $stock > 0 ? $stock : $qty);

        $cart[$productId] = [
            'prodcod' => $productId,
            'prodnom' => $product['prodnom'],
            'proddsc' => $product['proddsc'] ?? '',
            'prodprecio' => floatval($product['prodprecio']),
            'prodstock' => $stock,
            'quantity' => $qty,
            'subtotal' => round(floatval($product['prodprecio']) * $qty, 2)
        ];

        $_SESSION[self::SESSION_KEY] = $cart;
    }

    public static function updateItem(int $productId, int $qty): void
    {
        $cart = self::getCart();
        if (!isset($cart[$productId])) {
            return;
        }

        if ($qty <= 0) {
            unset($cart[$productId]);
        } else {
            $qty = min($qty, max(1, intval($cart[$productId]['prodstock'] ?? $qty)));
            $cart[$productId]['quantity'] = $qty;
            $cart[$productId]['subtotal'] = round(floatval($cart[$productId]['prodprecio']) * $qty, 2);
        }

        $_SESSION[self::SESSION_KEY] = $cart;
    }

    public static function removeItem(int $productId): void
    {
        $cart = self::getCart();
        unset($cart[$productId]);
        $_SESSION[self::SESSION_KEY] = $cart;
    }

    public static function clear(): void
    {
        unset($_SESSION[self::SESSION_KEY]);
    }

    public static function getCount(): int
    {
        return array_reduce(self::getCart(), function ($carry, $item) {
            return $carry + intval($item['quantity']);
        }, 0);
    }

    public static function getTotal(): float
    {
        return round(array_reduce(self::getCart(), function ($carry, $item) {
            return $carry + floatval($item['subtotal']);
        }, 0.0), 2);
    }

    public static function getItemsForView(): array
    {
        return array_values(self::getCart());
    }
}
