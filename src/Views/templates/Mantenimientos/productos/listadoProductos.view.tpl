<section class="container">
    <table class="">
        <thead>
            <tr>
                <th>Codigo</th>
                <th>Nombre</th>
                <th>Precio en LPS</th>
                <th>
                    <a href="index.php?page=Mantenimientos-Productos-FormularioProductos&mode=INS&id=0">Nuevo</a>
                </th>
            </tr>
        </thead>
        <tbody>
            {{foreach producto}}
            <tr>
                <td>{{prodcod}}</td>
                <td>{{prodnom}}</td>
                <td>{{prodprecio}}</td>
                <td>
                    <a href="index.php?page=Mantenimientos-Productos-FormularioProductos&mode=DPS&id={{id}}">Mostrar</a>
                </td>
            </tr>
            {{endfor producto}}

        </tbody>

    </table>

</section>