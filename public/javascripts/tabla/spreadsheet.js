//Creando la clase para las operaciones de las hojas del libro

(function($) {
    $.fn.extend({
        spreadsheet: function(config) { return new $.SpreadSheet(this[0], config); }
    });
    
    $.SpreadSheet= function(div_sheet, config) {
        var initCell, endCell, mouseIsDown = false;
        
        //para conocer la tabla actual
        var idhoja = "#sheet-" + config.numero;
        var idtabla = idhoja + " table.excel";
        
        initSheet(config.numero);
        
        table = $(div_sheet).find('.sheet-content table:first');
        
        function initSheet(numero){
            //saca los nombres de las columnas a un nuevo div
            var html = "<table style='width:"+ ($(idtabla).width()+15) +"px'><colgroup>";
            var content = "";
            $(idtabla + ' tr:first th').each(function(i, el) {
                html += "<col style='width:" + $(el).width() + "px' />";
                content += "<th style='width:" + $(el).width() + "px'>"+ el.innerHTML +"</th>";
            });
            html += "<col style='width:15px; padding: 0 0;' /></colgroup><tr>"+content+"<th style='width: 0px; padding: 0 0;' /></tr></table>";
            $(idtabla).before('<div id="sheet-' + numero + '-cols" class="sheet-cols">' + html + '</div>');
            
            //saca los nombres de las filas a un nuevo div
            //para que no se oculten las filas cuando NO hay contenido => copia los altos de las filas a los estilos en tr
            $(idtabla + ' tr:not(:first)').each(function(i, el) {
                $(el).css('height', $(el).height());
            });
            
            html = "<table style='height:"+ ($(idtabla).height()) +"px'>";
            $(idtabla + ' tr:not(:first)').each(function(i, el) {
                    html += "<tr style='height:" + ($(el).height()) + "px; border:0px;'><th style='padding: 0px 0px;'>"+ $(el).find('th')[0].innerHTML +"</th></tr>";
            });
            html += "</table>";
            $(idtabla).before('<div id="sheet-' + numero + '-rows" class="sheet-rows">'+html+'</div>');
            //probando una mejor forma de generar los altos de las columnas
            $('#sheet-' + numero + '-rows tr').each(function(i, e){
                //$(e).height($(idtabla + ' tr:eq(i+1)').height());
            });
            $('#sheet-' + numero + '-rows table').height($(idtabla).height());
            //coloca la tabla en un nuevo div
            $(idtabla).before('<div id="sheet-' + numero + '-content" class="sheet-content"></div>');
            $(idtabla).prependTo('#sheet-' + numero + '-content');
            $(idtabla).attr('id', 'tabla-' + numero);
           
            //ocultando las filas y columnas innecesarias
            $(idtabla + ' tr:first').hide();
            $(idtabla + ' tr:not(:first) th').hide();
            
            //haciendo los scrolls
            $('#sheet-' + numero + '-content').scroll(function(){
                $('#sheet-' + numero + '-cols').scrollLeft($('#sheet-' + numero + '-content').scrollLeft());
            });
            $('#sheet-' + numero + '-content').scroll(function(){
                $('#sheet-' + numero + '-rows').scrollTop($('#sheet-' + numero + '-content').scrollTop());
            });
            
            
            //setea los eventos para las celdas
            
        }
        
        /**
         * Captura de selección del mouse, Inicio
         */
        
        //table.live('mousedown', function(e) {
        table.mousedown(function(e) {
            initCell = getEventTarget(e);
            if (initCell.id.split('_')[1] != '0'){
                //$(idtabla).find(initCell).addClass('sel');
                $(initCell).addClass('sel');
                mouseIsDown = true;
                createArea(initCell, initCell);
            }
            return false;
        });
        
        /*
        document.body.onmousedown = function(e){
            target = e.target || e.srcElement;
            if (/^\d+_\d$/.test(target.id)){
                initCell = target;
                mouseIsDown = true;
                createArea(target, target);
            }
        }*/

        /**
         * Captura de selección del mouse, Fin
         */
        //table.live('mouseup', function(e) {
        table.mouseup(function(e) {
            endCell = getEventTarget(e);
            mouseIsDown = false;
            return false;
        });

        /**
         * Captura de selección del mouse, a medida que se mueve
         */
        //table.live('mouseover', function(e) {
        table.mouseover(function(e) {
            if (mouseIsDown) {
                var target = getEventTarget(e);
                createArea(initCell, target);
                //$(idtabla).find('.curr_cel').removeClass('curr_cel');
                $(idtabla).find('.curr_cel').removeClass('curr_cel');
                $(idtabla).find(target).addClass('curr_cel');
                endCell = getEventTarget(e);
            }
            return false;            
        });

        
        function getEventTarget(e) {
            e = e || window.event;
            return e.target || e.srcElement;
        }

        /**
         * Crea un area marcando todas las celdas como seleccionadas
         * @param DOM c0 # Objeto de celda inicial "td"
         * @param DOM c1 # Objeto de celda final "td"
         * @param String css # Clase css (opcional)
         */
        function createArea(c0, c1, css) {
            css = css || 'sel';
            var row0 = parseInt(c0.id.split('_')[1]);
            var col0 = parseInt(c0.id.split('_')[2]);
            var row1 = parseInt(c1.id.split('_')[1]) + (parseInt($(c1).attr('rowspan')) || 1) - 1;
            var col1 = parseInt(c1.id.split('_')[2]) + (parseInt($(c1).attr('colspan')) || 1) - 1;
            if (row0 > row1){
                t = row0;
                row0 = row1;
                row1 = t;
            }
            if (col0 > col1){
                t = col0;
                col0 = col1;
                col1 = t;
            }
            if (row0 <= 0) row0 = 1; //para que no seleccione la primera fila (la de los nombres de las columnas)
            table.find('.curr_cel').removeClass('curr_cel');
            //table.find(c0).addClass('curr_cel');
            $(c0).addClass('curr_cel');
            //quita el estilo a todos los seleccionados
            $(idtabla).find('.sel').removeClass('sel');
            //aplica el estilo a todos los elementos dentro del area
            for (var row = row0; row <= row1; row++) {
                for (var col = col0; col <= col1; col++) {
                    //table.find('#'+numero+'_'+row+'_'+col).addClass('sel');
                    $('#'+config.numero+'_'+row+'_'+col).addClass('sel');
                    //if (table[0].rows[row].cell[col].id)
                    //table[0].rows[row].cell[col]
                }
            }
        }
        
        function merge(){
            
        }
        
        function bold(){
            var seleccionados = table.find('.sel');
            if( seleccionados.size() > 0 ) {
                var agregar = true;
                if (table.find('.sel.bold').size() > 0){
                    agregar = false;
                }
                
                if (agregar)
                    seleccionados.addClass('bold');
                else
                    seleccionados.removeClass('bold');
            }
        }
        
        return {
            merge: merge,
            bold: bold
        }
        
    }
    
})(jQuery);

