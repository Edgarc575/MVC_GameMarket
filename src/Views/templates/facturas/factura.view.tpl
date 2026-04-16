<section class="container-m row px-4 py-4 factura-header">
    <h1>{{FormTitle}}</h1>
</section>

<section class="container-m row px-4 py-4 factura-panel">
    {{with factura}}
    <form action="index.php?page=Facturas_Factura&mode={{~mode}}&factcod={{factcod}}" method="POST" class="col-12 col-m-8 offset-m-2 factura-form">
        <input type="hidden" name="factcod" value="{{factcod}}" />

        <div class="row my-2 align-center factura-field">
            <label class="col-12 col-m-3">N&deg; Factura</label>
            <input class="col-12 col-m-9 factura-input" readonly disabled type="text" value="{{factcod}}" />
        </div>

        <div class="row my-2 align-center factura-field">
            <label class="col-12 col-m-3">Cliente (ID)</label>
            <input class="col-12 col-m-9 factura-input" {{~readonly}} type="number" name="clicod" value="{{clicod}}" />
            {{if clicod_error}}<div class="error">{{clicod_error}}</div>{{endif clicod_error}}
        </div>

        <div class="row my-2 align-center factura-field">
            <label class="col-12 col-m-3">Vendedor (ID)</label>
            <input class="col-12 col-m-9 factura-input" {{~readonly}} type="number" name="usercod" value="{{usercod}}" />
        </div>

        <div class="row my-2 align-center factura-field">
            <label class="col-12 col-m-3">Fecha</label>
            <input class="col-12 col-m-9 factura-input" {{~readonly}} type="datetime-local" name="factfecha" value="{{factfecha}}" />
        </div>

        <div class="row my-2 align-center factura-field">
            <label class="col-12 col-m-3">Total</label>
            <input class="col-12 col-m-9 factura-input" {{~readonly}} type="number" step="0.01" name="facttotal" value="{{facttotal}}" />
            {{if facttotal_error}}<div class="error">{{facttotal_error}}</div>{{endif facttotal_error}}
        </div>

        <div class="row my-2 align-center factura-field">
            <label class="col-12 col-m-3">Estado</label>
            <select class="col-12 col-m-9 factura-input" name="factest" {{if ~readonly}}disabled{{endif ~readonly}}>
                <option value="PEN" {{if factest_PEN}}selected{{endif factest_PEN}}>Pendiente</option>
                <option value="PAG" {{if factest_PAG}}selected{{endif factest_PAG}}>Pagada</option>
                <option value="CAN" {{if factest_CAN}}selected{{endif factest_CAN}}>Cancelada</option>
            </select>
        </div>
    {{endwith factura}}

        <div class="row my-4 align-center flex-end factura-actions">
            {{if showCommitBtn}}<button class="primary factura-btn" type="submit">Confirmar</button>{{endif showCommitBtn}}
            <button class="factura-btn" type="button" onclick="window.location.assign('index.php?page=Facturas_Facturas')">Regresar</button>
        </div>
    </form>
</section>

<style>
:root {
    --factura-azul: #1e3a8a;
    --factura-rojo: #dc2626;
    --factura-negro: #050505;
    --factura-blanco: #ffffff;
}

body {
    background: var(--factura-azul);
    color: var(--factura-rojo);
    font-family: Arial, sans-serif;
}

.factura-header,
.factura-panel {
    background: var(--factura-azul);
}

.factura-header {
    padding-top: 48px;
}

.factura-header h1 {
    background: var(--factura-blanco);
    border: 3px solid var(--factura-negro);
    border-left: 10px solid var(--factura-rojo);
    border-radius: 8px;
    box-shadow: 8px 8px 0 var(--factura-negro);
    color: var(--factura-rojo);
    letter-spacing: 0;
    margin: 0 auto;
    max-width: 620px;
    padding: 18px 22px;
    text-align: center;
}

.factura-form {
    background: var(--factura-blanco);
    border: 3px solid var(--factura-negro);
    border-radius: 8px;
    box-shadow: 8px 8px 0 var(--factura-negro);
    color: var(--factura-rojo);
    padding: 28px;
}

.factura-form::before {
    background: linear-gradient(90deg, var(--factura-rojo), var(--factura-azul), var(--factura-negro));
    border-radius: 6px;
    content: "";
    display: block;
    height: 7px;
    margin-bottom: 24px;
}

.factura-field {
    margin-bottom: 18px;
}

.factura-form label {
    color: var(--factura-rojo);
    font-weight: bold;
}

.factura-input {
    background: var(--factura-rojo);
    border: 2px solid var(--factura-negro);
    border-radius: 6px;
    color: var(--factura-blanco);
    font-weight: bold;
    min-height: 44px;
    padding: 10px 12px;
}

.factura-input:focus {
    box-shadow: 0 0 0 4px rgba(220, 38, 38, 0.28);
    outline: none;
}

.factura-input[readonly],
.factura-input:disabled {
    background: var(--factura-rojo);
    color: var(--factura-blanco);
    opacity: 0.75;
}

.factura-input option {
    background: var(--factura-blanco);
    color: var(--factura-rojo);
}

.factura-form .error {
    color: var(--factura-rojo);
    font-size: 13px;
    font-weight: bold;
    margin-left: 25%;
    margin-top: 6px;
}

.factura-actions {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    justify-content: flex-end;
    margin-bottom: 0;
}

.factura-btn {
    background: var(--factura-azul);
    border: 2px solid var(--factura-negro);
    border-radius: 6px;
    color: var(--factura-blanco);
    cursor: pointer;
    font-weight: bold;
    padding: 11px 18px;
    transition: background 0.2s ease, transform 0.2s ease;
}

.factura-btn:hover {
    background: var(--factura-negro);
    transform: translateY(-1px);
}

@media (max-width: 640px) {
    .factura-header h1,
    .factura-form {
        box-shadow: 5px 5px 0 var(--factura-negro);
    }

    .factura-form {
        padding: 20px;
    }

    .factura-form .error {
        margin-left: 0;
    }

    .factura-btn {
        width: 100%;
    }
}
</style>
