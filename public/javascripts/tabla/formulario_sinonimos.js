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
                var option = $('#select-sinonimos-mapeo option[value="' + sinonimoId + '"]')[0];
                form.adicionarSinonimo(option);
            }
        });
        // para el boton de Crear Sinonimo
        $('a.borrar-sinonimo').live("click", function() {
            var $fieldset = $(this).parents('fieldset');
            var sinonimoId = $fieldset.find('input.sinonimo-id').val();
            //busca al sinonimo en el combo y lo habilita
            $('#select-sinonimos-mapeo option[value="' + sinonimoId + '"]').attr("disabled", false);
            $fieldset.remove();
        });
        
        // Adiciona un nueva fila (Campo a Buscar - Campos Donde Buscar)
        $('a.adicionar-campo-mapeo').live("click", function() {
            var sinonimoId = $(this).parents('fieldset').find('input.sinonimo-id').val();
            form.adicionarCampoMapeo(sinonimoId);
        });
        // Borra el campo seleccionado
        $('a.borrar-campo-mapeo').live("click", function() {
            //var sinonimoId = $(this).parents('fieldset').attr('id');
            if ($(this).parents('table').find('tr:not(:first)').length > 1) {
                $(this).parents('tr').remove();
            }else {
                // si fuera la ultima fila borra el sinonimo completo
                var $fieldset = $(this).parents('fieldset');
                var sinonimoId = $fieldset.find('input.sinonimo-id').val();
                //busca al sinonimo en el combo y lo habilita
                $('#select-sinonimos-mapeo option[value="' + sinonimoId + '"]').attr("disabled", false);
                $fieldset.remove();
            }
        });
        //////////////////////
        $('body').append('<iframe name="iframe-mapeo" id="iframe-mapeo" style="display:none"></iframe>');
        // para que cargue el sinonimo
        $('.ajax-sinonimo').live("click", function() {
            var $this = $(this);
            // copia los datos al form
            $('#sinonimo_nombre').val($this.text());
            var $form = $('#formulario-mapeados form');
            $form.attr('action', '/sinonimos/' + $this.attr("rel"))
            if ($form.find('input[name="_method"]').length == 0)
                $form.append('<input type="hidden" name="_method" value="put" />');
            $('#iframe-submit').val("Editar");
            // oculta el div
            $('#a-lista-sinonimos').removeClass("listar-down").addClass("listar-up"); 
            setTimeout(function() {
                form.listarSinonimosVer();
            }, 50);
        });
        
        // Nuevo mapeo de sinonimos
        $('#formulario-mapeados form').live("submit", function() {
            $(this).attr("target", "iframe-mapeo");
            // si es editar, cambia el action con el id
            $('#iframe-mapeo')[0].onload = function() {
                form.importarSinonimos();
            }
        });
        // para que muestre el select de separador csv al seleccionar el archivo
        $('#sinonimo_archivo_tmp').live("change", function() {
            var archivo = $(this).val();
            if(archivo.substring(archivo.length - 4, archivo.length).toUpperCase() == ".CSV") {
                $('#sinonimo-csv-separador').show();
            }else{
                $('#sinonimo-csv-separador').hide();
            }
        });
        // para que se pueda subir sinonimos de nuevo
        $('a.crear-sinonimo').live("click", function() {
            var $form = $('#formulario-mapeados form');
            $form.attr('action', '/sinonimos')
            $form.find('input[name="_method"]').remove();
            $('#iframe-submit').val("Crear");
            //limpia el form
            $form[0].reset();
        });
        // para que exporte en csv un sinonimo abierto
        $('#sinonimo-exportar-csv').live("click", function() {
            var sinonimoId = $('#formulario-mapeados form').attr('action').replace(/(^.+)(\d+)$/, "$2");
            // envia la solicitud para que descargue un csv
            if ( parseInt(sinonimoId) )
                window.location.href = '/sinonimos/' + sinonimoId + '.csv';
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
        $('#sinonimo_archivo_tmp').die("change");
        $('a.crear-sinonimo').die("click");
        $('#sinonimo-exportar-csv').die("click");
    },
    /**
     * Destruye el objeto
     */
    'destruir': function() {
        this.destruirEventos();
    },
    /**
     * Llena la tabla con los datos de estado.area.sinonimos
     */
    'cargarDatos': function() {
        this.limpiar();
        var sinonimos = estado.area.sinonimos;
        var $select = $('#select-sinonimos-mapeo');
        for (var i in sinonimos) {
            var $option = $select.find('option[value="' + i + '"]')
            $option.attr("disabled", true);
            // adiciona el fieldset
            var html = this.htmlSinonimo($option);
            $('#lista-sinonimos-mapeo').append(html);
            
            var $fieldset = $('#lista-sinonimos-mapeo fieldset:last');
            
            // agrega para cada uno de los campos
            for (var buscado in sinonimos[i]) {
                this.adicionarCampoMapeo($option.val(), buscado);
                // y selecciona los campos correspondientes
                var $selectBusqueda = $fieldset.find('select.campos-busqueda:last');
                
                for (var busqueda in sinonimos[i][buscado]) {
                    $selectBusqueda.find('option[value="' + sinonimos[i][buscado][busqueda] + '"]').attr("selected", "selected");
                }
            }
            
            this.contador++;
        }
        // selecciona el primer valor por defecto
        $select.val("disabled");
    },
    /**
     * Adiciona un fieldset para un sinonimo
     * @param JQuery option # sinonimo seleccionado
     */
    'adicionarSinonimo': function(option) {
        var $option = $(option);
        $option.attr("disabled", true);
        $option.parents("select").val("disabled");
        // adiciona un fieldset
        var html = this.htmlSinonimo($option);
        
        // y siempre adiciona una fila vacia
        $('#lista-sinonimos-mapeo').append(html);
        
        this.adicionarCampoMapeo($option.val());
        
        this.contador++;
        
    },
    /**
     * Adiciona una fila para busqueda de sinonimos
     * @param String sinonimoId
     * @param String selectBuscadoValor #valor del campo buscado (para cuando se carga los sinonimos de la variable estado.area.sinonimos)
     */
    'adicionarCampoMapeo': function(sinonimoId, selectBuscadoValor) {
        // adiciona una fila a un fieldset
        var $fieldset = $('#fieldset-sinonimo-mapeo-' + sinonimoId);
        var numFilas = $fieldset.find('table tr:not(:first)').length;
        
        var listado = '';
        var enc = estado.area.encabezado.campos;
        for (var k in enc) {
            listado += '<option value="' + enc[k].campo + '">' + enc[k].campo + '</option>'
        }
        
        var html = '<tr><td>';
        html += '<select class="campo-buscado"></select>';
        html += '</td><td>';
        html += '<select class="campos-busqueda" multiple="multiple">' + listado + '</select>';
        html += '</td><td><a class="borrar-campo-mapeo">borrar</a></td></tr>';
        $fieldset.find('table').append(html);
        
        var $selectBuscado = $('#fieldset-sinonimo-mapeo-' + sinonimoId + ' select.campo-buscado:last');
        /*
        if ( numFilas > 0 ) {
            // copia los datos del primer select
            $fieldset.find('select.campo-buscado:first option')
                .clone()
                .appendTo($selectBuscado);
            $selectBuscado.val(selectBuscadoValor);
        }else*/
            $.getJSON('/sinonimos/' + sinonimoId + '.json', function(data) {
                var datos = data.sinonimo.mapeado[0];
                var campos = '';
                for (var k in datos) {
                    campos += '<option value="' + k + '">' + k + '</option>';
                }
                $selectBuscado.append(campos);
                $selectBuscado.val(selectBuscadoValor);
            });
    },
    
    /**
     * Cargado del html del Fieldset para el sinonimo
     * @param JQuery option # sinonimo seleccionado
     */
    'htmlSinonimo': function($option) {
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
        
        return html;
    },
    /**
     * Elimina los sinonimos existentes en la tabla
     */
    'limpiar': function() {
        $('#lista-sinonimos-mapeo').html("");
        this.contador = 0;
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
                //options += '<option class="' + el.sinonimo.id + '" value="' + el.sinonimo.id + '">' + el.sinonimo.nombre + '</option>';
                options += '<option value="' + el.sinonimo.id + '">' + el.sinonimo.nombre + '</option>';
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
                html += '<li><a class="ajax-sinonimo" rel="' + el.sinonimo.id + '">' + el.sinonimo.nombre + '</a></li>';
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
                var $form = $('#formulario-mapeados form');
                $form.attr("action", "/sinonimos/" + data.id);
                if ($form.find('input[name="_method"]') == 0)
                    $form.append('<input type="hidden" name="_method" value="put" />');
                $('#iframe-submit').val("Editar");
            }
            var $sinonimo = $('#lista-sinonimos ul a[rel="' + data.id + '"]');
            if ($sinonimo.length > 0) {
                // actualiza el sinonimo
                $sinonimo.html(data.nombre);
            }else {
                // agrega un sinonimo
                $('#lista-sinonimos ul').append('<li><a class="ajax-sinonimo" rel="' + data.id + '">' + data.nombre + '</a></li>');
            }
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
