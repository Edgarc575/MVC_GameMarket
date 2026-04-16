<div class="gm-logo-corner" aria-hidden="true">
    <img src="{{BASE_DIR}}/public/imgs/img.jpeg" alt="">
</div>


<section class="container-m row px-4 py-4 gm-header">
    <h1 class="roles-title">Gestion de Roles</h1>
</section>

<section class="container-m row px-4 py-4 gm-table-wrap">
    <h2 style="color: var(--gm-blue); margin-bottom: 10px; font-weight: bold; text-transform: uppercase;">Roles del Usuario</h2>
    <table class="col-12 gm-table">
        <thead>
            <tr>
                <th>Descripcion del Rol</th>
                <th style="text-align: right;">Accion</th>
            </tr>
        </thead>
        <tbody>
            {{foreach rolesAsignados}}
            <tr>
                <td>{{roldsc}}</td>
                <td class="gm-actions-cell" style="justify-content: flex-end;">
                    <form method="post" style="margin:0;">
                        <input type="hidden" name="rolcod" value="{{rolcod}}">
                        <button type="submit" name="removeRol" class="gm-action gm-action-danger">Quitar</button>
                    </form>
                </td>
            </tr>
            {{endfor rolesAsignados}}
        </tbody>
    </table>
</section>

<!-- SECCIÓN AGREGAR ROLES -->
<section class="container-m row px-4 py-4 gm-table-wrap" style="padding-top: 0;">
    <h2 style="color: var(--gm-blue); margin-bottom: 10px; font-weight: bold; text-transform: uppercase;">Agregar Nuevo Rol</h2>
    <table class="col-12 gm-table">
        <thead>
            <tr>
                <th>Rol Disponible</th>
                <th style="text-align: right;">Accion</th>
            </tr>
        </thead>
        <tbody>
            {{foreach rolesDisponibles}}
            <tr>
                <td>{{roldsc}}</td>
                <td class="gm-actions-cell" style="justify-content: flex-end;">
                    <form method="post" style="margin:0;">
                        <input type="hidden" name="rolcod" value="{{rolcod}}">
                        <button type="submit" name="addRol" class="gm-action">Agregar</button>
                    </form>
                </td>
            </tr>
            {{endfor rolesDisponibles}}
        </tbody>
    </table>
</section>

<style>
:root{--gm-blue:#2f5ea8;--gm-blue-soft:#dbeafe;--gm-red:#c43c3c;--gm-red-soft:#ffe4e6;--gm-black:#111827;--gm-white:#fff}
body{background:var(--gm-blue-soft);color:var(--gm-red);font-family:Arial,sans-serif}

.gm-logo-corner img{border:3px solid var(--gm-black);border-radius:8px;box-shadow:6px 6px 0 rgba(17,24,39,.35);height:110px;object-fit:cover;opacity:.78;position:fixed;right:18px;bottom:72px;width:110px;z-index:2}

.gm-header h1{background:var(--gm-white);border:3px solid var(--gm-black);border-left:10px solid var(--gm-blue);border-radius:8px;box-shadow:8px 8px 0 rgba(17,24,39,.24);color:var(--gm-red);margin:0 auto;max-width:620px;padding:18px 22px;position:relative;text-align:center;text-transform:uppercase}
.gm-header h1:before,.gm-header h1:after{background:var(--gm-red-soft);border:2px solid var(--gm-red);border-radius:6px;color:var(--gm-red);font-size:12px;font-weight:bold;padding:4px 8px;position:absolute;top:-14px}
.gm-header h1:before{content:"USER";}
.gm-header h1:after{content:"PERMISSIONS";}

.gm-table{background:var(--gm-white);border:3px solid var(--gm-black);border-collapse:separate;border-radius:8px;border-spacing:0;box-shadow:8px 8px 0 rgba(17,24,39,.22);color:var(--gm-red);overflow:hidden; width: 100%;}
.gm-table th{background:var(--gm-blue);color:var(--gm-white);padding:14px 12px;text-align:left}
.gm-table td{border-top:2px solid rgba(17,24,39,.12);color:var(--gm-red);font-weight:bold;padding:14px 12px}
.gm-table tbody tr:nth-child(even){background:rgba(47,94,168,.08)}
.gm-table tbody tr:hover{background:var(--gm-red-soft)}

.gm-action{background:var(--gm-blue);border:2px solid var(--gm-black);border-radius:6px;color:var(--gm-white);display:inline-block;font-weight:bold;padding:8px 16px;text-decoration:none; cursor: pointer;}
.gm-action:hover{background:var(--gm-red);transform:translateY(-1px)}
.gm-action-danger{background:#d65a5a}
.gm-actions-cell{display:flex;gap:8px}

@media(max-width:760px){
    .gm-header h1{ font-size: 1.2rem; }
    .gm-logo-corner img{height:70px;width:70px;}
}
</style>
