<div class="gm-logo-corner" aria-hidden="true">
    <img src="{{BASE_DIR}}/public/imgs/img.jpeg" alt="Logo Corner">
</div>

<section class="container-m row px-4 py-4 gm-header">
    <h1>Catálogo GameMarket</h1>
</section>

<section class="container-m row px-4 py-4 gm-filter-wrap">
    <form action="index.php" method="GET" class="col-12 row gm-filter">
        <input type="hidden" name="page" value="Catalogo_Catalogo">
        <div class="col-12 col-m-8 px-2 py-2">
            <input class="width-full gm-input" type="text" name="q" value="{{q}}" placeholder="Buscar juego o accesorio">
        </div>
        <div class="col-12 col-m-4 px-2 py-2 gm-tools">
            <button type="submit" class="gm-btn">Buscar</button>
            <a class="gm-btn gm-btn-secondary" href="index.php?page=Checkout_Checkout">
                Carrito ({{cartCount}}) - L{{cartTotal}}
            </a>
        </div>
    </form>
</section>

<section class="container-m row px-4 py-4 gm-catalog-grid">
    {{foreach productos}}
    <article class="col-12 col-m-6 col-l-4 px-2 py-2">
        <div class="gm-card">
            <!-- Sección de Imagen del Producto -->
            <div class="gm-card-img">
                <img src="{{prodimgurl}}" alt="{{prodnom}}">
            </div>

            <div class="gm-card-body">
                <div class="gm-card-header">
                    <span class="gm-badge">Stock: {{prodstock}}</span>
                </div>
                <h2>{{prodnom}}</h2>
                <p>{{proddsc}}</p>
                <div class="gm-price">L {{prodprecio}}</div>
            </div>

            <div class="gm-card-actions">
                {{if sin_stock}}
                <span class="gm-stock-off">Agotado</span>
                {{endif sin_stock}}
                
                {{ifnot sin_stock}}
                <form action="index.php?page=Checkout_Add" method="POST" class="gm-add-form">
                    <input type="hidden" name="prodcod" value="{{prodcod}}">
                    <input class="gm-qty" type="number" name="qty" min="1" max="{{prodstock}}" value="1">
                    <button class="gm-btn" type="submit">Agregar</button>
                </form>
                {{endifnot sin_stock}}
            </div>
        </div>
    </article>
    {{endfor productos}}
</section>

<style>
    :root {
        --gm-blue: #2f5ea8;
        --gm-blue-soft: #dbeafe;
        --gm-red: #c43c3c;
        --gm-red-soft: #ffe4e6;
        --gm-black: #111827;
        --gm-white: #fff;
    }

    body {
        background: var(--gm-blue-soft);
        color: var(--gm-red);
        font-family: Arial, sans-serif;
    }

    main {
        background: linear-gradient(90deg, rgba(47, 94, 168, .08) 1px, transparent 1px), 
                    linear-gradient(rgba(47, 94, 168, .08) 1px, transparent 1px), 
                    linear-gradient(180deg, #edf5ff 0%, #dbeafe 100%);
        background-size: 22px 22px, 22px 22px, auto;
        overflow: hidden;
        position: relative;
    }

    /* Estilos de la imagen del producto */
    .gm-card-img {
        width: 100%;
        height: 220px;
        margin-bottom: 15px;
        overflow: hidden;
        border: 2px solid var(--gm-black);
        border-radius: 6px;
    }

    .gm-card-img img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.3s ease;
    }

    .gm-card:hover .gm-card-img img {
        transform: scale(1.05);
    }

    .gm-logo-corner img {
        border: 3px solid var(--gm-black);
        border-radius: 8px;
        box-shadow: 6px 6px 0 rgba(17, 24, 39, .35);
        height: 110px;
        object-fit: cover;
        opacity: .78;
        position: fixed;
        right: 18px;
        bottom: 72px;
        width: 110px;
        z-index: 2;
    }

    .gm-header, .gm-filter-wrap, .gm-catalog-grid {
        position: relative;
        z-index: 1;
    }

    .gm-header h1, .gm-filter, .gm-card {
        background: var(--gm-white);
        border: 3px solid var(--gm-black);
        border-radius: 8px;
        box-shadow: 8px 8px 0 rgba(17, 24, 39, .22);
    }

    .gm-header h1 {
        border-left: 10px solid var(--gm-blue);
        color: var(--gm-red);
        margin: 0 auto;
        max-width: 620px;
        padding: 18px 22px;
        text-align: center;
        text-transform: uppercase;
    }

    .gm-filter {
        align-items: center;
        padding: 18px;
    }

    .gm-input, .gm-qty {
        background: var(--gm-red-soft);
        border: 2px solid var(--gm-black);
        border-radius: 6px;
        color: var(--gm-red);
        font-weight: bold;
        min-height: 44px;
        padding: 10px 12px;
    }

    .gm-tools {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
    }

    .gm-btn {
        background: var(--gm-blue);
        border: 2px solid var(--gm-black);
        border-radius: 6px;
        color: var(--gm-white);
        display: inline-block;
        font-weight: bold;
        padding: 10px 16px;
        text-decoration: none;
        cursor: pointer;
    }

    .gm-btn-secondary {
        background: var(--gm-red);
    }

    .gm-catalog-grid {
        display: flex;
        flex-wrap: wrap;
    }

    .gm-card {
        display: flex;
        flex-direction: column;
        height: 100%;
        padding: 15px;
    }

    .gm-card-body {
        display: flex;
        flex: 1;
        flex-direction: column;
        gap: 8px;
    }

    .gm-card h2 {
        margin: 0;
        font-size: 1.25rem;
    }

    .gm-card p {
        color: #374151;
        flex: 1;
        margin: 0;
        font-size: 0.95rem;
    }

    .gm-price {
        font-size: 1.5rem;
        font-weight: bold;
        color: var(--gm-black);
    }

    .gm-badge, .gm-stock-off {
        background: var(--gm-red-soft);
        border: 2px solid var(--gm-black);
        border-radius: 999px;
        display: inline-block;
        font-size: .85rem;
        font-weight: bold;
        padding: 4px 12px;
    }

    .gm-card-actions {
        margin-top: 15px;
        border-top: 1px solid #eee;
        padding-top: 15px;
    }

    .gm-add-form {
        align-items: center;
        display: flex;
        gap: 10px;
    }

    .gm-qty {
        max-width: 70px;
    }

    .gm-stock-off {
        color: var(--gm-red);
        text-align: center;
        display: block;
    }
</style>
