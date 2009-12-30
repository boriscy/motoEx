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
            'height': 500, 
            'resizable': false, 
            'modal': true, 
            'autoOpen': false,
            'title': 'Sinónimos'
        });
        // crea los eventos
        this.crearEventos();
        // lista los sinonimos AJAX
        this.listarSinonimos();
        // cargar el formulario AJAX
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
        });
        
        $('#formulario-sinonimos').bind("cerrar", function() {
            // guarda los datos en la variable global estado.area
            $('#lista-sinonimos-mapeo').trigger("guardar");
        });
        
        // para el boton de Crear Sinonimo
        $('input.input-crear-sinonimo').live("click", function(e) {
            var sinonimoId = $('#select-sinonimos-mapeo').val();
            if (sinonimoId != 'disabled') {
                var option = $('#select-sinonimos-mapeo option.' + sinonimoId)[0];
                form.adicionarSinonimo(option);
            }
        });
        // para el boton de Crear Sinonimo
        $('a.borrar-sinonimo').live("click", function() {
            $(this).parents('fieldset').remove();
        });
        
        // Adiciona un nueva fila (Campo a Buscar - Campos Donde Buscar)
        $('a.adicionar-campo-mapeo').live("click", function() {
            var sinonimoId = $(this).parents('fieldset').find('input.sinonimo-id').val();
            form.adicionarCampoMapeo(sinonimoId);
        });
        // Borra el campo seleccionado
        $('a.borrar-campo-mapeo').live("click", function() {
            //var sinonimoId = $(this).parents('fieldset').attr('id');
            $(this).parents("tr").remove();
        });
        //////////////////////
        $('body').append('<iframe name="iframe-mapeo" id="iframe-mapeo" style="display:none"></iframe>');
        // Nuevo mapeo de sinonimos
        $('#formulario-mapeados form').live("submit", function() {
            $(this).attr("target", "iframe-mapeo");
            $('#iframe-mapeo')[0].onload = function() {
                form.importarSinonimos();
            }
        });

    },
    /**
     * Destruir eventos
     */
    'destruirEventos': function() {
        $('#formulario-sinonimos').unbind("mostrar");
        $('#formulario-sinonimos').unbind("cerrar");
        $('input.input-crear-sinonimo').die("click");
        $('a.borrar-sinonimo').die("click");
        $('a.adicionar-campo-mapeo').die("click");
        $('a.borrar-campo-mapeo').die("click");
        $('#formulario-mapeados form').die("submit");
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
        var sinonimos = estado.area.sinonimos;
        for (var i in sinonimos) {
            var html = this.htmlGrupoSinonimo(i);
            $('#lista-sinonimos-mapeo').append(html);
            this.contador++;
        }
    },
    
    'adicionarSinonimo': function(option) {
        var $option = $(option);
        // adiciona un fieldset
        var html='<fieldset id="fieldset-sinonimo-mapeo-' + $option.val() + '">';
        html += '<input class="sinonimo-id" type="hidden" value ="' + $option.val() + '" />';
        html += '<legend>' + $option.text() + '</legend>';
        html += '<a class="adicionar-campo-mapeo">Adicionar campo</a>&nbsp;';
        html += '<a class="borrar-sinonimo">Borrar Sinónimo</a>';
        html += '<table style="margin-top: 8px;" class="tabla-sinonimos-mapeo"><tr>';
        html += '<th class="ui-state-active">Campo buscado</th>';
        html += '<th class="ui-state-active">Campos de búsqueda</th>';
        html += '<th class="ui-state-active"></th>';
        html += '</tr>';
        html += '</table>';
        html += '</fieldset>';
        // y siempre adiciona una fila vacia
        $('#lista-sinonimos-mapeo').append(html);
        
        this.adicionarCampoMapeo($option.val());
        
        this.contador++;
        
    },
    'adicionarCampoMapeo': function(sinonimoId) {
        // adiciona una fila a un fieldset
        var $fieldset = $('#fieldset-sinonimo-mapeo-' + sinonimoId);
        var numFilas = $fieldset.find('table tr:not(:first)').length;
        
        var listado = '';
        var enc = estado.area.encabezado.campos;
        for (var k in enc) {
            listado += '<option value="' + enc[k].campo + '">' + enc[k].campo + '</option>'
        }
        
        var html = '<tr><td>';
        html += '<select class="campo-buscado">' + campos + '</select>';
        html += '</td><td>';
        html += '<select class="campos-busqueda" multiple="multiple">' + listado + '</select>';
        html += '</td><td><a class="borrar-campo-mapeo">borrar</a></td></tr>';
        $fieldset.find('table').append(html);
        
        var campos = '';
        
        if ( numFilas > 0) {
            // copia los datos del primer select
            $fieldset.find('select.campo-buscado:first option')
                .clone()
                .appendTo('#fieldset-sinonimo-mapeo-' + sinonimoId + ' select.campo-buscado:last');
            /*$('#fieldset-sinonimo-mapeo-' + sinonimoId + ' select.campo-buscado:first option').each(function(i, el) {
                campos += '<option value=' + $(el).val() + '>' + $(el).text() + '</option>';
            });*/
        }else {
            // llama por AJAX
            $.getJSON('/sinonimos/' + sinonimoId + '.json', function(data) {
                var datos = data.sinonimo.mapeado[0];
                var campos = '';
                for (var k in datos) {
                    campos += '<option value="' + k + '">' + k + '</option>';
                }
                $fieldset.find('select.campo-buscado').append(campos);
            });
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
     * Elimina los sinonimos existentes en la tabla
     */
    'limpiar': function() {
        $('#lista-sinonimos-mapeo').html("");
        this.contador = 0;
    },
    ////////// NUEVOS METODOS
    /**
     * Lista los sinonimos via AJAX
     */
    'listarSinonimos': function() {
        var sin = this;

        $('#a-lista-sinonimos').mouseover(function() {
            $(this).removeClass("listar-up").addClass("listar-down");
            $('#lista-sinonimos').show();
            //Primera ves que se llama se debe llamar al AJAX
            if($("#lista-sinonimos ul").length <= 0) {
                sin.listarSinonimosAjax()
            }
            
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
        var options = '<option value="disabled"></option>';
        $.getJSON("/sinonimos.json", function(data) {
            $(data).each(function(i, el){
                options += '<option class="' + el.sinonimo.id + '" value="' + el.sinonimo.id + '">' + el.sinonimo.nombre + '</option>';
            });
            $('#select-sinonimos-mapeo').html(options);
        });
    },
    /**
     * Realiza una llamada AJAX para listar los sinonimos
     * y llena el area #importar-sinonimos con la lista
     */
    'listarSinonimosAjax': function() {
        var html = '<ul>';
        $.getJSON("/sinonimos.json", function(data) {
            $(data).each(function(i, el){
                html += '<li><a class="'+ el.sinonimo.id +'">' + el.sinonimo.nombre + '</a></li>';
            });
            html += '</ul>';
            $('#importar-sinonimos .ajax').html( html );
        });
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
    },
    /**
     * Importa los sinonimos
     */
    'importarSinonimos': function() {
        // Se recibe la respuesta y se adiciona el elmento ingresado a la lista
        var json = eval( "(" + $('#iframe-mapeo').contents().find("body").text() + ")" );

        if(json.sinonimo) {
            var data = json.sinonimo;
            if($('#formulario-mapeados input:hidden[name=_method]').length <= 0) {
                // Adicion de metodo put y cambio de la ruta para el formulario
                $('#formulario-mapeados form').attr("action", "/sinonimos/" + data.id)
                .append('<input type="hidden" name="_method" value="put" />');
                $('#iframe-submit').val("Editar");
            }
            $('#lista-sinonimos ul').append('<li><a href="' + data.id + '">' + data.nombre + '</a></li>');
        }else {
            var text = "Error";
            alert("Errores");
            $(json).each(function(i, el) {
                var id = '#sinonimo_' + el[0];
                var error = el[1];
                //Adicionar error
            });
        }
    }
};

