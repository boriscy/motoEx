Encabezado = Area.extend({
    'area': false,
    'areaMinima': 1,
    'serialize': 'encabezado',
    'cssMarcar': 'bg-light-blue',
    /**
     * Constructor
     * @param String ini
     * @param String fin
     * @param AreaGeneral area
     */
    'init': function(ini, fin, area) {
        this._super(ini, fin);
        this.area = area;
        
        if (estado.area[this.serialize]['campos']) {
            this.destruirTablasCeldas();
            this.crearTablaCeldas();
        }
        
        this.crearEventos();
    },
    /**
     * Creación de eventos relacionados
     */
    'crearEventos': function() {
        var enc = this;
        $('#area-encabezado').bind('marcar:encabezado', function(){
            // Validar que este dentro del AreaGeneral
            if (enc.validarInclusion(enc.area.cssMarcar) && 
                enc.validarSolapamiento([enc.area.titular.cssMarcar, enc.area.descartar.cssMarcar, enc.area.fin.cssMarcar]) ) {
                
                enc.desmarcarArea(enc.cssMarcar);
                enc.marcarArea(enc.cssMarcar);
                enc.crearTablaCeldas();
            }
            // Eventos para crear campos en la BD
            // TODO: revisar y/o refactorizar creacion de eventos para cuando se modifica un area cargada por el select:areas
        });
        $('.' + enc.serialize + '-check').live("click", function() { enc.adicionarBorrarCampo(this);});
        $('.' + enc.serialize + '-text').livequery("blur", function() { enc.mapearCampo(this);});
    },
    /**
     * Funcion para que pueda realizar opciones adicionales
     */
    'marcarArea': function(css, cssSel) {
        this._super(css, cssSel);
        estado.area[this.serialize]['campos'] = {};
    },
    /**
     * Desmarca el area de encabezado y destruye los eventos de marcado
     */
    'desmarcarArea': function(css, e) {
        this._super(css, e);
        $('#tabla-' + this.serialize + ' tr:not(.th-head)').remove();
        //this.destruirEventosTablaCeldas();
    },
    /**
     * Elimina los eventos creados
     */
    'destruirEventos': function() {
        $('#area-' + this.serialize).unbind('marcar:' + this.serialize);
        this.destruirEventosTablaCeldas();
    },
    /**
     * Elimina los eventos de la tabla de encabezados
     */
    'destruirEventosTablaCeldas': function() {
        $('.' + this.serialize + '-check').die("click");
        $('.' + this.serialize + '-text').expire("blur");
    },
    /**
     * Crea una tabla con todas las celdas a seleccionar para importar
     */
    'crearTablaCeldas': function() {
        var celdas = estado.area[this.serialize].celdas;
        if (celdas){
            var $tabla = $('#tabla-' + this.serialize);
            for(i = 0, l = celdas.length; i < l; i++) {
                var html = '<tr class="' + celdas[i].pos + '"><td><input type="hidden" name="area[' + this.serialize + '][' + i + '][hidden]" value="' + celdas[i].pos + '"/>';
                html += '<span>' + celdaExcel(celdas[i].pos) + '</span>';
                html += '<label id="label-' + this.serialize + '-campo' + i + '">';
                html += '<input type="checkbox" name="area[' + this.serialize + '][' + i + '][sel]" class="' + this.serialize + '-check"';
                if (estado.area[this.serialize].campos[celdas[i].pos])
                    html += ' checked="checked"';
                html +='/>' + celdas[i].texto + '</label></td>';
                html += '<td><input type="text" name="area[' + this.serialize + '][' + i + '][text]" value="';
                if (!estado.area[this.serialize].campos[celdas[i].pos]){
                    html += celdas[i].texto;
                }else{
                    html += estado.area[this.serialize].campos[celdas[i].pos].campo;
                }
                html += '" class="' + this.serialize + '-text"';
                if (!estado.area[this.serialize].campos[celdas[i].pos])
                    html += ' disabled="disabled"';
                html += '/></td></tr>';
                $tabla.append(html);
            }
        }
    },
    /**
     * Elimina las celdas del formulario y el estado
     */
    'destruirTablasCeldas': function() {
        $('#tabla-' + this.serialize + ' tr:not(.th-head)').remove();
    },
    /**
     * Adiciona campos a la variable de estado además de habilitar
     * los textos de un encabezado para ser mapeados por la Base de datos
     */
    'adicionarBorrarCampo': function(el) {
        var nombre = el.name.replace(/\[sel\]$/, "[text]");
        var texto = $(el).parent('label').text().trim();
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
        $('#tabla-' + this.serialize + ' tr:not(.th-head)').remove();
    }
});
