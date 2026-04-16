<?php

namespace Controllers\Usuarios;

use Controllers\PublicController;
use Dao\Usuarios\Usuarios as UsuariosDao;
use Utilities\Site;
use Utilities\Validators;
use Views\Renderer;

class Usuario extends PublicController
{
    private $viewData = [];
    private $mode = "DSP";
    private $modeDescriptions = [
        "DSP" => "Detalle del Usuario %s %s",
        "INS" => "Nuevo Usuario",
        "UPD" => "Editar Usuario %s %s",
        "DEL" => "Eliminar Usuario %s %s"
    ];
    private $readonly = "";
    private $showCommitBtn = true;
    private $usuario = [
        "usercod" => 0,
        "useremail" => "",
        "username" => "",
        "userpswd" => "",
        "userfching" => "",
        "userpswdest" => "",
        "userpswdexp" => "",
        "userest" => "ACT",
        "useractcod" => "",
        "userpswdchg" => "",
        "usertipo" => ""
    ];
    private $usuario_xss_token = "";

    public function run(): void
    {
        try {
            $this->getData();
            if ($this->isPostBack()) {
                if ($this->validateData()) {
                    $this->handlePostAction();
                }
            }
            $this->setViewData();
            Renderer::render("Usuarios/usuario", $this->viewData);
        } catch (\Exception $ex) {
            Site::redirectToWithMsg(
                "index.php?page=Usuarios_Usuarios",
                $ex->getMessage()
            );
        }
    }

    private function getData()
    {
        $this->mode = $_GET["mode"] ?? "NOF";
        if (isset($this->modeDescriptions[$this->mode])) {
            $this->readonly = ($this->mode === "DEL" || $this->mode === "DSP") ? "readonly" : "";
            $this->showCommitBtn = $this->mode !== "DSP";
            if ($this->mode !== "INS") {
                $this->usuario = UsuariosDao::getUsuarioById(intval($_GET["usercod"] ?? 0));
                if (!$this->usuario) {
                    throw new \Exception("No se encontro el Usuario", 1);
                }
            }
        } else {
            throw new \Exception("Formulario cargado en modalidad invalida", 1);
        }
    }

    private function validateData()
    {
        $errors = [];
        $this->usuario_xss_token = $_POST["usuario_xss_token"] ?? "";

        $this->usuario["usercod"] = intval($_POST["usercod"] ?? 0);
        $this->usuario["useremail"] = strval($_POST["useremail"] ?? "");
        $this->usuario["username"] = strval($_POST["username"] ?? "");
        $this->usuario["userpswd"] = strval($_POST["userpswd"] ?? "");
        $this->usuario["userfching"] = strval($_POST["userfching"] ?? "");
        $this->usuario["userpswdest"] = strval($_POST["userpswdest"] ?? "");
        $this->usuario["userpswdexp"] = strval($_POST["userpswdexp"] ?? "");
        $this->usuario["userest"] = strval($_POST["userest"] ?? "");
        $this->usuario["useractcod"] = strval($_POST["useractcod"] ?? "");
        $this->usuario["userpswdchg"] = strval($_POST["userpswdchg"] ?? "");
        $this->usuario["usertipo"] = strval($_POST["usertipo"] ?? "");

        if (Validators::IsEmpty($this->usuario["useremail"])) {
            $errors["useremail_error"] = "El correo es requerido";
        } elseif (!Validators::IsValidEmail($this->usuario["useremail"])) {
            $errors["useremail_error"] = "Correo electronico no es valido";
        }

        if (Validators::IsEmpty($this->usuario["username"])) {
            $errors["username_error"] = "El nombre de usuario es requerido";
        }
        if (Validators::IsEmpty($this->usuario["userpswd"])) {
            $errors["userpswd_error"] = "La contrasenha es requerida";
        }
        if (Validators::IsEmpty($this->usuario["userfching"])) {
            $errors["userfching_error"] = "La fecha de ingreso es requerida";
        }
        if (Validators::IsEmpty($this->usuario["userpswdest"])) {
            $errors["userpswdest_error"] = "El estado de contrasenha es requerido";
        }
        if (Validators::IsEmpty($this->usuario["userpswdexp"])) {
            $errors["userpswdexp_error"] = "La fecha de expiracion de contrasenha es requerida";
        }
        if (Validators::IsEmpty($this->usuario["userest"])) {
            $errors["userest_error"] = "El estado de usuario es requerido";
        }
        if (Validators::IsEmpty($this->usuario["useractcod"])) {
            $errors["useractcod_error"] = "El codigo de activacion es requerido";
        }
        if (Validators::IsEmpty($this->usuario["userpswdchg"])) {
            $errors["userpswdchg_error"] = "La referencia de cambio de contrasenha es requerida";
        }
        if (Validators::IsEmpty($this->usuario["usertipo"])) {
            $errors["usertipo_error"] = "El tipo de usuario es requerido";
        }

        if (count($errors) > 0) {
            foreach ($errors as $key => $value) {
                $this->usuario[$key] = $value;
            }
            return false;
        }
        return true;
    }

    private function handlePostAction()
    {
        switch ($this->mode) {
            case "INS":
                $result = UsuariosDao::insertUsuario(
                    $this->usuario["useremail"],
                    $this->usuario["username"],
                    $this->usuario["userpswd"],
                    $this->usuario["userfching"],
                    $this->usuario["userpswdest"],
                    $this->usuario["userpswdexp"],
                    $this->usuario["userest"],
                    $this->usuario["useractcod"],
                    $this->usuario["userpswdchg"],
                    $this->usuario["usertipo"]
                );
                if ($result > 0) {
                    Site::redirectToWithMsg("index.php?page=Usuarios_Usuarios", "Usuario creado exitosamente");
                }
                break;
            case "UPD":
                $result = UsuariosDao::updateUsuario(
                    $this->usuario["usercod"],
                    $this->usuario["useremail"],
                    $this->usuario["username"],
                    $this->usuario["userpswd"],
                    $this->usuario["userfching"],
                    $this->usuario["userpswdest"],
                    $this->usuario["userpswdexp"],
                    $this->usuario["userest"],
                    $this->usuario["useractcod"],
                    $this->usuario["userpswdchg"],
                    $this->usuario["usertipo"]
                );
                if ($result > 0) {
                    Site::redirectToWithMsg("index.php?page=Usuarios_Usuarios", "Usuario actualizado exitosamente");
                }
                break;
            case "DEL":
                $result = UsuariosDao::deleteUsuario($this->usuario["usercod"]);
                if ($result > 0) {
                    Site::redirectToWithMsg("index.php?page=Usuarios_Usuarios", "Usuario eliminado exitosamente");
                }
                break;
        }
    }

    private function setViewData(): void
    {
        $this->viewData["mode"] = $this->mode;
        $this->viewData["usuario_xss_token"] = $this->usuario_xss_token;
        $this->viewData["FormTitle"] = sprintf(
            $this->modeDescriptions[$this->mode],
            $this->usuario["usercod"],
            $this->usuario["useremail"]
        );
        $this->viewData["showCommitBtn"] = $this->showCommitBtn;
        $this->viewData["readonly"] = $this->readonly;
        $this->viewData["usuario"] = $this->usuario;
    }
}
