/**
 * Clase de menu contextual para las areas
 */
MenuContextual = function() {
    this.init();
}

MenuContextual.prototype = {
    /**
     * estilos de areas
     */
    'areas': {
        'bg-light-green': 'Desmarcar area',
        'bg-light-blue': 'Desmarcar encabezado',
        'bg-light-yellow': 'Desmarcar fin',
        'bg-light-grey': 'Desmarcar titular',
        'bg-red-color': 'Desmarcar area de descarte',
        'border-red-top': 'Desmarcar area de descarte'
    },
    /**
     * estilos de area descartar
     */
    'areasOpciones':{
        'bg-light-blue': 'Opciones area de Encabezado',
        'bg-red-color': 'Opciones area de descarte'
    },
    /**
     * Constructor
     */
    'init': function() {
        this.crearEventos();
    },
    /**
     * Crea los eventos
     */
    'crearEventos': function() {
        var context = this;
        $('.sheet-content').bind("menu:contextual", function(event, e) {
            context.crearMenu(e);
        });
        // Evento para ocultar el menu contextual
        $('body').mousedown(function(e) {
            var target = getEventTarget(e);
            if($(target).parents('div:first').attr("id") != "menu-contextual")
                $('#menu-contextual').hide();
        });
        // Para ocultar cuando se hace click en alguna opcion
        $('#menu-contextual').live("click", function(e) {
            target = getEventTarget(e);
            // formulario para descartar
            if($(target).hasClass("desc")) {
                $("#formulario-descartar").trigger("mostrar", target);
            // formulario para encabezado
            }else if($(target).hasClass("enc") ) { 
                $('#formulario-areas').dialog("open");
                $('#area-tabs').tabs('select', 1);
            }

            setTimeout(function() { $('#menu-contextual').hide(); }, 100);
        });
        // oculta menu cuando hace click
        $('body').bind("ocultar:menucontextual", function() { $('#menu-contextual').hide();});
    },
    /**
     * Destruccion de eventos
     */
    'destruirEventos': function() {
        $('.sheet-content').bind("menu:contextual");
        //$('body').unbind("mousedown");
        $('#menu-contextual').unbind("click");
    },
    /**
     * crea el menún contextual
     * @param Event e
     */
    'crearMenu': function(e) {
        var context = this;
        var target = getEventTarget(e);
        $('#menu-contextual ul li').remove();

        if ($(target).hasClass('bg-light-green')) {
            var clases = $(target).attr("class");
            var cssDesc = clases.replace(/.*(desc\d).*/, "$1");
            if(!/^desc\d$/.test(cssDesc))
                cssDesc = '';

            clases = clases.split(" ");
            $(clases).each(function(i, el) {
                // Desmarcar
                if (context.areas[el]) {
                    // En caso especial para areas desmarcar
                    var extraCss = '';
                    if(el == 'bg-red-color' || el == 'border-red-top')
                        extraCss = ' ' + cssDesc;
                        
                    $('#menu-contextual ul').append('<li><a class="context-' + el + extraCss +'"><span class="'+ el +' icon fl"></span>&nbsp;' + context.areas[el] + '</a></li>');
                }
                // Otras opciones
                if(context.areasOpciones[el]) {
                    var css = cssDesc != '' ? 'desc' : 'enc';
                    $('#menu-contextual ul').append('<li><a class="opciones-' + el + ' ' + cssDesc + ' ' + css + '"><span class="'+ el +' icon fl"></span>&nbsp;' + context.areasOpciones[el] + '</a></li>');
                }
            });
            // Posicionar menu
            $('#menu-contextual').show().css({'left': e.clientX+"px", 'top': e.clientY+"px"});
        }
    },
    /**
     * Crea el menu contextual para areas de descarte
     * @param String css
     */
    'crearMenuOpciones': function(css, opt) {
        var num = css.replace(/^desc(\d+)$/, "$1");

        $('#menu-contextual ul').append('<li><a class="context-desc desc' + num + '">Desmarcar area de descarte ' + num +  '</a></li>');
        //$('#menu-contextual ul').append('<li><a class="context-desc-opciones desc' + num + '">' + this.areas-desc. + num +  '</a></li>');
    }
}
