<section class="container-m row px-4 py-4">
    <h1>{{FormTitle}}</h1>
</section>
<section class="container-m row px-4 py-4">
    {{with usuario}}
    <form action="index.php?page=Usuarios_Usuario&mode={{~mode}}&usercod={{usercod}}" method="POST" class="col-12 col-m-8 offset-m-2">
        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="usercodD">Codigo Usuario</label>
            <input class="col-12 col-m-9" readonly disabled type="text" name="usercodD" id="usercodD" value="{{usercod}}" />
            <input type="hidden" name="mode" value="{{~mode}}" />
            <input type="hidden" name="usercod" value="{{usercod}}" />
            <input type="hidden" name="usuario_xss_token" value="{{~usuario_xss_token}}" />
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="useremail">Correo Usuario</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="useremail" id="useremail" value="{{useremail}}" />
            {{if useremail_error}}<div class="col-12 col-m-9 offset-m-3 error">{{useremail_error}}</div>{{endif useremail_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="username">Nombre Usuario</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="username" id="username" value="{{username}}" />
            {{if username_error}}<div class="col-12 col-m-9 offset-m-3 error">{{username_error}}</div>{{endif username_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="userpswd">Contrasenha</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="userpswd" id="userpswd" value="{{userpswd}}" />
            {{if userpswd_error}}<div class="col-12 col-m-9 offset-m-3 error">{{userpswd_error}}</div>{{endif userpswd_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="userfching">Fecha Ingreso</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="userfching" id="userfching" value="{{userfching}}" />
            {{if userfching_error}}<div class="col-12 col-m-9 offset-m-3 error">{{userfching_error}}</div>{{endif userfching_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="userpswdest">Estado Contrasenha</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="userpswdest" id="userpswdest" value="{{userpswdest}}" />
            {{if userpswdest_error}}<div class="col-12 col-m-9 offset-m-3 error">{{userpswdest_error}}</div>{{endif userpswdest_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="userpswdexp">Fecha Expiracion</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="userpswdexp" id="userpswdexp" value="{{userpswdexp}}" />
            {{if userpswdexp_error}}<div class="col-12 col-m-9 offset-m-3 error">{{userpswdexp_error}}</div>{{endif userpswdexp_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="userest">Estado Usuario</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="userest" id="userest" value="{{userest}}" />
            {{if userest_error}}<div class="col-12 col-m-9 offset-m-3 error">{{userest_error}}</div>{{endif userest_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="useractcod">Codigo Activacion</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="useractcod" id="useractcod" value="{{useractcod}}" />
            {{if useractcod_error}}<div class="col-12 col-m-9 offset-m-3 error">{{useractcod_error}}</div>{{endif useractcod_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="userpswdchg">Cambio Contrasenha</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="userpswdchg" id="userpswdchg" value="{{userpswdchg}}" />
            {{if userpswdchg_error}}<div class="col-12 col-m-9 offset-m-3 error">{{userpswdchg_error}}</div>{{endif userpswdchg_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="usertipo">Tipo Usuario</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="usertipo" id="usertipo" value="{{usertipo}}" />
            {{if usertipo_error}}<div class="col-12 col-m-9 offset-m-3 error">{{usertipo_error}}</div>{{endif usertipo_error}}
        </div>

    {{endwith usuario}}

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
    document.addEventListener("DOMContentLoaded", () => {
        const btnCancelar = document.getElementById("btnCancelar");
        btnCancelar.addEventListener("click", (e) => {
            e.preventDefault();
            e.stopPropagation();
            window.location.assign("index.php?page=Usuarios_Usuarios");
        });
    });
</script>
