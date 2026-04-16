<section class="container-m row px-4 py-4 cliente-header">
    <h1>ERROR DE ACCESO</h1>
</section>

<section class="container-m row px-4 py-4 cliente-panel">
    <div class="col-12 col-m-8 offset-m-2 cliente-form" style="text-align: center;">
        
        <div class="row">
            <i class="fas fa-lock" style="font-size: 48px; color: var(--rojo); margin-bottom: 20px;"></i>
            <h2 style="color: var(--rojo); text-transform: uppercase; font-weight: bold; letter-spacing: 1px;">
                ¡No tiene permiso de acceder a este recurso!
            </h2>
        </div>

        <div class="row" style="background: var(--rojo-suave); border: 2px dashed var(--rojo); padding: 20px; border-radius: 8px; margin-top: 20px;">
            <p style="font-weight: bold; color: var(--negro); margin: 0;">
                >>> ESTA ZONA REQUIERE UN NIVEL DE PRIVILEGIO SUPERIOR <<<
            </p>
        </div>

        <div class="row flex-end" style="margin-top: 30px; justify-content: center;">
            <button type="button" id="btnRegresar" class="primary">
                REGRESAR AL INICIO
            </button>
        </div>

    </div>
</section>

<script>
document.addEventListener("DOMContentLoaded", ()=>{
    const btnRegresar = document.getElementById("btnRegresar");
    btnRegresar.addEventListener("click", (e)=>{
        e.preventDefault();
        window.location.assign("index.php?page=index");
    });
});
</script>

<style>
.cliente-form {
    background: var(--blanco);
    border: 3px solid var(--negro);
    border-radius: 8px;
    padding: 40px;
    box-shadow: 8px 8px 0 rgba(17, 24, 39, 0.22);
}

.cliente-form::before {
    content: "";
    display: block;
    height: 6px;
    background: var(--rojo);
    border-radius: 6px;
    margin-bottom: 22px;
}
</style>