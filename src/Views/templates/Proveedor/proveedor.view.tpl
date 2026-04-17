<div class="gm-logo-corner" aria-hidden="true">
    <img src="{{BASE_DIR}}/public/imgs/img.jpeg" alt="">
</div>

<section class="container-m row px-4 py-4 gm-header">
    <h1>{{FormTitle}}</h1>
</section>

<section class="container-m row px-4 py-4 gm-panel">
    {{with proveedor}}
    <form action="index.php?page=Proveedores_Proveedor&mode={{~mode}}&provcod={{provcod}}" method="POST" class="col-12 col-m-8 offset-m-2 gm-form">
        <div class="row my-2 align-center gm-field">
            <label class="col-12 col-m-3" for="provcodD">C&oacute;digo</label>
            <input class="col-12 col-m-9 gm-input" readonly disabled type="text" name="provcodD" id="provcodD" value="{{provcod}}" />
            <input type="hidden" name="mode" value="{{~mode}}" />
            <input type="hidden" name="provcod" value="{{provcod}}" />
            <input type="hidden" name="proveedor_xss_token" value="{{~proveedor_xss_token}}" />
        </div>

        <div class="row my-2 align-center gm-field">
            <label class="col-12 col-m-3" for="provnom">Nombre</label>
            <input class="col-12 col-m-9 gm-input" {{~readonly}} type="text" name="provnom" id="provnom" value="{{provnom}}" />
            {{if provnom_error}}<div class="col-12 col-m-9 offset-m-3 error">{{provnom_error}}</div>{{endif provnom_error}}
        </div>

        <div class="row my-2 align-center gm-field">
            <label class="col-12 col-m-3" for="provtel">Tel&eacute;fono</label>
            <input class="col-12 col-m-9 gm-input" {{~readonly}} type="text" name="provtel" id="provtel" value="{{provtel}}" />
        </div>

        <div class="row my-2 align-center gm-field">
            <label class="col-12 col-m-3" for="provemail">Email</label>
            <input class="col-12 col-m-9 gm-input" {{~readonly}} type="email" name="provemail" id="provemail" value="{{provemail}}" />
            {{if provemail_error}}<div class="col-12 col-m-9 offset-m-3 error">{{provemail_error}}</div>{{endif provemail_error}}
        </div>

        <div class="row my-2 align-center gm-field">
            <label class="col-12 col-m-3" for="provdir">Direcci&oacute;n</label>
            <textarea class="col-12 col-m-9 gm-input" {{~readonly}} name="provdir" id="provdir">{{provdir}}</textarea>
        </div>

        <div class="row my-2 align-center gm-field">
            <label class="col-12 col-m-3" for="provest">Estado</label>
            <select class="col-12 col-m-9 gm-input" name="provest" id="provest" {{if ~readonly}} disabled {{endif ~readonly}}>
                <option value="ACT" {{if provest_ACT}}selected{{endif provest_ACT}}>Activo</option>
                <option value="INA" {{if provest_INA}}selected{{endif provest_INA}}>Inactivo</option>
            </select>
        </div>
    {{endwith proveedor}}

        <div class="row my-4 align-center flex-end gm-actions">
            {{if showCommitBtn}}<button class="primary gm-btn" type="submit" name="btnConfirmar">Confirmar</button>{{endif showCommitBtn}}
            <button class="gm-btn" type="button" id="btnCancelar">
                {{if showCommitBtn}}Cancelar{{endif showCommitBtn}}
                {{ifnot showCommitBtn}}Regresar{{endifnot showCommitBtn}}
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
        window.location.assign("index.php?page=Proveedores_Proveedores");
    });
});
</script>

<style>
:root{--gm-blue:#2f5ea8;--gm-blue-soft:#dbeafe;--gm-red:#c43c3c;--gm-red-soft:#ffe4e6;--gm-black:#111827;--gm-white:#fff}
body{background:var(--gm-blue-soft);color:var(--gm-red);font-family:Arial,sans-serif}
main{background:linear-gradient(90deg,rgba(47,94,168,.08) 1px,transparent 1px),linear-gradient(rgba(47,94,168,.08) 1px,transparent 1px),linear-gradient(180deg,#edf5ff 0%,#dbeafe 100%);background-size:22px 22px,22px 22px,auto;overflow:hidden;position:relative}
.gm-logo-corner{pointer-events:none}.gm-logo-corner img{border:3px solid var(--gm-black);border-radius:8px;box-shadow:6px 6px 0 rgba(17,24,39,.35);height:110px;object-fit:cover;opacity:.78;position:fixed;right:18px;bottom:72px;width:110px;z-index:2}
.gm-header,.gm-panel{background:transparent;position:relative;z-index:1}.gm-header{padding-top:48px}.gm-header h1{background:var(--gm-white);border:3px solid var(--gm-black);border-left:10px solid var(--gm-blue);border-radius:8px;box-shadow:8px 8px 0 rgba(17,24,39,.24);color:var(--gm-red);letter-spacing:0;margin:0 auto;max-width:620px;padding:18px 22px;position:relative;text-align:center;text-transform:uppercase}
.gm-header h1:before,.gm-header h1:after{background:var(--gm-red-soft);border:2px solid var(--gm-red);border-radius:6px;color:var(--gm-red);font-size:12px;font-weight:bold;padding:4px 8px;position:absolute;top:-14px}.gm-header h1:before{content:"NPC";left:18px}.gm-header h1:after{content:"SUPPLY";right:18px}
.gm-form{background:var(--gm-white);border:3px solid var(--gm-black);border-radius:8px;box-shadow:8px 8px 0 rgba(17,24,39,.22);padding:28px}.gm-form:before{background:linear-gradient(90deg,var(--gm-red),var(--gm-white),var(--gm-blue));border-radius:6px;content:"";display:block;height:6px;margin-bottom:22px}.gm-field{margin-bottom:18px}.gm-form label{color:var(--gm-red);font-weight:bold}.gm-input{background:var(--gm-red-soft);border:2px solid var(--gm-black);border-radius:6px;color:var(--gm-red);font-weight:bold;min-height:44px;padding:10px 12px}.gm-input:focus{box-shadow:0 0 0 4px rgba(196,60,60,.22);outline:none}.gm-input[readonly],.gm-input:disabled{opacity:.75}.gm-input option{background:var(--gm-white);color:var(--gm-red)}textarea.gm-input{min-height:95px;resize:vertical}.gm-form .error{color:var(--gm-red);font-size:13px;font-weight:bold;margin-top:6px}.gm-actions{display:flex;flex-wrap:wrap;gap:10px;justify-content:flex-end}.gm-btn{background:var(--gm-blue);border:2px solid var(--gm-black);border-radius:6px;color:var(--gm-white);cursor:pointer;font-weight:bold;padding:11px 18px}.gm-btn:hover{background:var(--gm-red);transform:translateY(-1px)}
@media(max-width:640px){.gm-logo-corner img{height:70px;width:70px;bottom:64px}.gm-header h1,.gm-form{box-shadow:5px 5px 0 rgba(17,24,39,.24)}.gm-form{padding:20px}.gm-btn{width:100%}}
</style>
