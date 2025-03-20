<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Plan de Estudio - Abogacía</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f8f9fa;
      margin: 0;
      padding: 0;
      overflow-x: auto; /* Scroll horizontal */
    }
    h1 {
      text-align: center;
      padding: 20px;
      background: #007bff;
      color: white;
      margin: 0;
      width: 100%; /* Extender el título por toda la página */
    }
    .contenedor-semestres {
      display: flex;
      flex-wrap: nowrap;
      padding: 20px;
      gap: 20px;
    }
    .semestre {
      display: flex;
      flex-direction: column;
      gap: 10px;
    }
    .materia {
      padding: 15px;
      border: 1px solid #ccc;
      border-radius: 5px;
      background: white;
      min-width: 200px; /* Ancho mínimo para cada materia */
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      position: relative;
    }
    .materia.aprobado { background-color: #d4edda; color: #155724; } /* Verde claro */
    .materia.en-curso { background-color: #fff3cd; color: #856404; } /* Amarillo claro */
    .materia.sin-hacer { background-color: #f8d7da; color: #721c24; } /* Rojo claro */
    .boton-correlativas, .boton-cambiar-estado {
      display: block;
      margin-top: 10px;
      padding: 5px 10px;
      background: #007bff;
      color: white;
      border: none;
      border-radius: 3px;
      cursor: pointer;
    }
    .boton-correlativas:hover, .boton-cambiar-estado:hover {
      background: #0056b3;
    }
    .correlativas {
      margin-top: 10px;
      padding: 10px;
      background: #f1f1f1;
      border-radius: 5px;
      display: none; /* Oculto por defecto */
      color: black; /* Texto en negro */
    }
    .correlativas.mostrar {
      display: block; /* Mostrar cuando se hace clic */
    }
  </style>
</head>
<body>
  <h1>Plan de Estudio - Abogacía</h1>
  <div class="contenedor-semestres" id="contenedor-semestres"></div>

  <script>
    // Datos de las materias y sus correlativas
    const materias = [
      { id: "contenidos transversales para la construcción de la ciudadanía", semestre: 1, correlativas: [], estado: "sin hacer" },
      { id: "Historia del Pensamiento Político y Jurídico", semestre: 1, correlativas: [], estado: "sin hacer" },
      { id: "destrezas I: interpretacion y escritura juridica basica", semestre: 1, correlativas: [], estado: "sin hacer" },
      { id: "Teoría del Derecho y la Justicia", semestre: 2, correlativas: [], estado: "sin hacer" },
      { id: "nociones de economia", semestre: 2, correlativas: [], estado: "sin hacer" },
      { id: "Teoría del Estado", semestre: 2, correlativas: [], estado: "sin hacer" },
      { id: "logica", semestre: 3, correlativas: ["contenidos transversales para la construcción de la ciudadanía", "Historia del Pensamiento Político y Jurídico", "Teoría del Derecho y la Justicia"], estado: "sin hacer" },
      { id: "Derecho privado", semestre: 3, correlativas: ["contenidos transversales para la construcción de la ciudadanía", "Historia del Pensamiento Político y Jurídico", "Teoría del Derecho y la Justicia"], estado: "sin hacer" },
      { id: "derecho constitucional", semestre: 3, correlativas: ["contenidos transversales para la construcción de la ciudadanía", "Historia del Pensamiento Político y Jurídico", "Teoría del Estado", "Teoría del Derecho y la Justicia"], estado: "sin hacer" },
      { id: "nociones de sociologia", semestre: 4, correlativas: ["contenidos transversales para la construcción de la ciudadanía", "Historia del Pensamiento Político y Jurídico", "Teoría del Estado"], estado: "sin hacer" },
      { id: "obligaciones civiles y comerciales", semestre: 4, correlativas: ["Derecho privado"], estado: "sin hacer" },
      { id: "derecho penal I", semestre: 4, correlativas: ["derecho constitucional"], estado: "sin hacer" },
      { id: "contratos", semestre: 5, correlativas: ["obligaciones civiles y comerciales"], estado: "sin hacer" },
      { id: "derecho penal II", semestre: 5, correlativas: ["derecho penal I"], estado: "sin hacer" },
      { id: "derecho de la empresa y los negocios", semestre: 6, correlativas: ["contratos"], estado: "sin hacer" },
      { id: "derecho procesal I", semestre: 6, correlativas: ["derecho constitucional", "derecho penal II", "Derecho privado"], estado: "sin hacer" },
      { id: "derechos humanos", semestre: 6, correlativas: ["derecho constitucional"], estado: "sin hacer" },
      { id: "destrezas II: argumentacion oral y escrita", semestre: 6, correlativas: ["destrezas I: interpretacion y escritura juridica basica", "logica", "nociones de sociologia"], estado: "sin hacer" },
      { id: "derecho ambiental", semestre: 7, correlativas: ["derecho constitucional", "contratos"], estado: "sin hacer" },
      { id: "derecho societario y derecho cambiario", semestre: 7, correlativas: ["derecho de la empresa y los negocios"], estado: "sin hacer" },
      { id: "derecho procesal II", semestre: 7, correlativas: ["derecho procesal I", "obligaciones civiles y comerciales"], estado: "sin hacer" },
      { id: "derecho del trabajo y derecho de la seguridad social", semestre: 8, correlativas: ["derecho constitucional", "contratos"], estado: "sin hacer" },
      { id: "Derecho reales", semestre: 8, correlativas: ["derecho constitucional", "contratos"], estado: "sin hacer" },
      { id: "derecho del consumidor", semestre: 8, correlativas: ["derecho constitucional", "contratos"], estado: "sin hacer" },
      { id: "destrezas III: investigacion juridica", semestre: 8, correlativas: ["destrezas II: argumentacion oral y escrita", "obligaciones civiles y comerciales", "derecho penal I"], estado: "sin hacer" },
      { id: "Derecho de la familia y de las sucesiones", semestre: 9, correlativas: ["derecho procesal I"], estado: "sin hacer" },
      { id: "derecho del transporte", semestre: 9, correlativas: ["derecho de la empresa y los negocios"], estado: "sin hacer" },
      { id: "filosofia del derecho", semestre: 9, correlativas: ["derechos humanos", "nociones de sociologia"], estado: "sin hacer" },
      { id: "concursos y privilegios", semestre: 10, correlativas: ["derecho societario y derecho cambiario", "derecho procesal II"], estado: "sin hacer" },
      { id: "derecho administrativo", semestre: 10, correlativas: ["Derecho reales", "derecho procesal II"], estado: "sin hacer" },
      { id: "destrezas IV: habilidades para el litigio", semestre: 10, correlativas: ["destrezas III: investigacion juridica", "derecho procesal I", "contratos"], estado: "sin hacer" },
      { id: "derecho tributario y derecho financiero", semestre: 11, correlativas: ["derecho administrativo"], estado: "sin hacer" },
      { id: "derecho internacional publico y politica exterior", semestre: 11, correlativas: ["derechos humanos"], estado: "sin hacer" },
      { id: "derecho internacional privado", semestre: 12, correlativas: ["concursos y privilegios", "Derecho de la familia y de las sucesiones"], estado: "sin hacer" },
      { id: "destrezas V: práctica profesional aplicada", semestre: 12, correlativas: ["destrezas IV: habilidades para el litigio", "Derecho de la familia y de las sucesiones", "derecho procesal II"], estado: "sin hacer" },
    ];

    // Cargar el estado de las materias desde localStorage
    function cargarEstadoMaterias() {
      const estadoGuardado = localStorage.getItem("estadoMaterias");
      if (estadoGuardado) {
        const estadoMaterias = JSON.parse(estadoGuardado);
        materias.forEach(materia => {
          if (estadoMaterias[materia.id]) {
            materia.estado = estadoMaterias[materia.id];
          }
        });
      }
    }

    // Guardar el estado de las materias en localStorage
    function guardarEstadoMaterias() {
      const estadoMaterias = {};
      materias.forEach(materia => {
        estadoMaterias[materia.id] = materia.estado;
      });
      localStorage.setItem("estadoMaterias", JSON.stringify(estadoMaterias));
    }

    // Función para cambiar el estado de una materia
    function cambiarEstado(materia) {
      const estados = ["sin hacer", "en curso", "aprobado"];
      const indiceActual = estados.indexOf(materia.estado);
      const nuevoIndice = (indiceActual + 1) % estados.length;
      materia.estado = estados[nuevoIndice];
      guardarEstadoMaterias();
      renderizarMaterias();
    }

    // Función para renderizar las materias
    function renderizarMaterias() {
      const contenedorSemestres = document.getElementById("contenedor-semestres");
      contenedorSemestres.innerHTML = ""; // Limpiar el contenedor

      // Agrupar materias por semestre
      const materiasPorSemestre = {};
      materias.forEach(materia => {
        if (!materiasPorSemestre[materia.semestre]) {
          materiasPorSemestre[materia.semestre] = [];
        }
        materiasPorSemestre[materia.semestre].push(materia);
      });

      // Renderizar cada semestre
      Object.keys(materiasPorSemestre).forEach(semestre => {
        const divSemestre = document.createElement("div");
        divSemestre.className = "semestre";
        divSemestre.innerHTML = `<h2>Semestre ${semestre}</h2>`;

        materiasPorSemestre[semestre].forEach(materia => {
          const divMateria = document.createElement("div");
          divMateria.className = `materia ${materia.estado.replace(" ", "-")}`;
          divMateria.innerHTML = `
            <div>${materia.id}</div>
            <button class="boton-correlativas">Ver correlativas</button>
            <button class="boton-cambiar-estado">Cambiar estado</button>
            <div class="correlativas"></div>
          `;

          // Mostrar correlativas al hacer clic en el botón
          const botonCorrelativas = divMateria.querySelector(".boton-correlativas");
          const divCorrelativas = divMateria.querySelector(".correlativas");

          botonCorrelativas.addEventListener("click", () => {
            mostrarCorrelativas(materia, divCorrelativas);
          });

          // Cambiar estado al hacer clic en el botón
          const botonCambiarEstado = divMateria.querySelector(".boton-cambiar-estado");
          botonCambiarEstado.addEventListener("click", () => {
            cambiarEstado(materia);
          });

          divSemestre.appendChild(divMateria);
        });

        contenedorSemestres.appendChild(divSemestre);
      });
    }

    // Función para mostrar las correlativas de una materia
    function mostrarCorrelativas(materia, divCorrelativas) {
      const correlativas = materia.correlativas;
      divCorrelativas.innerHTML = ""; // Limpiar correlativas anteriores

      if (correlativas.length > 0) {
        correlativas.forEach(correlativaId => {
          const correlativa = materias.find(m => m.id === correlativaId);
          const divCorrelativa = document.createElement("div");
          divCorrelativa.textContent = correlativa.id;
          divCorrelativas.appendChild(divCorrelativa);
        });
        divCorrelativas.classList.toggle("mostrar"); // Mostrar/ocultar correlativas
      }
    }

    // Cargar el estado de las materias al inicio
    cargarEstadoMaterias();

    // Renderizar las materias al cargar la página
    renderizarMaterias();

    // Guardar el estado de las materias al cambiar
    window.addEventListener("beforeunload", guardarEstadoMaterias);
  </script>
</body>
</html>
