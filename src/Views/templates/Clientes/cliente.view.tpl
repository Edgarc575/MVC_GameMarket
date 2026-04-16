<<<<<<< Updated upstream
<div class="cliente-logo-corners" aria-hidden="true">
    <img class="cliente-corner-logo cliente-corner-logo-br" src="{{BASE_DIR}}/public/imgs/img.jpeg" alt="">
</div>

<section class="container-m row px-4 py-4 cliente-header">
    <h1>{{FormTitle}}</h1>
</section>

<section class="container-m row px-4 py-4 cliente-panel">
    {{with cliente}}
    <form action="index.php?page=Clientes_Cliente&mode={{~mode}}&clicod={{clicod}}" method="POST" class="col-12 col-m-8 offset-m-2 cliente-form">

        <!-- CAMPOS OCULTOS -->
        <input type="hidden" name="mode" value="{{~mode}}" />
        <input type="hidden" name="clicod" value="{{clicod}}" />
        <input type="hidden" name="cliente_xss_token" value="{{~cliente_xss_token}}" />

        <!-- CODIGO -->
        <div class="row">
            <label for="clicodD">C&oacute;digo</label>
            <input readonly disabled type="text" id="clicodD" value="{{clicod}}" />
        </div>

        <!-- NOMBRE -->
        <div class="row">
            <label for="clinom">Nombre</label>
            <input {{~readonly}} type="text" name="clinom" id="clinom" value="{{clinom}}" />
            {{if clinom_error}}
                <div class="error">{{clinom_error}}</div>
            {{endif clinom_error}}
        </div>

        <!-- TELEFONO -->
        <div class="row">
            <label for="clitel">Tel&eacute;fono</label>
            <input {{~readonly}} type="text" name="clitel" id="clitel" value="{{clitel}}" />
        </div>

        <!-- EMAIL -->
        <div class="row">
            <label for="cliemail">Email</label>
            <input {{~readonly}} type="email" name="cliemail" id="cliemail" value="{{cliemail}}" />
            {{if cliemail_error}}
                <div class="error">{{cliemail_error}}</div>
            {{endif cliemail_error}}
        </div>

        <!-- DIRECCION -->
        <div class="row">
            <label for="clidir">Direcci&oacute;n</label>
            <textarea {{~readonly}} name="clidir" id="clidir">{{clidir}}</textarea>
        </div>

        <!-- ESTADO -->
        <div class="row">
            <label for="cliest">Estado</label>
            <select name="cliest" id="cliest" {{if ~readonly}} disabled {{endif ~readonly}}>
=======
<section class="container-m row px-4 py-4">
    <h1>{{FormTitle}}</h1>
</section>
<section class="container-m row px-4 py-4">
    {{with cliente}}
    <form action="index.php?page=Clientes_Cliente&mode={{~mode}}&clicod={{clicod}}" method="POST" class="col-12 col-m-8 offset-m-2">
        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="clicodD">Código</label>
            <input class="col-12 col-m-9" readonly disabled type="text" name="clicodD" id="clicodD" value="{{clicod}}" />
            <input type="hidden" name="mode" value="{{~mode}}" />
            <input type="hidden" name="clicod" value="{{clicod}}" />
            <input type="hidden" name="cliente_xss_token" value="{{~cliente_xss_token}}" />
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="clinom">Nombre</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="clinom" id="clinom" value="{{clinom}}" />
            {{if clinom_error}}<div class="col-12 col-m-9 offset-m-3 error">{{clinom_error}}</div>{{endif clinom_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="clitel">Teléfono</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="clitel" id="clitel" value="{{clitel}}" />
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="cliemail">Email</label>
            <input class="col-12 col-m-9" {{~readonly}} type="email" name="cliemail" id="cliemail" value="{{cliemail}}" />
            {{if cliemail_error}}<div class="col-12 col-m-9 offset-m-3 error">{{cliemail_error}}</div>{{endif cliemail_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="clidir">Dirección</label>
            <textarea class="col-12 col-m-9" {{~readonly}} name="clidir" id="clidir">{{clidir}}</textarea>
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="cliest">Estado</label>
            <select class="col-12 col-m-9" name="cliest" id="cliest" {{if ~readonly}} disabled {{endif ~readonly}}>
>>>>>>> Stashed changes
                <option value="ACT" {{if cliest_ACT}}selected{{endif cliest_ACT}}>Activo</option>
                <option value="INA" {{if cliest_INA}}selected{{endif cliest_INA}}>Inactivo</option>
                <option value="SUS" {{if cliest_SUS}}selected{{endif cliest_SUS}}>Suspendido</option>
            </select>
        </div>
<<<<<<< Updated upstream

    {{endwith cliente}}

        <!-- BOTONES -->
        <div class="row flex-end">
            {{if showCommitBtn}}
                <button class="primary" type="submit" name="btnConfirmar">Confirmar</button>
            {{endif showCommitBtn}}

            <button type="button" id="btnCancelar">
                {{if showCommitBtn}}Cancelar{{endif showCommitBtn}}
                {{ifnot showCommitBtn}}Regresar{{endifnot showCommitBtn}}
            </button>
        </div>

    </form>
</section>

<!-- SCRIPT -->
<script>
document.addEventListener("DOMContentLoaded", ()=>{
    const btnCancelar = document.getElementById("btnCancelar");
    btnCancelar.addEventListener("click", (e)=>{
        e.preventDefault();
        window.location.assign("index.php?page=Clientes_Clientes");
    });
});
</script>

<!-- ESTILOS -->
<style>
:root {
    --azul: #2f5ea8;
    --azul-suave: #dbeafe;
    --rojo: #c43c3c;
    --rojo-suave: #ffe4e6;
    --negro: #111827;
    --blanco: #ffffff;
}

body {
    background: var(--azul-suave);
    font-family: Arial, sans-serif;
    color: var(--rojo);
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

.cliente-logo-corners {
    pointer-events: none;
}

.cliente-corner-logo {
    border: 3px solid var(--negro);
    border-radius: 8px;
    box-shadow: 6px 6px 0 rgba(17, 24, 39, 0.35);
    height: 110px;
    object-fit: cover;
    opacity: 0.78;
    position: fixed;
    width: 110px;
    z-index: 2;
}

.cliente-corner-logo-br {
    bottom: 72px;
    right: 18px;
}

.cliente-header {
    background: transparent;
    margin-bottom: 0;
    padding-top: 48px;
    position: relative;
    z-index: 1;
}

.cliente-header h1 {
    background: var(--blanco);
    border: 3px solid var(--negro);
    border-left: 10px solid var(--azul);
    border-radius: 8px;
    box-shadow: 8px 8px 0 rgba(17, 24, 39, 0.24);
    text-align: center;
    color: var(--rojo);
    margin: 0 auto;
    max-width: 620px;
    padding: 18px 22px;
    letter-spacing: 0;
    position: relative;
    text-transform: uppercase;
}

.cliente-header h1::before,
.cliente-header h1::after {
    background: var(--rojo-suave);
    border: 2px solid var(--rojo);
    border-radius: 6px;
    color: var(--rojo);
    content: "PLAYER";
    font-size: 12px;
    font-weight: bold;
    padding: 4px 8px;
    position: absolute;
    top: -14px;
}

.cliente-header h1::before {
    left: 18px;
}

.cliente-header h1::after {
    content: "READY";
    right: 18px;
}

.cliente-panel {
    background: transparent;
    position: relative;
    z-index: 1;
}

/* FORM */
.cliente-form {
    background: var(--blanco);
    border: 3px solid var(--negro);
    border-radius: 8px;
    padding: 28px;
    box-shadow: 8px 8px 0 rgba(17, 24, 39, 0.22);
    position: relative;
}

.cliente-form::before {
    content: "";
    display: block;
    height: 6px;
    background: linear-gradient(90deg, var(--rojo), var(--blanco), var(--azul));
    border-radius: 6px;
    margin-bottom: 22px;
}

/* CAMPOS */
.cliente-form label {
    font-weight: bold;
    margin-bottom: 5px;
    display: block;
    color: var(--rojo);
}

.cliente-form input,
.cliente-form textarea,
.cliente-form select {
    padding: 11px 12px;
    border-radius: 6px;
    border: 2px solid var(--negro);
    width: 100%;
    margin-top: 5px;
    background: var(--rojo-suave);
    color: var(--rojo);
    font-weight: bold;
    transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.cliente-form textarea {
    min-height: 95px;
    resize: vertical;
}

.cliente-form input:focus,
.cliente-form textarea:focus,
.cliente-form select:focus {
    border-color: var(--negro);
    box-shadow: 0 0 0 4px rgba(220, 38, 38, 0.28);
    outline: none;
}

.cliente-form input[readonly],
.cliente-form input:disabled,
.cliente-form textarea[readonly],
.cliente-form select:disabled {
    background: var(--rojo-suave);
    color: var(--rojo);
    opacity: 0.75;
}

.cliente-form select option {
    background: var(--blanco);
    color: var(--rojo);
}

/* BOTONES */
.cliente-form button {
    padding: 11px 18px;
    border-radius: 6px;
    border: 2px solid var(--negro);
    cursor: pointer;
    font-weight: bold;
    transition: background 0.2s ease, color 0.2s ease, transform 0.2s ease;
}

.cliente-form button:hover {
    transform: translateY(-1px);
}

.cliente-form button.primary {
    background: var(--azul);
    color: var(--blanco);
}

.cliente-form button.primary:hover {
    background: var(--rojo);
}

.cliente-form button:not(.primary) {
    background: var(--azul);
    color: var(--blanco);
}

.cliente-form button:not(.primary):hover {
    background: var(--rojo);
}

/* ERRORES */
.cliente-form .error {
    color: var(--rojo);
    font-size: 13px;
    font-weight: bold;
    margin-top: 5px;
}

/* LAYOUT */
.cliente-form .row {
    margin-bottom: 15px;
}

.cliente-form .flex-end {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    flex-wrap: wrap;
    margin-bottom: 0;
}

@media (max-width: 640px) {
    .cliente-corner-logo {
        height: 70px;
        width: 70px;
    }

    .cliente-corner-logo-br {
        bottom: 64px;
    }

    .cliente-form {
        padding: 20px;
        box-shadow: 5px 5px 0 rgba(17, 24, 39, 0.24);
    }

    .cliente-form button {
        width: 100%;
    }
}
</style>
=======
    {{endwith cliente}}

        <div class="row my-4 align-center flex-end">
            {{if showCommitBtn}}
            <button class="primary col-12 col-m-2" type="submit" name="btnConfirmar">Confirmar</button>
            &nbsp;
            {{endif showCommitBtn}}
            <button class="col-12 col-m-2" type="button" id="btnCancelar">
                {{if showCommitBtn}} Cancelar {{endif showCommitBtn}}
                {{ifnot showCommitBtn}} Regresar {{endifnot showCommitBtn}}
            </button>
        </div>
    </form>
</section>

<script>
    document.addEventListener("DOMContentLoaded", ()=>{
        const btnCancelar = document.getElementById("btnCancelar");
        btnCancelar.addEventListener("click", (e)=>{
            e.preventDefault();
            e.stopPropagation();
            window.location.assign("index.php?page=Clientes_Clientes");
        });
    });
</script>
>>>>>>> Stashed changes
