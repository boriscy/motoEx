/**
 * Clase para poder manejar el formulario de Area
 */
FormularioArea = function(area, options) {
    this.merge(options);
    this.area = area;
    this.crearEventos();
}

FormularioArea.prototype = {
    'area': '',
    /**
     * Se une con otro JSON
     */
    'merge': function(options) {
        for(var k in options) {
            this.formOptions[k] = options[k];
        }
    },
    /**
     * Creacion de eventos
     */
    'crearEventos': function() {
        var form = this;
        //para mostrar el formulario
        $('#formulario-areas').bind("limpiar:errores", function() {
            $('#formulario-areas span.error').remove();
            $('#formulario-guardar-como span.error').remove();
        });
        // edita o guarda uno nuevo
        $('#formulario-areas form').bind("guardar", function() {
            var area_id = $('select#area').val();
            form.guardar(area_id, false);
        });
        // siempre guarda uno nuevo
        $('#formulario-areas form').bind("guardar:como", function() {
            //solo funciona cuando se guarda una nueva area
            form.guardar("disabled", true);
        });
        // para que copie el nombre del area del formulario guardar al campo guardar como
        $('#formulario-areas input#area_nombre').livequery("blur", function() {
            $('#formulario-guardar-como input#guardar_como_area_nombre').val($('#formulario-areas input#area_nombre').val());
        });
        // para que revise el area fin cuando hace click en area fija
        $('#area_fija_input').live("click", function() {
            if ($('#area_fija').attr("checked")){
                if (estado.area.fin.celda_inicial){
                    $('#formulario-areas li#area_fija_input span.error').remove();
                    form.adicionarError('#area_fija_input label:first', "El área tiene marcado un fin, por favor desmarque el área fin para que sea fija");
                    //return false;
                    $('#area_fija').attr("checked", false);
                }
            }
        });
        // para que abra el formulario de sinonimos en click del formulario
        $('#formulario-areas a.encabezado-sinonimos').live("click", function() {
            //solo muestra el formulario cuando hay una columna de encabezado seleccionado
            var mostrar = false, val = true;
            for (var k in estado.area.encabezado['campos']) {
                mostrar = true;
                $('#tabla-encabezado tr.' + k + ' span.error').remove();
                if (!form.validarEncabezadoCampoId(k)) {
                    form.adicionarError('#tabla-encabezado tr.' + k + ' td:last',"El nombre del campo no es válido");
                    val = false;
                }
            }
            if (mostrar && val)
                $('#formulario-sinonimos').trigger("mostrar");
        });
    },
    /**
     * Destruir eventos
     */
    'destruirEventos': function() {
        $('div#formulario-areas form').unbind("guardar");
        $('div#formulario-areas form').unbind("guardar:como");
        $('#formulario-areas').unbind("limpiar:errores");
        $('#area_fija_input').die("click");
        $('#formulario-areas input#area_nombre').expire("blur");
        $('#formulario-areas a.encabezado-sinonimos').die("click");
    },
    /**
     * Destruye el objeto
     */
    'destruir': function() {
        //limpia los datos => y pone los datos por defecto
        $('#formulario-areas input#area_nombre').val("");
        $('#formulario-areas input#area_rango').val("5");
        $('#formulario-areas input#area_fija').attr("checked", "");
        $('#formulario-areas input#area_iterar_fila_true').attr("checked", true);
        $('#formulario-areas input#area_iterar_fila_false').attr("checked", false);
        this.destruirEventos();
    },
    /**
     * guarda el area seleccionada en BD usando AJAX
     */
    'guardar': function(area_id, es_guardar_como) {

        //llena los datos restantes del formulario
        estado.area['nombre'] = $('#area_nombre').val();
        estado.area['rango'] = $('#area_rango').val();
        estado.area['iterar_fila'] = $('#area_iterar_fila_true')[0].checked;
        estado.area['fija'] = $('#area_fija')[0].checked;
        estado.area['hoja_id'] = hoja_id;
        if (this.validarDatos(area_id, es_guardar_como)){
            
            var post = area_id == 'disabled' ? '/areas' : '/areas/' + area_id;
            
            // AJAX
            var areapost = {};
            if(area_id == 'disabled') {                                                                                
                areapost = {'area': JSON.stringify(estado.area)};
                $.post(post, areapost, function(resp) {
                    // Crear
                    if(area_id == 'disabled') {
                        area_id = resp['area']['id'];
                        $('select#area').append("<option value='" + area_id + "'>" + resp["area"]["nombre"] + "</option>");
                        $('.forma_areas span.area_id').html(area_id);
                        
                        $('select#area option[value=' + area_id + ']').attr("selected", "selected");
                        $('input:hidden[name=_method]').val("put");
                        $('div#formulario-areas').append('<input type="hidden" name="_method" value="put" />');
                    }
                    if (es_guardar_como) {
                        $("#formulario-guardar-como").dialog("close");
                    }
                }, 'json');
            }else{
                // para actualizar tiene que hacer PUT
                areapost = {'area': JSON.stringify(estado.area), 'id': area_id};
                $.ajax({
                    type: "PUT",
                    url: post,
                    data: areapost,
                    success: function() {
                        //actualiza los datos del area en el combobox
                        $('select#area :selected').text(estado.area['nombre']);
                    },
                    failure: function() {
                         
                    }

                });
            }
        }else{
            if (!es_guardar_como || $('#formulario-areas .error').length > 0)
                $("#formulario-areas").dialog("open");
        }
    },
    /**
     * Valida los datos del area antes de guardarla en BD
     * @return boolean
     */
    'validarDatos': function(area_id, es_guardar_como) {
        //primero elimina los errores existentes
        $('#formulario-areas').trigger("limpiar:errores");
        
        var nombre = $('#area_nombre').val();//.trim();
        var val = true;
        if(nombre == "") {
            this.adicionarError('#area_nombre', 'El nombre no debe estar en blanco');
            val = false;
        }else if( $('select#aera option:contains(' + nombre + ')').length > 0 ) {
            this.adicionarError('#area_nombre', "El nombre ya está en uso");
            val = false;
        }
        if (! /^\d+$/.test($('#area_rango').val())){
            this.adicionarError('#area_rango',"El rango debe ser un valor numérico"); 
            val = false;
        }
        //que al menos tres campos este seleccionado
        var encabezados = 0;
        for (var k in estado.area.encabezado.campos){
            encabezados++;
            if (!this.validarEncabezadoCampoId(k)) {
                this.adicionarError('#tabla-encabezado tr.' + k + ' td:last',"El nombre del campo no es válido");
                val = false;
            }
        }
        if (encabezados < 3){
            this.adicionarError('#encabezado p:first',"Debe seleccionar al menos tres campos");
            val = false;
        }
        //que al menos un campo este seleccionado ( sólo si NO es área fija )
        if (!estado.area['fija']){
            var fin = 0;
            for (var k in estado.area.fin.campos){
                fin++;
                break
            }
            if (fin < 1){
                this.adicionarError('#fin p:first',"Debe seleccionar al menos un campo");
                val = false;
            }
        }
        
        //que no exista el nombre de esa area
        var existe = false;
        var area_nombre = $("#area_nombre").val();
        
        $('select#area option').each(function(i, el) {
            if ($(el).val() != area_id) {
                if ($(el).text().trim() == area_nombre) {
                    existe = true;
                }
            }
        });
        if (existe) {
            if (es_guardar_como)
                this.adicionarError('#guardar_como_area_nombre', 'El nombre del área ya existe');
            else
                this.adicionarError('#area_nombre', 'El nombre del área ya existe');
            val = false;
        }
        
        return val;
    },
    /**
     * Validación de nombres de campos del area encabezado
     * @param String pos #id de la celda a revisar (que tambien funciona como identificador del campo en estado.area)
     */
    'validarEncabezadoCampoId': function(pos) {
        estado.area.encabezado.campos[pos].campo = estado.area.encabezado.campos[pos].campo.trim();
        return this.validarNombreFormato(estado.area.encabezado.campos[pos].campo) && this.validarNombreUnico(estado.area.encabezado.campos, estado.area.encabezado.campos[pos].campo);
    },
    /**
     * Validación de nombres de campos del area fin
     * @param String pos #id de la celda a revisar (que tambien funciona como identificador del campo en estado.area)
     */
    'validarFinCampoId': function(pos) {
        estado.area.fin.campos[pos].campo = estado.area.fin.campos[pos].campo.trim();
        return this.validarNombreFormato(estado.area.fin.campos[pos].campo) && this.validarNombreUnico(estado.area.fin.campos, estado.area.fin.campos[pos].campo);
    },
    /**
     * Valida el formato del nombre del campo
     * @param String campoId #nombre del campo usado
     */
    'validarNombreFormato': function(campoId) {
        return (/^[a-z]\w*$/i.test(campoId));
    },
    /**
     * Valida que el nombre del campo sea unico dentro de su area
     * @param Object campos #objeto que tiene los campos seleccionados
     * @param String campoId #nombre del campo usado
     */
    'validarNombreUnico': function(campos, campoId) {
        // cuenta la cantidad de veces que aparece ese campo
        // si aparece mas de una vez quiere decir que se repite el nombre
        var cuenta = 0;
        for (var k in campos) {
            if (campos[k].campo.trim() == campoId) {
                cuenta++;
                if (cuenta > 1)
                    return false;
            }
        }
        return true;
    },
    /**
     * Adiciona mensajes de error
     * @param String id
     * @param String msj
     */
    'adicionarError': function(id, msj) {
        $(id).after("<span class='error'>" + msj + "</span>");
    },
    /**
     * Cierra el formulario y deselecciona
     */
    'cerrar': function() {
        $('div#formulario-areas').dialog("close");
    }
};
