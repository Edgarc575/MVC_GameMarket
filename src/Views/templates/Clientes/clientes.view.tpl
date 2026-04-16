<div class="clientes-logo-corners" aria-hidden="true">
    <img class="clientes-corner-logo clientes-corner-logo-br" src="{{BASE_DIR}}/public/imgs/img.jpeg" alt="">
</div>

<section class="container-m row px-4 py-4 clientes-header">
    <h1>Listado de Clientes</h1>
</section>

<section class="container-m row px-4 py-4 clientes-filter">
    <form action="index.php?page=Clientes_Clientes" method="GET" class="col-12 row align-center clientes-filter-form">
        <input type="hidden" name="page" value="Clientes_Clientes">
        <div class="col-12 col-m-4 px-2 py-2">
            <label for="partialNombre">Nombre</label>
            <input class="width-full clientes-input" type="text" name="partialNombre" id="partialNombre" value="{{partialNombre}}">
        </div>
        <div class="col-12 col-m-2 px-2 py-4">
            <button type="submit" class="primary clientes-btn">Filtrar</button>
        </div>
    </form>
</section>

<section class="container-m row px-4 py-4 clientes-table-wrap">
    <table class="col-12 clientes-table">
        <thead>
            <tr>
                <th>C&oacute;digo</th>
                <th>Nombre</th>
                <th>Tel&eacute;fono</th>
                <th>Email</th>
                <th>Estado</th>
                <th><a href="index.php?page=Clientes_Cliente&mode=INS" class="button clientes-link-btn">+ Nuevo</a></th>
            </tr>
        </thead>
        <tbody>
            {{foreach clientes}}
            <tr>
                <td>{{clicod}}</td>
                <td><a href="index.php?page=Clientes_Cliente&mode=DSP&clicod={{clicod}}">{{clinom}}</a></td>
                <td>{{clitel}}</td>
                <td>{{cliemail}}</td>
                <td>{{cliest}}</td>
                <td class="center">
                    <a class="clientes-action" href="index.php?page=Clientes_Cliente&mode=UPD&clicod={{clicod}}">Editar</a>
                    &nbsp;
                    <a class="clientes-action clientes-action-danger" href="index.php?page=Clientes_Cliente&mode=DEL&clicod={{clicod}}">Eliminar</a>
                </td>
            </tr>
            {{endfor clientes}}
        </tbody>
    </table>
</section>

<style>
:root {
    --clientes-azul: #2f5ea8;
    --clientes-azul-suave: #dbeafe;
    --clientes-rojo: #c43c3c;
    --clientes-rojo-suave: #ffe4e6;
    --clientes-negro: #111827;
    --clientes-blanco: #ffffff;
}

body {
    background: var(--clientes-azul-suave);
    color: var(--clientes-rojo);
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

.clientes-header,
.clientes-filter,
.clientes-table-wrap {
    background: transparent;
    position: relative;
    z-index: 1;
}

.clientes-logo-corners {
    pointer-events: none;
}

.clientes-corner-logo {
    border: 3px solid var(--clientes-negro);
    border-radius: 8px;
    box-shadow: 6px 6px 0 rgba(17, 24, 39, 0.35);
    height: 110px;
    object-fit: cover;
    opacity: 0.78;
    position: fixed;
    width: 110px;
    z-index: 2;
}

.clientes-corner-logo-br {
    bottom: 72px;
    right: 18px;
}

.clientes-header {
    padding-top: 48px;
}

.clientes-header h1 {
    color: var(--clientes-rojo);
    background: var(--clientes-blanco);
    border: 3px solid var(--clientes-negro);
    border-left: 10px solid var(--clientes-azul);
    border-radius: 8px;
    box-shadow: 8px 8px 0 rgba(17, 24, 39, 0.24);
    margin: 0 auto;
    max-width: 560px;
    padding: 18px 22px;
    text-align: center;
    letter-spacing: 0;
    position: relative;
    text-transform: uppercase;
}

.clientes-header h1::before,
.clientes-header h1::after {
    background: var(--clientes-rojo-suave);
    border: 2px solid var(--clientes-rojo);
    border-radius: 6px;
    color: var(--clientes-rojo);
    content: "PLAYERS";
    font-size: 12px;
    font-weight: bold;
    padding: 4px 8px;
    position: absolute;
    top: -14px;
}

.clientes-header h1::before {
    left: 18px;
}

.clientes-header h1::after {
    content: "ROSTER";
    right: 18px;
}

.clientes-filter-form {
    background: var(--clientes-blanco);
    border: 3px solid var(--clientes-negro);
    border-radius: 8px;
    box-shadow: 8px 8px 0 rgba(17, 24, 39, 0.22);
    margin: 0 auto;
    max-width: 760px;
    padding: 22px;
    position: relative;
}

.clientes-filter-form::before {
    background: linear-gradient(90deg, var(--clientes-rojo), var(--clientes-blanco), var(--clientes-azul));
    border-radius: 6px;
    content: "";
    display: block;
    height: 6px;
    margin-bottom: 16px;
}

.clientes-filter-form label {
    color: var(--clientes-rojo);
    display: block;
    font-weight: bold;
    margin-bottom: 6px;
}

.clientes-input {
    background: var(--clientes-rojo-suave);
    border: 2px solid var(--clientes-negro);
    border-radius: 6px;
    color: var(--clientes-rojo);
    font-weight: bold;
    min-height: 44px;
    padding: 10px 12px;
}

.clientes-input:focus {
    box-shadow: 0 0 0 4px rgba(220, 38, 38, 0.28);
    outline: none;
}

.clientes-btn,
.clientes-link-btn,
.clientes-action {
    background: var(--clientes-azul);
    border: 2px solid var(--clientes-negro);
    border-radius: 6px;
    color: var(--clientes-blanco);
    display: inline-block;
    font-weight: bold;
    padding: 10px 16px;
    text-decoration: none;
    transition: transform 0.2s ease, background 0.2s ease;
}

.clientes-btn:hover,
.clientes-link-btn:hover,
.clientes-action:hover {
    background: var(--clientes-rojo);
    color: var(--clientes-blanco);
    transform: translateY(-1px);
}

.clientes-table {
    background: var(--clientes-blanco);
    border: 3px solid var(--clientes-negro);
    border-collapse: separate;
    border-radius: 8px;
    border-spacing: 0;
    box-shadow: 8px 8px 0 rgba(17, 24, 39, 0.22);
    color: var(--clientes-rojo);
    overflow: hidden;
}

.clientes-table th {
    background: var(--clientes-azul);
    color: var(--clientes-blanco);
    padding: 14px 12px;
    text-align: left;
}

.clientes-table td {
    border-top: 2px solid rgba(5, 5, 5, 0.12);
    color: var(--clientes-rojo);
    font-weight: bold;
    padding: 14px 12px;
}

.clientes-table tbody tr:nth-child(even) {
    background: rgba(47, 94, 168, 0.08);
}

.clientes-table tbody tr:hover {
    background: var(--clientes-rojo-suave);
}

.clientes-table td a:not(.clientes-action) {
    color: var(--clientes-rojo);
    font-weight: bold;
}

.clientes-action {
    font-size: 14px;
    padding: 8px 12px;
}

.clientes-action-danger {
    background: #d65a5a;
}

@media (max-width: 760px) {
    .clientes-corner-logo {
        height: 70px;
        width: 70px;
    }

    .clientes-corner-logo-br {
        bottom: 64px;
    }

    .clientes-header h1,
    .clientes-filter-form,
    .clientes-table {
        box-shadow: 5px 5px 0 rgba(17, 24, 39, 0.24);
    }

    .clientes-filter-form {
        padding: 16px;
    }

    .clientes-btn {
        width: 100%;
    }

    .clientes-table-wrap {
        overflow-x: auto;
    }

    .clientes-table {
        min-width: 720px;
    }
}
</style>
