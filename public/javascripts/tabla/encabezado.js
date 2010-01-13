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
        base = this;
        
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
        $('#area-encabezado').bind('marcar:encabezado', function(){
            // Validar que este dentro del AreaGeneral
            if (base.validarInclusion(base.area.cssMarcar) && 
                base.validarSolapamiento([base.area.titular.cssMarcar, base.area.descartar.cssMarcar, base.area.fin.cssMarcar]) ) {
                
                base.desmarcarArea(base.cssMarcar);
                base.marcarArea(base.cssMarcar);
                base.crearTablaCeldas();
            }
            // Eventos para crear campos en la BD
            // TODO: revisar y/o refactorizar creacion de eventos para cuando se modifica un area cargada por el select:areas
        });
        $('.' + this.serialize + '-check').live("click", function() { base.adicionarBorrarCampo(this);});
        $('.' + this.serialize + '-text').livequery("blur", function() { base.mapearCampo(this);});
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
                if (this.serialize == 'encabezado'){
                    var input_campo_id = '<td><input type="text" name="area[' + this.serialize + '][' + i + '][text]" value="';
                    if (!estado.area[this.serialize].campos[celdas[i].pos]){
                        input_campo_id += celdas[i].texto;
                    }else{
                        input_campo_id += estado.area[this.serialize].campos[celdas[i].pos].campo;
                    }
                    input_campo_id += '" class="' + this.serialize + '-text"';
                    if (!estado.area[this.serialize].campos[celdas[i].pos])
                        input_campo_id += ' disabled="disabled"';
                    input_campo_id += '/></td>';
                    html += input_campo_id;
                }
                html += '</tr>';
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
            if (this.serialize == 'encabezado')
                estado.area[this.serialize].campos[pos] = {'texto': texto, 'campo': texto};
            else
                estado.area[this.serialize].campos[pos] = {'texto': texto};
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
