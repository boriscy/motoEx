Encabezado = Area.extend({
    'area': false,
    'areaMinima': 1,
    'serialize': 'encabezado',
    /**
     * Constructor
     * @param String ini
     * @param String fin
     * @param AreaGeneral area
     */
    'init': function(ini, fin, area){
        this.cssMarcar = 'bg-light-blue';
        this._super(ini, fin);
        this.area = area;
        estado.area[this.serialize]['campos'] = [];
        this.crearEventos();
    },
    /**
     * Creación de eventos relacionados
     */
    'crearEventos': function() {
        var enc = this;
        $('#area-encabezado').bind('marcar:encabezado', function(){
            // Validar que este dentro del AreaGeneral
            if (enc.validarInclusion(enc.area.cssMarcar) && enc.validarSolapamiento([enc.area.fin.cssMarcar]) ) {
                enc.desmarcarArea(enc.cssMarcar);
                enc.marcarArea(enc.cssMarcar);
                enc.crearTablaCeldas();
            }
            // Eventos para crear campos en la BD
            $('.enc-check').live("click", function() { enc.adicionarBorrarCampo(this);});
            $('.enc-text').livequery("blur", function() { enc.mapearCampo(this);});
        });
    },
    /**
     * Funcion para que pueda realizar opciones adicionales
     */
    'marcarArea': function(css, cssSel) {
        this._super(css, cssSel);
        estado.area[this.serialize]['campos'] = {};
        this.destruirTablasCeldas();
    },
    /**
     * Desmarca el area de encabezado y destruye los eventos de marcado
     */
    'desmarcarArea': function(css, e) {
        this._super(css, e);
        this.destruirEventosTablaCeldas();
    },
    /**
     * Elimina los eventos creados
     */
    'destruirEventos': function() {
        $('#area-encabezado').unbind('marcar:encabezado');
        this.destruirEventosTablaCeldas();
    },
    /**
     * Elimina los eventos de la tabla de encabezados
     */
    'destruirEventosTablaCeldas': function() {
        $('.enc-check').die("click");
        $('.enc-text').expire("blur");
    },
    /**
     * Crea una tabla con todas las celdas a seleccionar para importar
     */
    'crearTablaCeldas': function() {
        var celdas = estado.area[this.serialize].celdas;
        var $tabla = $('#tabla-encabezado');
        for(i = 0, l = celdas.length; i < l; i++) {
            var html = '<tr><td><input type="hidden" name="area[encabezado][' + i + '][hidden]" value="' + celdas[i].pos + '"/>';
              html += '<span>' + celdaExcel(celdas[i].pos) + '</span>';
              html += '<label id="label-enc-campo' + i + '"><input type="checkbox" name="area[encabezado][' + i + '][sel]" class="enc-check"/>' + celdas[i].texto + '</label></td>';
            var evento = "$('.enc-text').trigger('mapear:campo', this)";
            html += '<td><input type="text" name="area[encabezado][' + i + '][text]" value="' + celdas[i].texto + '" class="enc-text" disabled="disabled"/></td></tr>';
            $tabla.append(html);
        }
    },
    /**
     * Elimina las celdas del formulario y el estado
     */
    'destruirTablasCeldas': function() {
        $('#tabla-encabezado tr:not(.th-head)').remove();
    },
    /**
     * Adiciona campos a la variable de estado además de habilitar
     * los textos de un encabezado para ser mapeados por la Base de datos
     */
    'adicionarBorrarCampo': function(el) {
        var nombre = el.name.replace(/\[sel\]$/, "[text]");
        var texto = $(el).parent('label').text();
        var val = $(el).attr("checked");
        $inputText = $('input:text[name="' + nombre + '"]');
        nombre = nombre.replace(/\[text\]$/, "[hidden]");
        $inputHidden = $('input:hidden[name="' + nombre + '"]');
        $inputText.attr("disabled", !val);

        var pos = $inputHidden.val();

        if(val) {
            estado.area[this.serialize].campos[pos] = {'texto': texto, 'campo': texto};
        } else{
            delete(estado.area[this.serialize].campos[pos]);
        }
    },
    /**
     * Mapea el nombre del campo según el texto que tiene para el encabezado
     */
    'mapearCampo': function(el) {
        var pos = $(el).parents('tr').find('input:hidden').val();
        estado.area[this.serialize].campos[pos].campo = $(el).val();
    },
     /**
     * Destructor que elimina eventos y las filas de #tabla-encabezado
     */
    'destruir': function() {
        this._super();
        $('#tabla-encabezado tr:not(:first)').remove();
    }
});
