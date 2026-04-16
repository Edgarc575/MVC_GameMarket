<div class="gm-logo-corner" aria-hidden="true">
    <img src="{{BASE_DIR}}/public/imgs/img.jpeg" alt="">
</div>

<section class="container-m row px-4 py-4 gm-header">
    <h1>Listado de Productos</h1>
</section>

<section class="container-m row px-4 py-4 gm-table-wrap">
    <table class="col-12 gm-table">
        <thead>
            <tr>
                <th>Cod</th>
                <th>Producto</th>
                <th>Precio</th>
                <th>Stock</th>
                <th>Proveedor</th>
                <th><a href="index.php?page=Productos_Producto&mode=INS" class="button gm-link-btn">+ Nuevo</a></th>
            </tr>
        </thead>
        <tbody>
            {{foreach productos}}
            <tr>
                <td>{{prodcod}}</td>
                <td><a href="index.php?page=Productos_Producto&mode=DSP&prodcod={{prodcod}}">{{prodnom}}</a></td>
                <td>{{prodprecio}}</td>
                <td>{{prodstock}}</td>
                <td>{{provnom}}</td>
                <td class="gm-actions-cell">
                    <a class="gm-action" href="index.php?page=Productos_Producto&mode=UPD&prodcod={{prodcod}}">Editar</a>
                    <a class="gm-action gm-action-danger" href="index.php?page=Productos_Producto&mode=DEL&prodcod={{prodcod}}">Eliminar</a>
                </td>
            </tr>
            {{endfor productos}}
        </tbody>
    </table>
    <div class="gm-pagination">{{pagination}}</div>
</section>

<style>
:root{--gm-blue:#2f5ea8;--gm-blue-soft:#dbeafe;--gm-red:#c43c3c;--gm-red-soft:#ffe4e6;--gm-black:#111827;--gm-white:#fff}
body{background:var(--gm-blue-soft);color:var(--gm-red);font-family:Arial,sans-serif}
main{background:linear-gradient(90deg,rgba(47,94,168,.08) 1px,transparent 1px),linear-gradient(rgba(47,94,168,.08) 1px,transparent 1px),linear-gradient(180deg,#edf5ff 0%,#dbeafe 100%);background-size:22px 22px,22px 22px,auto;overflow:hidden;position:relative}
.gm-logo-corner{pointer-events:none}.gm-logo-corner img{border:3px solid var(--gm-black);border-radius:8px;box-shadow:6px 6px 0 rgba(17,24,39,.35);height:110px;object-fit:cover;opacity:.78;position:fixed;right:18px;bottom:72px;width:110px;z-index:2}
.gm-header,.gm-table-wrap{background:transparent;position:relative;z-index:1}.gm-header{padding-top:48px}.gm-header h1{background:var(--gm-white);border:3px solid var(--gm-black);border-left:10px solid var(--gm-blue);border-radius:8px;box-shadow:8px 8px 0 rgba(17,24,39,.24);color:var(--gm-red);letter-spacing:0;margin:0 auto;max-width:620px;padding:18px 22px;position:relative;text-align:center;text-transform:uppercase}
.gm-header h1:before,.gm-header h1:after{background:var(--gm-red-soft);border:2px solid var(--gm-red);border-radius:6px;color:var(--gm-red);font-size:12px;font-weight:bold;padding:4px 8px;position:absolute;top:-14px}.gm-header h1:before{content:"SHOP";left:18px}.gm-header h1:after{content:"INVENTORY";right:18px}
.gm-table{background:var(--gm-white);border:3px solid var(--gm-black);border-collapse:separate;border-radius:8px;border-spacing:0;box-shadow:8px 8px 0 rgba(17,24,39,.22);color:var(--gm-red);overflow:hidden}.gm-table th{background:var(--gm-blue);color:var(--gm-white);padding:14px 12px;text-align:left}.gm-table td{border-top:2px solid rgba(17,24,39,.12);color:var(--gm-red);font-weight:bold;padding:14px 12px}.gm-table tbody tr:nth-child(even){background:rgba(47,94,168,.08)}.gm-table tbody tr:hover{background:var(--gm-red-soft)}.gm-table td a:not(.gm-action){color:var(--gm-red);font-weight:bold}.gm-link-btn,.gm-action{background:var(--gm-blue);border:2px solid var(--gm-black);border-radius:6px;color:var(--gm-white);display:inline-block;font-weight:bold;padding:10px 16px;text-decoration:none}.gm-link-btn:hover,.gm-action:hover{background:var(--gm-red);color:var(--gm-white);transform:translateY(-1px)}.gm-actions-cell{display:flex;flex-wrap:wrap;gap:8px}.gm-action{font-size:14px;padding:8px 12px}.gm-action-danger{background:#d65a5a}.gm-pagination{margin-top:22px;width:100%}.gm-pagination a{background:var(--gm-white);border:2px solid var(--gm-black);color:var(--gm-red);font-weight:bold}
@media(max-width:760px){.gm-logo-corner img{height:70px;width:70px;bottom:64px}.gm-header h1,.gm-table{box-shadow:5px 5px 0 rgba(17,24,39,.24)}.gm-table-wrap{overflow-x:auto}.gm-table{min-width:760px}}
</style>
