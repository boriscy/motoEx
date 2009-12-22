FormularioDescartarExcepciones = function() {
    this.init();
}

FormularioDescartarExcepciones.prototype = {
    'cssSel': 'seleccionado',
    /**
     * Constructor
     */
    'init': function() {
        $("#formulario-descartar-excepciones").dialog({
            'close': function(e, ui) {
                $("#formulario-descartar-excepciones").trigger("form:close");
            },
            'beforeclose': function(e, ui) {
                $("#formulario-descartar-excepciones").trigger("form:beforeclose");
            },
            'width': 350, 
            'height': 250, 
            'resizable': false,
            'title': 'Excepciones',
            'autoOpen': false
        });
        this.crearEventos();
    },
    /**
     * Eventos
     */
    'crearEventos': function() {
        var form = this;
        $("#formulario-descartar-excepciones").bind("form:close", function() {
            form.agregarExcepcion();
        });
        $("#formulario-descartar-excepciones").bind("form:beforeclose", function() {
            
        });
        $('#formulario-descartar .excepciones input:button').click(function() {
            //agrega las columnas del area
            form.crearGrupoExcepcion();
            
            form.actualizarFormulario();

            //muestra el formulario de seleccion de columnas
            $("#formulario-descartar-excepciones").dialog("open");

        });
        $('#formulario-descartar .excepciones-listado a.borrar-excepcion').live("click", function(e) {
            var target = getEventTarget(e);
            $('#area-descartar').trigger("descartar:crear:exepcion");
            form.borrarExcepcion(target);
        });
        $('li.adicionar-excepcion a').live("click", function() {
            $('#grupo-excepciones ul.grupo-excepcion').removeClass(form.cssSel);
            $(this).parents("ul").addClass(form.cssSel);
            form.actualizarFormulario();

            $("#formulario-descartar-excepciones").dialog("open");
        });
        $('li.excepcion a.borrar-excepcion').live("click", function() {
            form.borrarExcepcion($(this).parents("li"));
        });
        
        $('#area-descartar').bind("cargar:excepciones", function() {
            form.cargarExcepciones();
        });
    },
    /**
     * actualizar el formulario dependiendo del patron
     * @param Object values # Hash con los valores seleccionados en la excepcion
     */
    'actualizarFormulario': function() {
        var values = this.buscarValores();
        $('#formulario-descartar-excepciones select option').remove();
        var html = "<option value=''>Columna</option>";
        $('#select-columnas option').each(function (i, el) {
            if (!$(el).attr("disabled")){
                var col = $(el).attr("class").split('_')[2];
                html += "<option value='" + col + "'";
                if (values[col])
                    html += " disabled='disabled' ";
                html += ">Columna " + numExcelCol(col) + "</option>";
            }
        });
        $('#formulario-descartar-excepciones select').append(html);
        $('#formulario-descartar-excepciones input:text').val('');
    },
    /**
     * busca el listado de excepciones del grupo seleccionado
     * @return 
     */
    'buscarValores': function() {
        var values = {};
        $("#grupo-excepciones ." + this.cssSel + " li.excepcion").each(function(i, el) {
            values[$(el).find("span.col").text().trim()] = true;
        });
        return values;
    },
    /**
     * Crea un Grupo para las excepciones (ul)
     */
    'crearGrupoExcepcion': function() {
        $('#grupo-excepciones ul.grupo-excepcion').removeClass(this.cssSel);
    },
    /**
     * Agrega una excepcion al grupo seleccionado
     */
    'agregarExcepcion': function() {
        if($('#formulario-descartar-excepciones').dialog('isOpen') ) {
            if ($("#select-excepciones").val()){
                var col = $("#select-excepciones").val();
                var texto = $("#texto-excepciones").val();
                this.crearHtmlExcepcion(col, texto);
            }
        }
    },
    /**
     * crea el HTML necesario para las excepciones
     */
    'crearHtmlExcepcion': function(col, texto) {
          if( $('#grupo-excepciones ul.' + this.cssSel).length <= 0 ) {
              var html = "<ul class='grupo-excepcion " + this.cssSel + "'><li class='adicionar-excepcion'><a>Adicionar</a></li></ul>";
              $('#grupo-excepciones').append(html);
          }
          var html = "<li class='excepcion'>";
          html += "<span class='col' style='display:none'>" + col + "</span>";
          html += "(" + numExcelCol(col) + ") ";
          html += "<span class='texto'>" + texto + "</span>";
          html += " <a class='borrar-excepcion'>borrar</a></li>";
          $("#grupo-excepciones ." + this.cssSel).append(html);
    },
    /**
     * Borra una excepcion
     */
    'borrarExcepcion': function(li) {
        var $li = $(li);
        if ($li.siblings("li.excepcion").length <= 0){
            $li.parents("ul").remove();
        }else{
            $li.remove();
        }
    },
    /**
     * Carga las excepciones desde la variable de estado
     */
    'cargarExcepciones': function() {
        var area = $('#id-descartar').val();
        var excepciones = estado.area.descartar[area].excepciones;
        for(var k in excepciones) {
            $('#grupo-excepciones ul.grupo-excepcion').removeClass(this.cssSel);
            for(var l in excepciones[k]) {
                this.crearHtmlExcepcion(excepciones[k][l].pos, excepciones[k][l].texto);
            }
        }
    }
}
