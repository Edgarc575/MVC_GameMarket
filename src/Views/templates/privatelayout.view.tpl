<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{SITE_TITLE}}</title>
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="{{BASE_DIR}}/public/css/appstyle.css" />
  {{if FONT_AWESOME_KIT}}
  <script src="https://kit.fontawesome.com/{{FONT_AWESOME_KIT}}.js" crossorigin="anonymous"></script>
  {{endif FONT_AWESOME_KIT}}
  {{foreach SiteLinks}}
  <link rel="stylesheet" href="{{~BASE_DIR}}/{{this}}" />
  {{endfor SiteLinks}}
  {{foreach BeginScripts}}
  <script src="{{~BASE_DIR}}/{{this}}"></script>
  {{endfor BeginScripts}}

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
      margin: 0;
      padding: 0;
      font-family: 'Roboto', sans-serif;
      background-color: var(--azul-suave);
      overflow-x: hidden;
      color: var(--negro);
    }

    header {
      background: var(--azul);
      border-bottom: 4px solid var(--negro);
      padding: 1rem;
      display: flex;
      align-items: center;
      justify-content: space-between;
      position: sticky;
      top: 0;
      z-index: 1000;
    }

    .header-left {
      display: flex;
      align-items: center;
    }

    header h1 {
      color: var(--blanco);
      font-size: 1.2rem;
      margin: 0 0 0 15px;
      text-transform: uppercase;
      text-shadow: 2px 2px 0 var(--negro);
      font-weight: bold;
    }

    .username {
      color: var(--blanco);
      font-weight: bold;
      font-size: 0.9rem;
      text-transform: uppercase;
      background: rgba(0, 0, 0, 0.2);
      padding: 5px 12px;
      border-radius: 4px;
      border: 1px solid var(--negro);
    }

    .username a {
      color: var(--blanco);
      margin-left: 8px;
      text-decoration: none;
    }

    .menu_toggle_icon {
      cursor: pointer;
      width: 30px;
      height: 25px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      z-index: 1100;
    }

    .hmb {
      height: 5px;
      width: 100%;
      background: var(--blanco);
      border: 1.5px solid var(--negro);
      border-radius: 1px;
      transition: 0.3s;
    }

    #menu {
      position: fixed;
      top: 0;
      left: -300px;
      width: 280px;
      height: 100vh;
      background: var(--blanco);
      border-right: 5px solid var(--negro);
      box-shadow: 10px 0 0 rgba(17, 24, 39, 0.15);
      transition: left 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      z-index: 1050;
      padding-top: 80px;
    }

    .menu_toggle {
      display: none;
    }

    .menu_toggle:checked ~ #menu {
      left: 0;
    }

    #menu ul {
      list-style: none;
      padding: 0;
      margin: 0;
    }

    #menu ul li a {
      display: block;
      padding: 15px 25px;
      color: var(--negro) !important;
      text-decoration: none;
      font-weight: bold;
      text-transform: uppercase;
      border-bottom: 2px solid var(--azul-suave);
      transition: all 0.2s;
      font-size: 14px;
      background-color: var(--blanco);
    }

    #menu ul li a:hover {
      background: var(--rojo-suave) !important;
      color: var(--rojo) !important;
      padding-left: 35px;
      border-left: 8px solid var(--rojo);
    }

    main {
      background:
        linear-gradient(90deg, rgba(47, 94, 168, 0.08) 1px, transparent 1px),
        linear-gradient(rgba(47, 94, 168, 0.08) 1px, transparent 1px),
        linear-gradient(180deg, #edf5ff 0%, #dbeafe 100%);
      background-size: 22px 22px, 22px 22px, auto;
      min-height: calc(100vh - 120px);
      padding: 20px;
    }

    footer {
      background: var(--negro);
      color: var(--blanco);
      text-align: center;
      padding: 1.5rem;
      border-top: 4px solid var(--rojo);
      font-size: 0.8rem;
      font-weight: bold;
    }
  </style>
</head>

<body>
  <header>
    <input type="checkbox" class="menu_toggle" id="menu_toggle" />
    
    <div class="header-left">
      <label for="menu_toggle" class="menu_toggle_icon">
        <div class="hmb"></div>
        <div class="hmb"></div>
        <div class="hmb"></div>
      </label>
      <h1>{{SITE_TITLE}}</h1>
    </div>

    <nav id="menu">
      <ul>
        <li><a href="index.php?page={{PRIVATE_DEFAULT_CONTROLLER}}"><i class="fas fa-home"></i>&nbsp;Inicio</a></li>
        {{foreach NAVIGATION}}
        <li><a href="{{nav_url}}">{{nav_label}}</a></li>
        {{endfor NAVIGATION}}
        <li><a href="index.php?page=sec_logout"><i class="fas fa-sign-out-alt"></i>&nbsp;Salir</a></li>
      </ul>
    </nav>

    {{with login}}
    <span class="username">{{userName}} <a href="index.php?page=sec_logout"><i class="fas fa-sign-out-alt"></i></a></span>
    {{endwith login}}
  </header>

  <main>
    {{{page_content}}}
  </main>

  <footer>
    <div>Todo los Derechos Reservados {{~CURRENT_YEAR}} &copy;</div>
  </footer>

  {{foreach EndScripts}}
  <script src="{{~BASE_DIR}}/{{this}}"></script>
  {{endfor EndScripts}}
</body>

</html>