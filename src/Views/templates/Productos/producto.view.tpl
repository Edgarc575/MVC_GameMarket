<div class="gm-logo-corner" aria-hidden="true">
    <img src="{{BASE_DIR}}/public/imgs/img.jpeg" alt="">
</div>

<section class="container-m row px-4 py-4 gm-header">
    <h1>{{FormTitle}}</h1>
</section>

<section class="container-m row px-4 py-4 gm-panel">
    {{with producto}}
    <form action="index.php?page=Productos_Producto&mode={{~mode}}&prodcod={{prodcod}}" method="POST" class="col-12 col-m-8 offset-m-2 gm-form">
        <input type="hidden" name="prodcod" value="{{prodcod}}" />
        <input type="hidden" name="producto_xss_token" value="{{~producto_xss_token}}" />

        <div class="row my-2 align-center gm-field">
            <label class="col-12 col-m-3">C&oacute;digo</label>
            <input class="col-12 col-m-9 gm-input" readonly disabled type="text" value="{{prodcod}}" />
        </div>

        <div class="row my-2 align-center gm-field">
            <label class="col-12 col-m-3">Nombre</label>
            <input class="col-12 col-m-9 gm-input" {{~readonly}} type="text" name="prodnom" value="{{prodnom}}" />
            {{if prodnom_error}}<div class="error">{{prodnom_error}}</div>{{endif prodnom_error}}
        </div>

        <div class="row my-2 align-center gm-field">
            <label class="col-12 col-m-3">Descripci&oacute;n</label>
            <input class="col-12 col-m-9 gm-input" {{~readonly}} type="text" name="proddsc" value="{{proddsc}}" />
        </div>

        <div class="row my-2 align-center gm-field">
            <label class="col-12 col-m-3">Precio</label>
            <input class="col-12 col-m-9 gm-input" {{~readonly}} type="number" step="0.01" name="prodprecio" value="{{prodprecio}}" />
            {{if prodprecio_error}}<div class="error">{{prodprecio_error}}</div>{{endif prodprecio_error}}
        </div>

        <div class="row my-2 align-center gm-field">
            <label class="col-12 col-m-3">Stock</label>
            <input class="col-12 col-m-9 gm-input" {{~readonly}} type="number" name="prodstock" value="{{prodstock}}" />
        </div>

        <div class="row my-2 align-center gm-field">
            <label class="col-12 col-m-3">Proveedor (ID opcional)</label>
            <input class="col-12 col-m-9 gm-input" {{~readonly}} type="number" name="provcod" value="{{provcod}}" />
            {{if provcod_error}}<div class="error">{{provcod_error}}</div>{{endif provcod_error}}
        </div>

        <div class="row my-2 align-center gm-field">
            <label class="col-12 col-m-3">Estado</label>
            <select class="col-12 col-m-9 gm-input" name="prodest" {{if ~readonly}}disabled{{endif ~readonly}}>
                <option value="ACT" {{if prodest_ACT}}selected{{endif prodest_ACT}}>Activo</option>
                <option value="INA" {{if prodest_INA}}selected{{endif prodest_INA}}>Inactivo</option>
            </select>
        </div>
    {{endwith producto}}

        <div class="row my-4 align-center flex-end gm-actions">
            {{if showCommitBtn}}<button class="primary gm-btn" type="submit">Confirmar</button>{{endif showCommitBtn}}
            <button class="gm-btn" type="button" onclick="window.location.assign('index.php?page=Productos_Productos')">Regresar</button>
        </div>
    </form>
</section>

<style>
:root{--gm-blue:#2f5ea8;--gm-blue-soft:#dbeafe;--gm-red:#c43c3c;--gm-red-soft:#ffe4e6;--gm-black:#111827;--gm-white:#fff}
body{background:var(--gm-blue-soft);color:var(--gm-red);font-family:Arial,sans-serif}
main{background:linear-gradient(90deg,rgba(47,94,168,.08) 1px,transparent 1px),linear-gradient(rgba(47,94,168,.08) 1px,transparent 1px),linear-gradient(180deg,#edf5ff 0%,#dbeafe 100%);background-size:22px 22px,22px 22px,auto;overflow:hidden;position:relative}
.gm-logo-corner{pointer-events:none}.gm-logo-corner img{border:3px solid var(--gm-black);border-radius:8px;box-shadow:6px 6px 0 rgba(17,24,39,.35);height:110px;object-fit:cover;opacity:.78;position:fixed;right:18px;bottom:72px;width:110px;z-index:2}
.gm-header,.gm-panel{background:transparent;position:relative;z-index:1}.gm-header{padding-top:48px}.gm-header h1{background:var(--gm-white);border:3px solid var(--gm-black);border-left:10px solid var(--gm-blue);border-radius:8px;box-shadow:8px 8px 0 rgba(17,24,39,.24);color:var(--gm-red);letter-spacing:0;margin:0 auto;max-width:620px;padding:18px 22px;position:relative;text-align:center;text-transform:uppercase}
.gm-header h1:before,.gm-header h1:after{background:var(--gm-red-soft);border:2px solid var(--gm-red);border-radius:6px;color:var(--gm-red);font-size:12px;font-weight:bold;padding:4px 8px;position:absolute;top:-14px}.gm-header h1:before{content:"ITEM";left:18px}.gm-header h1:after{content:"LOADOUT";right:18px}
.gm-form{background:var(--gm-white);border:3px solid var(--gm-black);border-radius:8px;box-shadow:8px 8px 0 rgba(17,24,39,.22);padding:28px}.gm-form:before{background:linear-gradient(90deg,var(--gm-red),var(--gm-white),var(--gm-blue));border-radius:6px;content:"";display:block;height:6px;margin-bottom:22px}.gm-field{margin-bottom:18px}.gm-form label{color:var(--gm-red);font-weight:bold}.gm-input{background:var(--gm-red-soft);border:2px solid var(--gm-black);border-radius:6px;color:var(--gm-red);font-weight:bold;min-height:44px;padding:10px 12px}.gm-input:focus{box-shadow:0 0 0 4px rgba(196,60,60,.22);outline:none}.gm-input[readonly],.gm-input:disabled{opacity:.75}.gm-input option{background:var(--gm-white);color:var(--gm-red)}.gm-form .error{color:var(--gm-red);font-size:13px;font-weight:bold;margin-left:25%;margin-top:6px}.gm-actions{display:flex;flex-wrap:wrap;gap:10px;justify-content:flex-end}.gm-btn{background:var(--gm-blue);border:2px solid var(--gm-black);border-radius:6px;color:var(--gm-white);cursor:pointer;font-weight:bold;padding:11px 18px}.gm-btn:hover{background:var(--gm-red);transform:translateY(-1px)}
@media(max-width:640px){.gm-logo-corner img{height:70px;width:70px;bottom:64px}.gm-header h1,.gm-form{box-shadow:5px 5px 0 rgba(17,24,39,.24)}.gm-form{padding:20px}.gm-form .error{margin-left:0}.gm-btn{width:100%}}
</style>
