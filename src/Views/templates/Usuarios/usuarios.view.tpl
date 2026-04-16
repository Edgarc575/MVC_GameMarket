<section class="container-m row px-4 py-4">
    <h1>Listado de Usuarios</h1>
</section>
<section class="container-m row px-4 py-4">
    <form action="index.php?page=Usuarios_Usuarios" method="GET" class="col-12 row align-center">
        <input type="hidden" name="page" value="Usuarios_Usuarios">
        <div class="col-12 col-m-4 px-2 py-2">
            <label for="partialNombre">Nombre</label>
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
                <th>Código Usuario</th>
                <th>Correo Usuario</th>
                <th>Nombre Usuario</th>
                <th>Contrasenha</th>
                <th>userfching</th>
                <th>Fecha estado contrasenha</th>
                <th>Fecha expiracion contrasenha</th>
                <th>Estado Usuario</th>
                <th>useractcod</th>
                <th>userpswdchg</th>
                <th>Tipo de Usuario</th>
                <th><a href="index.php?page=Usuarios_Usuario&mode=INS" class="button">+ Nuevo</a></th>
            </tr>
        </thead>
        <tbody>
            {{foreach usuarios}}
            <tr>
                <td>{{usercod}}</td>
                <td><a href="index.php?page=Usuarios_Usuario&mode=DSP&usercod={{usercod}}">{{useremail}}</a></td>
                <td>{{username}}</td>
                <td>{{userpswd}}</td>
                <td>{{userfching}}</td>
                <td>{{userpswdest}}</td>
                <td>{{userpswdexp}}</td>
                <td>{{userest}}</td>
                <td>{{useractcod}}</td>
                <td>{{userpswdchg}}</td>
                <td>{{usertipo}}</td>
                                <td class="gm-actions-cell">
    <a class="gm-action" href="index.php?page=Usuarios_Usuario&mode=UPD&usercod={{usercod}}">Editar</a>
    <a class="gm-action gm-action-danger" href="index.php?page=Usuarios_Usuario&mode=DEL&usercod={{usercod}}">Eliminar</a>
    <a class="gm-action" href="index.php?page=Usuarios_RolesUsuario&usercod={{usercod}}">Roles</a>
</td>
            </tr>
            {{endfor usuarios}}
        </tbody>
    </table>
</section>
