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
        $('#formulario-sinonimos').bind("adicionar", function(e, nombreSinonimo) {
            form.adicionarGrupoSinonimo(nombreSinonimo);
        });
        // modifica un grupo
        $('#formulario-sinonimos').bind("modificar", function(e, sinonimoAnteriorNuevo) {
            form.modificarGrupoSinonimo(sinonimoAnteriorNuevo);
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
            this.adicionarGrupoSinonimo(i);
        }
    },
    /**
     * Adiciona un grupo de sinonimos (Fieldset) de acuerdo al nombre del grupo
     * obtiene los datos de la variable estado.area.encabezado.sinonimos
     * @param String nombreSinonimo #nombre del sinonimo a agregar
     */
    'adicionarGrupoSinonimo': function(nombreSinonimo) {
        var html = this.htmlGrupoSinonimo(nombreSinonimo);
        $('#sinonimos').append(html);
        this.contador++;
    },
    'modificarGrupoSinonimo': function(sinonimoAnteriorNuevo) {
        var anterior = sinonimoAnteriorNuevo['nombreAnterior'];
        var nuevo = sinonimoAnteriorNuevo['nombreNuevo'];
        
        var html = this.htmlGrupoSinonimo(nuevo);
        // busca al anterior e inserta al nuevo despues
        $anterior = $('#sinonimos fieldset#sinonimo-' + anterior)
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
        var fila = $target.parent("td").attr('class');
        $('#sinonimos').trigger("borrar:sinonimo", fila);
        // tambien borra la fila en la tabla
        $target.parents("table.tabla-sinonimos tr").remove();
        // si ya no quedan filas borra todo el fieldset
        if ($tabla.find('tr:not(.th-head)').length == 0){
            $tabla.parent('fieldset').remove();
        }
    },
    'htmlGrupoSinonimo': function(nombreSinonimo) {
        var html = '<fieldset id="sinonimo-' + nombreSinonimo + '"><legend>' + nombreSinonimo + '</legend>';
        html += '<a href="#" class="adicionar-sinonimos-campos">Adicionar campos</a>';
        html += '<table class="tabla-sinonimos">';
        html += '<tr class="th-head">';
        html += '<th class="ui-state-active">Nº</th>';
        html += '<th class="ui-state-active">Campo</th>';
        html += '<th class="ui-state-active">ID</th>';
        html += '<th class="ui-state-active"></th>';
        html += '</tr>';
        var contador = 1;
        var sinonimo = estado.area.encabezado.sinonimos[nombreSinonimo];
        for (var k in sinonimo) {
            html += "<tr>";
            html += "<td><span>" + contador + "</span></td>";
            html += "<td><span>(" + this.obtieneFilaColumna(k) + ")</span> " + sinonimo[k].campo + "</td>";
            html += "<td>" + sinonimo[k].campo + "</td>";
            html += "<td class='" + k + "'><a href='#' class='mapear-sinonimo'>Mapear</a> <a href='#' class='borrar-sinonimo'>Borrar</a></td>";
            html += "</tr>";
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
    }
};
