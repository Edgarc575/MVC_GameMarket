<section class="container-m row px-4 py-4">
    <h1>Listado de Roles</h1>
</section>
<section class="container-m row px-4 py-4">
    <form action="index.php?page=Roles_Roles" method="GET" class="col-12 row align-center">
        <input type="hidden" name="page" value="Roles_Roles">
        <div class="col-12 col-m-4 px-2 py-2">
            <label for="partialNombre">Nombre Rol</label>
            <input class="width-full" type="text" name="partialNombre" id="partialNombre" value="{{partialNombre}}">
        </div>
        <div class="col-12 col-m-2 px-2 py-4">
            <button type="submit" class="primary">Filtrar</button>
        </div>
    </form>
</section>
<section class="container-m row px-4 py-4">
    <table class="col-12">
        <thead>
            <tr>
                <th>Codigo Rol</th>
                <th>Nombre Rol</th>
                <th>Estado Rol</th>
                <th><a href="index.php?page=Roles_Rol&mode=INS" class="button">+ Nuevo</a></th>
            </tr>
        </thead>
        <tbody>
            {{foreach roles}}
            <tr>
                <td>{{rolcod}}</td>
                <td><a href="index.php?page=Roles_Rol&mode=DSP&rolcod={{rolcod}}">{{roldsc}}</a></td>
                <td>{{rolest}}</td>
                <td class="center">
                    <a href="index.php?page=Roles_Rol&mode=UPD&rolcod={{rolcod}}">Editar</a>
                    &nbsp;
                    <a href="index.php?page=Roles_Rol&mode=DEL&rolcod={{rolcod}}">Eliminar</a>
                </td>
            </tr>
            {{endfor roles}}
        </tbody>
    </table>
    {{pagination}}
</section>
