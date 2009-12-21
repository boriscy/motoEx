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
        $('#formulario-sinonimos').bind("guardar", function() {
            form.guardar();
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
     * guarda los campos de los sinonimos en la variable global estado.area
     */
    'guardar': function() {
        
    },
    /**
     * Elimina los sinonimos existentes
     */
    'destruirSinonimos': function(){
        $('#div-sinonimos').html("");
        this.contador = 0;
    },
    /**
     * Llena la tabla con los datos de estado.area.encabezado.sinonimos
     */
    'cargarDatos': function() {
        var sinonimos = estado.area.encabezado['sinonimos'];
        this.destruirSinonimos();
        var $div = $("#div-sinonimos");
        for (var i in sinonimos) {
            this.contador++;
            var html = '<fieldset class="' + sinonimos[i] + '"><legend>' + sinonimos[i] + '</legend>';
            html += '<a href="#" class="adicionar-sinonimos-campos">Adicionar campos</a>';
            html += '<table class="tabla-sinonimos">';
            html += '<tr class="th-head">';
            html += '<th class="ui-state-active">Nº</th>';
            html += '<th class="ui-state-active">Campo</th>';
            html += '<th class="ui-state-active">ID</th>';
            html += '<th class="ui-state-active"></th>';
            html += '</tr>';
            var total = 1;
            for (var k in sinonimos[i]) {
                html += "<tr>";
                html += "<td><span>" + total + "</span></td>";
                html += "<td><span>(" + obtieneFilaColumna(sinonimos[i][k].pos) + ")</span> " + sinonimos[i][k].campo + "</td>";
                html += "<td>" + sinonimos[i][k].campo + "</td>";
                html += "<td><a href='#'>Mapear</a> <a href='#'>Borrar</a></td>";
                html += "</tr>";
                total++;
            }
            html += '</table>';
            html += '</fieldset>';
            $tabla.append(html);
        }
    },
    'adicionarGrupoSinonimo': function(nombreGrupo, elementos) {
        var html = '<fieldset class="' + nombreGrupo + '"><legend>' + nombreGrupo + '</legend>';
        html += '<a href="#" class="adicionar-sinonimos-campos">Adicionar campos</a>';
        html += '<table class="tabla-sinonimos">';
        html += '<tr class="th-head">';
        html += '<th class="ui-state-active">Nº</th>';
        html += '<th class="ui-state-active">Campo</th>';
        html += '<th class="ui-state-active">ID</th>';
        html += '<th class="ui-state-active"></th>';
        html += '</tr>';
        var total = 1;
        for (var k in elementos) {
            html += "<tr>";
            html += "<td><span>" + total + "</span></td>";
            html += "<td><span>(" + obtieneFilaColumna(elementos[k].pos) + ")</span> " + elementos[k].campo + "</td>";
            html += "<td>" + elementos[k].campo + "</td>";
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
    }
};
