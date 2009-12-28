/**
 * Clase para poder manejar el formulario de Sinonimos
 * utilizan la variable estado.area para lectura solamente (llenado de formulario, etc)
 */
FormularioSinonimos = function() {
    this.init();
}

FormularioSinonimos.prototype = {
    /**
     * Cuenta la cantidad de grupos de sinonimos (no tiene un uso actual)
     */
    'contador': 0,
    /**
     * Constructor
     */
    'init': function() {
        var form = this;
        //crea el formulario
        $("#formulario-sinonimos").dialog({
            'close': function(e, ui) {
                $("#formulario-sinonimos").trigger("cerrar");
            },
            'width': 600, 
            'height': 400, 
            'resizable': false, 
            'modal': true, 
            'autoOpen': false,
            'title': 'Sinónimos'
        });
        // crea los eventos
        this.crearEventos();
        // lista los sinonimos AJAX
        this.listarSinonimos();
        // caargar el formulario AJAX
        this.cargarFormularioSinonimos()
    },
    /**
     * Creacion de eventos
     */
    'crearEventos': function() {
        var form = this;
        //para mostrar el formulario
        $('#formulario-sinonimos').bind("mostrar", function() {
            //carga los datos del area
            form.cargarDatos();
            //muestra el formulario
            $("#formulario-sinonimos").dialog("open");
            // si no tiene elementos abre el formulario_sinonimos_crear
            var total = 0;
            for (var k in estado.area.encabezado['sinonimos']) {
                total++;
                break;
            }
            if (total == 0) {
                $('#formulario-sinonimos-crear').trigger("mostrar");
            }
        });
        // adiciona un grupo
        $('#formulario-sinonimos').bind("adicionar", function(e) {
            form.adicionarGrupoSinonimo();
        });
        // modifica un grupo
        $('#formulario-sinonimos').bind("modificar", function(e, nombreGrupoAnterior) {
            form.modificarGrupoSinonimo(nombreGrupoAnterior);
        });
        //muestra el formulario de adicion
        $('#formulario-sinonimos a.crear-sinonimos').live("click", function() {
            $('#formulario-sinonimos-crear').trigger("mostrar");
        });
        // borrado de sinonimos
        $('#formulario-sinonimos a.borrar-sinonimo').live("click", function() {
            // llama al borrado de la fila
            form.borrarSinonimo(this);
        });
        // borrado de sinonimos
        $('#formulario-sinonimos a.adicionar-sinonimos-campos').live("click", function() {
            // llama al borrado de la fila
            var nombreGrupo = $(this).parent("fieldset").find("legend:first").html();
            $('#formulario-sinonimos-crear').trigger("adicionar:campos", nombreGrupo);
        });
        // mapeo de sinonimos
        $('.mapear-sinonimo').live("click", function() {
            form.mostrarFormularioMapeo(this);
        });
        // Adiciona un nuevo elemento
        $('a.adicionar-sinonimo-mapeo').live("click", function() {
            form.adicionarSinonimoMapeo();
        });
        // Borra el sinonimo seleccionado
        $('.borrar-sinonimo-mapeo').live("click", function() {
            $(this).parents("tr").remove();
        });
        // Nuevo mapeo de sinonimos
    },
    /**
     * Destruir eventos
     */
    'destruirEventos': function() {
        $('#formulario-sinonimos').unbind("mostrar");
        $('#formulario-sinonimos').unbind("adicionar");
        $('#formulario-sinonimos').unbind("modificar");
        $('#formulario-sinonimos a.crear-sinonimos').die("click");
        $('#formulario-sinonimos a.borrar-sinonimo').die("click");
        $('#formulario-sinonimos a.adicionar-sinonimos-campos').die("click");
    },
    /**
     * Destruye el objeto
     */
    'destruir': function() {
        this.destruirEventos();
    },
    /**
     * Llena la tabla con los datos de estado.area.encabezado.sinonimos
     */
    'cargarDatos': function() {
        this.limpiar();
        var sinonimos = estado.area.encabezado['sinonimos'];
        for (var i in sinonimos) {
            var html = this.htmlGrupoSinonimo(i);
            $('#sinonimos').append(html);
            this.contador++;
        }
    },
    /**
     * Adiciona un grupo de sinonimos (Fieldset) de acuerdo al nombre del grupo
     * obtiene los datos de la variable estado.area.encabezado.sinonimos
     * @param String nombreSinonimo #nombre del sinonimo a agregar
     */
    'adicionarGrupoSinonimo': function() {
        var nombreGrupo = $('#sinonimos_nombre').val();
        if (!estado.area.encabezado.sinonimos[nombreGrupo])
            return false;
        var html = this.htmlGrupoSinonimo(nombreGrupo);
        $('#sinonimos').append(html);
        this.contador++;
    },
    'modificarGrupoSinonimo': function(grupoNombreAnterior) {
        var nuevo = $('#sinonimos_nombre').val();
        var html = this.htmlGrupoSinonimo(nuevo);
        // busca al anterior e inserta al nuevo despues
        $anterior = $('#sinonimos fieldset#sinonimo-' + grupoNombreAnterior);
        $anterior.after(html);
        // elimina el anterior
        $anterior.remove();
    },
    /**
     * borra un sinonimo (una fila de la tabla de un fieldset)
     * @param DOM target #enlace "borrar" donde se hizo click
     */
    'borrarSinonimo': function(target) {
        $target = $(target);
        $tabla = $target.parents("table.tabla-sinonimos");
        // llama al evento que modifica el estado.area
        $('#sinonimos').trigger("borrar:sinonimo", $target);
        // tambien borra la fila en la tabla
        $target.parents("table.tabla-sinonimos tr").remove();
        // si ya no quedan filas borra todo el fieldset
        if ($tabla.find('tr:not(.th-head)').length == 0){
            $tabla.parent('fieldset').remove();
        }
    },
    'htmlGrupoSinonimo': function(nombreSinonimo) {
        var html = '<fieldset id="sinonimo-' + nombreSinonimo + '"><legend>' + nombreSinonimo + '</legend>';
        html += '<a class="adicionar-sinonimos-campos">Editar grupo</a>';
        html += '<table class="tabla-sinonimos" style="margin-top: 8px">';
        html += '<tr class="th-head">';
        html += '<th class="ui-state-active">Nº</th>';
        html += '<th class="ui-state-active">Campo</th>';
        //html += '<th class="ui-state-active">ID</th>';
        html += '<th class="ui-state-active"></th>';
        html += '</tr>';
        var contador = 1;
        var sinonimo = estado.area.encabezado.sinonimos[nombreSinonimo];
        for (var k in sinonimo) {
            html += '<tr>';
            html += '<td><span>' + contador + '</span></td>';
            html += '<td><span>(' + this.obtieneFilaColumna(sinonimo[k].pos) + ')</span> ' + sinonimo[k].campo + '</td>';
            //html += '<td>' + sinonimo[k].campo + '</td>';
            html += '<td class="' + k + '"><a class="mapear-sinonimo" rel="' + sinonimo[k].campo + '">Mapear</a>';
            html += '<a class="borrar-sinonimo" rel="' + sinonimo[k].campo + '">Borrar</a></td>';
            html += '</tr>';
            contador++;
        }
        html += '</table>';
        html += '</fieldset>';
        return html;
    },
    /**
     * transforma el valor de tipo "fila_columna" a su valor de iteracion:
     * - si itera filas, devuelve el valor de la columna
     * - si itera columnas, devuelve el valor de la fila
     */
    'obtieneFilaColumna': function(valor) {
        if (estado.area.iterar_fila) {
            //devuelve columna excel
            return numExcelCol(valor.split("_")[1]);
        }else{
            return valor.split("_")[0];
        }
    },
    /**
     * Elimina los sinonimos existentes en la tabla
     */
    'limpiar': function(){
        $('#sinonimos').html("");
        this.contador = 0;
    },
    /**
     * Revisa is es que el sinonimo ha sido mapeado
     */
    'revisarMapeo': function(el) {
        var uri = $(el).attr("rel");
        /*$.getJSON(uri, function(data) {
        });*/
    },
    /**
     * adiciona una fila
     */
    'adicionarSinonimoMapeo': function() {
        var html = '<tr><td><input type="text" /></td><td><textarea></textarea></td><td><a class="borrar-sinonimo-mapeo">borrar</a></td></tr>';
        $('#tabla-sinonimos-mapeo').append(html);
    },
    /**
     * Construye o muestra el formulario de mapeo
     */
    'mostrarFormularioMapeo': function(el) {
        var campo = $(el).attr("rel");

        if( $('#formulario-mapeados').length <= 0) {
            $.get('/sinonimos/new', function(data) {
                $(data).dialog({
                  'resizable': false, 
                  'width': 550, 
                  'title': 'Mapeo de sinónimos',
                  'open': function() { $('#sinonimo_campo').val(campo);}
                  });
            });
              
        }else {
            $('#formulario-mapeados').dialog("open");
            $('#sinonimo_campo').val(campo);
        }

        this.revisarMapeo(el);
    },
    /**
     * Lista los sinonimos via AJAX
     */
    'listarSinonimos': function() {
        var sin = this;

        $('#a-lista-sinonimos').mouseover(function() {
            $(this).removeClass("listar-up").addClass("listar-down");
            $('#lista-sinonimos').show();
            //Primera ves que se llama se debe llamar al AJAX
            if($("#lista-sinonimos ul").length <= 0)
                $('#importar-sinonimos .ajax').html( sin.listarSinonimosAjax() );
            
        }).mouseout(function() {
            setTimeout(function() {
                sin.listarSinonimosVer();
            }, 200);
            $('#a-lista-sinonimos').removeClass("listar-down").addClass("listar-up");
        });
        
        $('#lista-sinonimos').mouseover(function() {
            $('#a-lista-sinonimos').removeClass("listar-up").addClass("listar-down"); 
        }).mouseout(function() {
            $('#a-lista-sinonimos').removeClass("listar-down").addClass("listar-up"); 
            setTimeout(function() {
                sin.listarSinonimosVer();
            }, 200);
        });
    },
    /**
     * Realiza una llamada AJAX para listar los sinonimos
     * @return String
     */
    'listarSinonimosAjax': function() {
        var html = '<ul>';
        $.getJSON("/sinonimos.json", function(data) {
            $(data).each(function(i, el){
                html += '<li><a class="'+ el.sinonimo.id +'">' + el.sinonimo.nombre + '</a></li>'
            });
            html += '</ul>';
        });
        return html;
    },
    /**
     * Presenta el listado de sinonimos cuando la clase  de "a" es listar-down
     */
    'listarSinonimosVer': function() {
        if ($('#a-lista-sinonimos').hasClass("listar-up") ) {
            $('#lista-sinonimos').hide();
            $('#a-lista-sinonimos').removeClass("listar-down").addClass("listar-up");
        }
    },
    /**
     * Carga el formulario para poder crear o editar nuevos sinonimos
     */
    'cargarFormularioSinonimos': function() {
        $('#formulario-sinonimos-new').load("/sinonimos/new", function() {
            $('#sinonimo_tipo').change(function() {
                if($(this).val() == "CSV") {
                    $('#sinonimo-csv-separador').show();
                }else{
                    $('#sinonimo-csv-separador').hide();
                }
            });
        });
    }
};
