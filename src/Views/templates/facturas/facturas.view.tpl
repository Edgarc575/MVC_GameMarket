<<<<<<< Updated upstream
<div class="facturas-logo-corners" aria-hidden="true">
    <img class="facturas-corner-logo facturas-corner-logo-br" src="{{BASE_DIR}}/public/imgs/img.jpeg" alt="">
</div>

<section class="container-m row px-4 py-4 facturas-header">
    <h1>Historial de Facturaci&oacute;n</h1>
</section>

<section class="container-m row px-4 py-4 facturas-filter">
    <form action="index.php?page=Facturas_Facturas" method="GET" class="col-12 row align-center facturas-filter-form">
        <input type="hidden" name="page" value="Facturas_Facturas">
        <div class="col-12 col-m-4 px-2 py-2">
            <label for="partialCod">Factura o Cliente</label>
            <input class="width-full facturas-input" type="text" name="partialCod" id="partialCod" value="{{partialCod}}">
        </div>
        <div class="col-12 col-m-2 px-2 py-4">
            <button type="submit" class="primary facturas-btn">Filtrar</button>
        </div>
    </form>
</section>

<section class="container-m row px-4 py-4 facturas-table-wrap">
    <table class="col-12 facturas-table">
=======
<section class="container-m row px-4 py-4">
    <h1>Historial de Facturacion</h1>
</section>
<section class="container-m row px-4 py-4">
    <form action="index.php?page=Facturas_Facturas" method="GET" class="col-12 row align-center">
        <input type="hidden" name="page" value="Facturas_Facturas">
        <div class="col-12 col-m-4 px-2 py-2">
            <label for="partialCod">Factura o Cliente</label>
            <input class="width-full" type="text" name="partialCod" id="partialCod" value="{{partialCod}}">
        </div>
        <div class="col-12 col-m-2 px-2 py-4">
            <button type="submit" class="primary">Filtrar</button>
        </div>
    </form>
</section>
<section class="container-m row px-4 py-4">
    <table class="col-12">
>>>>>>> Stashed changes
        <thead>
            <tr>
                <th>No.</th>
                <th>Fecha</th>
                <th>Cliente</th>
                <th>Vendedor</th>
                <th>Total</th>
                <th>Est.</th>
<<<<<<< Updated upstream
                <th><a href="index.php?page=Facturas_Factura&mode=INS" class="button facturas-link-btn">+ Nueva</a></th>
=======
                <th><a href="index.php?page=Facturas_Factura&mode=INS" class="button">+ Nueva</a></th>
>>>>>>> Stashed changes
            </tr>
        </thead>
        <tbody>
            {{foreach facturas}}
            <tr>
                <td>{{factcod}}</td>
                <td>{{factfecha}}</td>
                <td><a href="index.php?page=Facturas_Factura&mode=DSP&factcod={{factcod}}">{{clinom}}</a></td>
                <td>{{username}}</td>
                <td>L {{facttotal}}</td>
                <td>{{factest}}</td>
<<<<<<< Updated upstream
                <td class="facturas-actions-cell">
                    <a class="facturas-action" href="index.php?page=Facturas_Factura&mode=UPD&factcod={{factcod}}">Editar</a>
                    <a class="facturas-action facturas-action-danger" href="index.php?page=Facturas_Factura&mode=DEL&factcod={{factcod}}">Eliminar</a>
=======
                <td>
                    <a href="index.php?page=Facturas_Factura&mode=UPD&factcod={{factcod}}">Editar</a>
                    <a href="index.php?page=Facturas_Factura&mode=DEL&factcod={{factcod}}">Eliminar</a>
>>>>>>> Stashed changes
                </td>
            </tr>
            {{endfor facturas}}
        </tbody>
    </table>
<<<<<<< Updated upstream
    <div class="facturas-pagination">
        {{pagination}}
    </div>
</section>

<style>
:root {
    --facturas-azul: #2f5ea8;
    --facturas-azul-suave: #dbeafe;
    --facturas-rojo: #c43c3c;
    --facturas-rojo-suave: #ffe4e6;
    --facturas-negro: #111827;
    --facturas-blanco: #ffffff;
}

body {
    background: var(--facturas-azul-suave);
    color: var(--facturas-rojo);
    font-family: Arial, sans-serif;
}

main {
    background:
        linear-gradient(90deg, rgba(47, 94, 168, 0.08) 1px, transparent 1px),
        linear-gradient(rgba(47, 94, 168, 0.08) 1px, transparent 1px),
        linear-gradient(180deg, #edf5ff 0%, #dbeafe 100%);
    background-size: 22px 22px, 22px 22px, auto;
    overflow: hidden;
    position: relative;
}

.facturas-header,
.facturas-filter,
.facturas-table-wrap {
    background: transparent;
    position: relative;
    z-index: 1;
}

.facturas-logo-corners {
    pointer-events: none;
}

.facturas-corner-logo {
    border: 3px solid var(--facturas-negro);
    border-radius: 8px;
    box-shadow: 6px 6px 0 rgba(17, 24, 39, 0.35);
    height: 110px;
    object-fit: cover;
    opacity: 0.78;
    position: fixed;
    width: 110px;
    z-index: 2;
}

.facturas-corner-logo-br {
    bottom: 72px;
    right: 18px;
}

.facturas-header {
    padding-top: 48px;
}

.facturas-header h1 {
    background: var(--facturas-blanco);
    border: 3px solid var(--facturas-negro);
    border-left: 10px solid var(--facturas-azul);
    border-radius: 8px;
    box-shadow: 8px 8px 0 rgba(17, 24, 39, 0.24);
    color: var(--facturas-rojo);
    letter-spacing: 0;
    margin: 0 auto;
    max-width: 620px;
    padding: 18px 22px;
    position: relative;
    text-align: center;
    text-transform: uppercase;
}

.facturas-header h1::before,
.facturas-header h1::after {
    background: var(--facturas-rojo-suave);
    border: 2px solid var(--facturas-rojo);
    border-radius: 6px;
    color: var(--facturas-rojo);
    content: "PLAY";
    font-size: 12px;
    font-weight: bold;
    padding: 4px 8px;
    position: absolute;
    top: -14px;
}

.facturas-header h1::before {
    left: 18px;
}

.facturas-header h1::after {
    content: "LVL 01";
    right: 18px;
}

.facturas-filter-form {
    background: var(--facturas-blanco);
    border: 3px solid var(--facturas-negro);
    border-radius: 8px;
    box-shadow: 8px 8px 0 rgba(17, 24, 39, 0.22);
    margin: 0 auto;
    max-width: 760px;
    padding: 22px;
    position: relative;
}

.facturas-filter-form::before {
    background: linear-gradient(90deg, var(--facturas-rojo), var(--facturas-blanco), var(--facturas-azul));
    content: "";
    display: block;
    height: 6px;
}

.facturas-filter-form label {
    color: var(--facturas-rojo);
    display: block;
    font-weight: bold;
    margin-bottom: 6px;
}

.facturas-input {
    background: var(--facturas-rojo-suave);
    border: 2px solid var(--facturas-negro);
    border-radius: 6px;
    color: var(--facturas-rojo);
    font-weight: bold;
    min-height: 44px;
    padding: 10px 12px;
}

.facturas-input:focus {
    box-shadow: 0 0 0 4px rgba(220, 38, 38, 0.28);
    outline: none;
}

.facturas-btn,
.facturas-link-btn,
.facturas-action {
    background: var(--facturas-azul);
    border: 2px solid var(--facturas-negro);
    border-radius: 6px;
    color: var(--facturas-blanco);
    display: inline-block;
    font-weight: bold;
    padding: 10px 16px;
    text-decoration: none;
    transition: background 0.2s ease, transform 0.2s ease;
}

.facturas-btn:hover,
.facturas-link-btn:hover,
.facturas-action:hover {
    background: var(--facturas-rojo);
    color: var(--facturas-blanco);
    transform: translateY(-1px);
}

.facturas-table {
    background: var(--facturas-blanco);
    border: 3px solid var(--facturas-negro);
    border-collapse: separate;
    border-radius: 8px;
    border-spacing: 0;
    box-shadow: 8px 8px 0 rgba(17, 24, 39, 0.22);
    color: var(--facturas-rojo);
    overflow: hidden;
}

.facturas-table th {
    background: var(--facturas-azul);
    color: var(--facturas-blanco);
    padding: 14px 12px;
    text-align: left;
}

.facturas-table td {
    border-top: 2px solid rgba(5, 5, 5, 0.12);
    color: var(--facturas-rojo);
    font-weight: bold;
    padding: 14px 12px;
}

.facturas-table tbody tr:nth-child(even) {
    background: rgba(47, 94, 168, 0.08);
}

.facturas-table tbody tr:hover {
    background: var(--facturas-rojo-suave);
}

.facturas-table td a:not(.facturas-action) {
    color: var(--facturas-rojo);
    font-weight: bold;
}

.facturas-actions-cell {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
}

.facturas-action {
    font-size: 14px;
    padding: 8px 12px;
}

.facturas-action-danger {
    background: #d65a5a;
}

.facturas-pagination {
    margin-top: 22px;
    width: 100%;
}

.facturas-pagination a {
    background: var(--facturas-blanco);
    border: 2px solid var(--facturas-negro);
    color: var(--facturas-rojo);
    font-weight: bold;
}

@media (max-width: 760px) {
    .facturas-corner-logo {
        height: 70px;
        width: 70px;
    }

    .facturas-corner-logo-br {
        bottom: 64px;
    }

    .facturas-header h1,
    .facturas-filter-form,
    .facturas-table {
        box-shadow: 5px 5px 0 var(--facturas-negro);
    }

    .facturas-filter-form {
        padding: 16px;
    }

    .facturas-btn {
        width: 100%;
    }

    .facturas-table-wrap {
        overflow-x: auto;
    }

    .facturas-table {
        min-width: 850px;
    }
}
</style>
=======
    {{pagination}}
</section>
>>>>>>> Stashed changes
