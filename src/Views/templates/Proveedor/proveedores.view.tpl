<section class="container-m row px-4 py-4">
    <h1>Listado de Proveedores</h1>
</section>
<section class="container-m row px-4 py-4">
    <form action="index.php?page=Proveedores_Proveedores" method="GET" class="col-12 row align-center">
        <input type="hidden" name="page" value="Proveedores_Proveedores">
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
                <th>Código</th>
                <th>Nombre</th>
                <th>Teléfono</th>
                <th>Email</th>
                <th>Estado</th>
                <th><a href="index.php?page=Proveedores_Proveedor&mode=INS" class="button">+ Nuevo</a></th>
            </tr>
        </thead>
        <tbody>
            {{foreach proveedores}}
            <tr>
                <td>{{provcod}}</td>
                <td><a href="index.php?page=Proveedores_Proveedor&mode=DSP&provcod={{provcod}}">{{provnom}}</a></td>
                <td>{{provtel}}</td>
                <td>{{provemail}}</td>
                <td>{{provest}}</td>
                <td class="center">
                    <a href="index.php?page=Proveedores_Proveedor&mode=UPD&provcod={{provcod}}">Editar</a>
                    &nbsp;
                    <a href="index.php?page=Proveedores_Proveedor&mode=DEL&provcod={{provcod}}">Eliminar</a>
                </td>
            </tr>
            {{endfor proveedores}}
        </tbody>
    </table>
</section>