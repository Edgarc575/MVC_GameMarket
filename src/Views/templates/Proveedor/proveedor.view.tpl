<section class="container-m row px-4 py-4">
    <h1>{{FormTitle}}</h1>
</section>
<section class="container-m row px-4 py-4">
    {{with proveedor}}
    <form action="index.php?page=Proveedores_Proveedor&mode={{~mode}}&provcod={{provcod}}" method="POST" class="col-12 col-m-8 offset-m-2">
        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="provcodD">Código</label>
            <input class="col-12 col-m-9" readonly disabled type="text" name="provcodD" id="provcodD" value="{{provcod}}" />
            <input type="hidden" name="mode" value="{{~mode}}" />
            <input type="hidden" name="provcod" value="{{provcod}}" />
            <input type="hidden" name="proveedor_xss_token" value="{{~proveedor_xss_token}}" />
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="provnom">Nombre</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="provnom" id="provnom" value="{{provnom}}" />
            {{if provnom_error}}<div class="col-12 col-m-9 offset-m-3 error">{{provnom_error}}</div>{{endif provnom_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="provtel">Teléfono</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="provtel" id="provtel" value="{{provtel}}" />
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="provemail">Email</label>
            <input class="col-12 col-m-9" {{~readonly}} type="email" name="provemail" id="provemail" value="{{provemail}}" />
            {{if provemail_error}}<div class="col-12 col-m-9 offset-m-3 error">{{provemail_error}}</div>{{endif provemail_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="provdir">Dirección</label>
            <textarea class="col-12 col-m-9" {{~readonly}} name="provdir" id="provdir">{{provdir}}</textarea>
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="provest">Estado</label>
            <select class="col-12 col-m-9" name="provest" id="provest" {{if ~readonly}} disabled {{endif ~readonly}}>
                <option value="ACT" {{if provest_ACT}}selected{{endif provest_ACT}}>Activo</option>
                <option value="INA" {{if provest_INA}}selected{{endif provest_INA}}>Inactivo</option>
            </select>
        </div>
    {{endwith proveedor}}

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
            window.location.assign("index.php?page=Proveedores_Proveedores");
        });
    });
</script>