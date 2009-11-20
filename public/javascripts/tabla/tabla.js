// Deinida una area con una clase que agrupa 'sel'
(function($) {
    $.fn.extend({
        tablesheet: function(config) { return new $.TableSheet(this[0], config); }
    });


    $.TableSheet = function(table, config) {
        var initCell, endCell, mouseIsDown = false;

        setCellsProperties();

        /**
         * Define las propiedades iniciales de la tabla
         */
        function setCellsProperties() {
            var firstRow = true;

            for(var i = 0, l = table.rows.length; i < l; i++) {
                if(firstRow) {
                    var cols = table.rows[i].cells.length;
                    firstRow = false;
                }
                //table.rows[i].id = 'r' + i;
                for(j = 0; j < cols; j++) {
                    table.rows[i].cells[j].id = i + '_' + (j+1);
                    table.rows[i].cells[j].innerHTML = i + '_' + (j+1);
                }
            }
            console.log($(table).find("tr:eq(1) td:eq(0)").attr("id"));
            //agrega una celda al principio de cada fila, de forma que sirva de referencia para saber cuantas filas existen
            //al igual que la generación de los ids de las celdas es mejor si se hace en el servidor
            //$(table.rows).each(function(i, e){
            //    $(e).prepend('<td class="hidden_cel" id="'+i+'_0"></td>');
            //});
        }

        /**
         * Captura de selección del mouse, Inicio
         */
        $(table).mousedown(function(e) {
            initCell = getEventTarget(e);
            if (initCell.id.split('_')[0] != '0'){
                $(initCell).addClass('sel');
                mouseIsDown = true;
                createArea(initCell, initCell);
                //$(target).addClass('curr_cel');
            }
            return false;            
        });

        /**
         * Captura de selección del mouse, Fin
         */
        $(table).mouseup(function(e) {
            endCell = getEventTarget(e);
            mouseIsDown = false;
            return false;
        });

        /**
         * Captura de selección del mouse, Fin
         */
        $(table).mouseover(function(e) {
            var target = getEventTarget(e);
            if(mouseIsDown) {
                createArea(initCell, target);
                $('.curr_cel').removeClass('curr_cel');
                $(target).addClass('curr_cel');
            }
            endCell = getEventTarget(e);
            return false;            
        });

        
        function getEventTarget(e) {
            e = e || window.event;
            return e.target || e.srcElement;
        }

        /**
         * Crea un area marcando todas las celdas como seleccionadas
         */
        function createArea(c0, c1, css) {
            css = css || 'sel';
            //var row0 = $(c0).parent('tr:first')[0].rowIndex;
            //var col0 = $(c0)[0].cellIndex;
            //var row1 = $(c1).parent('tr:first')[0].rowIndex;
            //var col1 = $(c1)[0].cellIndex;
            var row0 = parseInt(c0.id.split('_')[0]);
            var col0 = parseInt(c0.id.split('_')[1]);
            var row1 = parseInt(c1.id.split('_')[0]) + (parseInt($(c1).attr('rowspan')) || 1) - 1;
            var col1 = parseInt(c1.id.split('_')[1]) + (parseInt($(c1).attr('colspan')) || 1) - 1;
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
            $('.curr_cel').removeClass('curr_cel');
            $(c0).addClass('curr_cel');
            //quita el estilo a todos los seleccionados
            $('.sel').removeClass('sel');
            //aplica el estilo a todos los elementos dentro del area
            for (var row = row0; row <= row1; row++) {
                for (var col = col0; col <= col1; col++) {
                    $('#'+row+'_'+col).addClass('sel');
                }
            }
        }

        /**
         * Une celdas en filas y columnas de una tabla, elimina
         */
        function merge() {
            // Verifica si NINGUNA de las celdas ya tiene un colspan o rowspan
            var canMerge = true;
            var unMerge = false;

            if ( $('.sel').size() > 1){
                $('.sel').each(function(i, e){
                    if ($(e).attr('rowspan')>1 || $(e).attr('colspan')>1 ){
                        canMerge = false;
                    }
                });
            }else if( $('.sel').size() > 0){
                if ($($('.sel')[0]).attr('rowspan')>1 || $($('.sel')[0]).attr('colspan')>1){
                    canMerge = false;
                    unMerge = true;
                }
            }
            if (canMerge){
                var cells = $(table).find('td.sel');
                var firstCell = $(table).find('td.sel:first');
                var colspanCells = firstCell.siblings('.sel');
                // Verifica si es colspan
                if(colspanCells.size() > 0) {
                    firstCell.attr('colspan', (colspanCells.size() + 1));
                    colspanCells.each(function(i, e) {
                        $(e).remove();
                    });
                    
                }
                // Verifica si es rowspan
                if( $('.sel').size() > 1 ) {
                    var i = firstCell.parent('tr:first')[0].rowIndex + 1;
                    var cont = 1;
                    while($(table).find('tr:eq(' + i + ') td.sel').size() > 0) {
                        cont++;
                        i++;
                    }
                    firstCell.attr('rowspan', cont).addClass('first');
                    $(table).find('td.sel:not(.first)').remove();
                    firstCell.removeClass('first');
                }
            }else if (unMerge){
                //separa las celdas combinadas
                //coloca nuevas celdas vacias
                var e = $($('.sel')[0]);
                var y = parseInt(e.attr('id').split('_')[0]);
                var x = parseInt(e.attr('id').split('_')[1]);
                var oldRowspan = parseInt(e.attr('rowspan')) || 1;
                var oldColspan = parseInt(e.attr('colspan')) || 1;
                for (var k = 0; k < oldRowspan; k++){
                    var newRowCell;
                    var start = 0;
                    if (k > 0){
                        //para las filas siguientes
                        var m = 1;
                        while ($('#'+(y+k)+'_'+(x-m)).size() < 1){
                            m++;
                        }
                        newRowCell = $('#'+(y+k)+'_'+(x-m));
                        start = 0;
                    }else{
                        //para la primera fila
                        newRowCell = e;
                        start = 1;
                    }
                    for (var i = start; i < oldColspan; i++){
                        newRowCell.after('<td id='+
                                (y+k)+'_'+(x+i)+' class="sel">'+
                                (y+k)+'_'+(x+i)+
                                '</td>');
                        newRowCell = $('#'+(y+k)+'_'+(x+i));
                    }
                    //console.log(newRowCell.attr('id'));
                    
                }
                e.removeAttr('rowspan');
                e.removeAttr('colspan');
            }

        }

        function mouseDown() {
        }

        /*
         * Hace que las celdas seleccionadas sean bold, si una de las celdas seleccionadas ya esta bold
         * les quita el estilo bold a todas
         */
        function bold(){
            if( $('.sel').size() > 0 ) {
                var agregar = true;
                $('.sel').each(function(i, e){
                    if ($(e).hasClass('bold')){
                        //si al menos un elemento esta bold, se los quita a todos los de la selección
                        agregar = false;
                    }
                });
                if (agregar)
                    $('.sel').addClass('bold');
                else
                    $('.sel').removeClass('bold');
            }
        }

        return {
            merge: merge,
            bold: bold
        }
    }
})(jQuery);
