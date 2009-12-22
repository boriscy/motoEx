/**
 * Clase para poder manejar el formulario de Area
 */
FormularioSinonimos = function() {
    this.init();
}

FormularioSinonimos.prototype = {
    /**
     * Cuenta la cantidad de sinonimos
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
        //crea los eventos
        this.crearEventos();
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
        // edita o guarda uno nuevo
        $('#formulario-sinonimos').bind("adicionar", function() {
            form.adicionarGrupoSinonimo();
        });
        // edita o guarda uno nuevo
        $('#formulario-sinonimos').bind("cerrar", function() {
            form.cerrar();
        });
        //muestra el formulario de adicion
        $('#formulario-sinonimos a.crear-sinonimos').live("click", function() {
            $('#formulario-sinonimos-crear').trigger("mostrar");
        });
    },
    /**
     * Destruir eventos
     */
    'destruirEventos': function() {
        $('#formulario-sinonimos').unbind("mostrar");
        $('#formulario-sinonimos').unbind("cerrar");
        $('#formulario-sinonimos').unbind("guardar");
        $('#formulario-sinonimos a.crear-sinonimos').die("click");
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
        var sinonimos = estado.area.encabezado['sinonimos'];
        this.limpiar();
        for (var i in sinonimos) {
            this.adicionarGrupoSinonimo(sinonimos[i]);
        }
    },
    'adicionarGrupoSinonimo': function(grupo) {
        var html = '<fieldset class="' + grupo + '"><legend>' + grupo + '</legend>';
        html += '<a href="#" class="adicionar-sinonimos-campos">Adicionar campos</a>';
        html += '<table class="tabla-sinonimos">';
        html += '<tr class="th-head">';
        html += '<th class="ui-state-active">Nº</th>';
        html += '<th class="ui-state-active">Campo</th>';
        html += '<th class="ui-state-active">ID</th>';
        html += '<th class="ui-state-active"></th>';
        html += '</tr>';
        var total = 1;
        for (var k in grupo) {
            html += "<tr>";
            html += "<td><span>" + total + "</span></td>";
            html += "<td><span>(" + obtieneFilaColumna(grupo[k].pos) + ")</span> " + grupo[k].campo + "</td>";
            html += "<td>" + grupo[k].campo + "</td>";
            html += "<td><a href='#'>Mapear</a> <a href='#'>Borrar</a></td>";
            html += "</tr>";
            total++;
        }
        html += '</table>';
        html += '</fieldset>';
        $('#div-sinonimos').append(html);
        this.contador++;
    },
    'obtieneFilaColumna': function(valor) {
        if (estado.area.iterar_fila) {
            //devuelve columna
            return numExcelCol(valor);
        }else{
            return valor();
        }
    },
    /**
     * Elimina los sinonimos existentes
     */
    'limpiar': function(){
        $('#div-sinonimos').html("");
        this.contador = 0;
    }
};
