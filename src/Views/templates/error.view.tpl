<section class="container-m row px-4 py-4 cliente-header">
    <h1>ERROR DEL SISTEMA</h1>
</section>

<section class="container-m row px-4 py-4 cliente-panel">
    <div class="col-12 col-m-8 offset-m-2 cliente-form" style="text-align: center;">
        
        <div class="row">
            <h2 style="color: var(--rojo); font-size: 42px; font-weight: bold; margin-bottom: 10px; text-transform: uppercase;">
                OOPS.
            </h2>
            <h3 style="color: var(--negro); text-transform: uppercase; letter-spacing: 1px;">
                Error {{CLIENT_ERROR_CODE}}: {{CLIENT_ERROR_MSG}}
            </h3>
        </div>

        {{if DEVELOPMENT}}
            <div class="row" style="background: var(--negro); color: #00ff00; font-family: 'Courier New', monospace; padding: 20px; border: 3px solid var(--azul); border-radius: 6px; text-align: left; margin-top: 30px; box-shadow: inset 0 0 10px rgba(0,255,0,0.2);">
                <p style="margin: 0; font-size: 14px; border-bottom: 1px solid #004400; padding-bottom: 5px; margin-bottom: 10px;">DEBUG_LOG_SYSTEM_V.1.0</p>
                <div style="font-weight: bold;">CODE: {{ERROR_CODE}}</div>
                <div style="margin-top: 10px;">MSG: {{ERROR_MSG}}</div>
            </div>
        {{endif DEVELOPMENT}}

        <div class="row" style="margin-top: 40px; border-top: 2px dashed var(--azul-suave); padding-top: 20px;">
            <p style="font-weight: bold; color: var(--azul);">>>> POR FAVOR, REINICIE LA SESION O REGRESE AL MENU <<<</p>
        </div>

        <div class="row flex-end" style="justify-content: center; margin-top: 25px;">
            <button type="button" id="btnHome" class="primary">
                REINTENTAR (INICIO)
            </button>
        </div>

    </div>
</section>

<script>
document.addEventListener("DOMContentLoaded", ()=>{
    const btnHome = document.getElementById("btnHome");
    btnHome.addEventListener("click", (e)=>{
        e.preventDefault();
        window.location.assign("index.php");
    });
});
</script>

<style>
.cliente-panel {
    min-height: 70vh;
    display: flex;
    align-items: center;
}

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
    height: 8px;
    background: repeating-linear-gradient(
        45deg,
        var(--rojo),
        var(--rojo) 10px,
        var(--negro) 10px,
        var(--negro) 20px
    );
    border-radius: 6px;
    margin-bottom: 22px;
}
</style>
