<h1>Formulario de Libros</h1>
<section class="grid row">
    <form class="depth-0 offset-3 col-6" action="index.php?page=Mantenimientos-Productos-FormularioProductos" method="POST" >
        <div class="row align-center">
            <div class="col-4">
                <label for="id">Codigo</label>
            </div>
            <div class="col-8">
                <input type="text" value="{{id}}" disabled  name="id" id="id"/>
            </div>
        </div>
         <div class="row align-center">
            <div class="col-4">
                <label for="titulo">Producto</label>
            </div>
            <div class="col-8">
                <input type="text" name="titulo" id="titulo" value="{{nombre}}" placeholder="Nombre Producto" />
            </div>
        </div>
        <div class="row align-start">
            <div class="col-4">
                <label for="descripcion">Descripcion</label>
            </div>
            <div class="col-8">
                <textarea id="descripcion" name="descripcion" placeholder="Descripcion del producto" cols="40" rows="8">{{descripcion}}</textarea>
            </div>
        </div>
        <div class="row align-center">
            <div class="col-4">
                <label for="precio">Precio</label>
            </div>
            <div class="col-8">
                <input type="text" name="precio" id="precio" value="{{precio}}" placeholder="Precio del Libro" />
            </div>
        </div>
        <div class="right">
            <button type="submit" name="btnEnviar">Confirmar</button>
            &nbsp;
            <button id="cancelar">Cancelar</button>
        </div>
    </form>
</section>