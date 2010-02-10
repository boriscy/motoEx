// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
/*********************************************/
/**jQuery**/
$(document).ready(function() {
  $('a.delete').live("click", function() {
    var item = $(this).parents("li,tr").addClass("markedForDelete");
    var uri = $(this).attr("href");
    if(confirm("Esta seguro de borrar?")){
      $.post( uri, {_method: 'delete', authenticity_token: token}, function(resp) {
        item.remove();
      });
      item.removeClass("markedForDelete");
    }else{
      item.removeClass("markedForDelete");
    }
    return false;
  });

  xhrResponseText = "";
  function cargarError() {
    $('#cont-iframe').contents().find("body").html(xhrResponseText);
  }

  var environment = "<%= RAILS_ENV %>";

  $.ajaxSetup ({
    type : "GET",
    dataType : "html",
    beforeSend : function (xhr) {
      //$('#cargando').show();
    },
    error : function(event){
      xhrResponseText = event.responseText;
      $('#cargando').hide(1000);
      if(environment == "production") {
        alert("Existio un error");
      }else{
        if($("#debug-error").hasClass("ui-dialog-content")) {
          $("#debug-error").dialog('open');
        }else{
          $("#debug-error").dialog({width: 800, height: 600});
        }
        setTimeout(function(){cargarError(event)}, 200);
      }
    },
    complete : function(event){
      $('#cargando').hide(1000);
    },
    success : function(event) {
      $('#cargando').hide(1000);
    }
  });

  /**
   * Funcion que devuelve serializado como JSON los elementos de un formulario
   */
  $.fn.extend({
    hashify: function() {
      var hash = {};
      $(this).find('input, select, textarea').each(function(i, el){
        if($(el).attr("type") != "submit")
          hash[$(el).attr("name")] = $(el).val();
      });
      return hash;
    }
  });

});

/**************/
/**
 * Convierte un numero a una columna similar de un spreadsheet
 * @param Integer num
 */
function numExcelCol(num) {
  return (( ( parseInt((num-1)/26)>=1) ? String.fromCharCode( parseInt((num-1)/26)+64): '') + String.fromCharCode((num-1)%26+65));
}
function celdaExcel(pos) {
  var p = pos.split("_");
  if(p.length > 2)
      return numExcelCol( parseInt(p[2]) ) + p[1];
  else if(p.length == 2)
      return numExcelCol( parseInt(p[1]) ) + p[0];
}

/**
 * Obtiene el DOM que genero el evento
 */
function getEventTarget(e) {
    e = e || window.event;
    return e.target || e.srcElement;
}


/**
 * Herencia
 * Debe estar antes de los prototype de otras clases
 */
// Inspired by base2 and Prototype

(function(){
  var initializing = false, fnTest = /xyz/.test(function(){xyz;}) ? /\b_super\b/ : /.*/;

  // The base Class implementation (does nothing)
  this.Class = function(){};
 
  // Create a new Class that inherits from this class
  Class.extend = function(prop) {
    var _super = this.prototype;
   
    // Instantiate a base class (but only create the instance,
    // don't run the init constructor)
    initializing = true;
    var prototype = new this();
    initializing = false;
   
    // Copy the properties over onto the new prototype
    for (var name in prop) {
      // Check if we're overwriting an existing function
      prototype[name] = typeof prop[name] == "function" &&
        typeof _super[name] == "function" && fnTest.test(prop[name]) ?
        (function(name, fn){
          return function() {
            var tmp = this._super;
           
            // Add a new ._super() method that is the same method
            // but on the super-class
            this._super = _super[name];
           
            // The method only need to be bound temporarily, so we
            // remove it when we're done executing
            var ret = fn.apply(this, arguments);       
            this._super = tmp;
           
            return ret;
          };
        })(name, prop[name]) :
        prop[name];
    }
   
    // The dummy class constructor
    function Class() {
      // All construction is actually done in the init method
      if ( !initializing && this.init )
        this.init.apply(this, arguments);
    }
   
    // Populate our constructed prototype object
    Class.prototype = prototype;
   
    // Enforce the constructor to be what we expect
    Class.constructor = Class;

    // And make this class extendable
    Class.extend = arguments.callee;
   
    return Class;
  };
})();


/**
 * Extensiones a clases
 * Debe ir despues de Class
 */
String.prototype.trim = function() {
    return this.replace(/^\s+|\s+$/g,"");
}
String.prototype.ltrim = function() {
    return this.replace(/^\s+/,"");
}
String.prototype.rtrim = function() {
    return '';this.replace(/\s+$/,"");
}
/*
Object.prototype.countVals = function() {
    var cont = 0;
    for(var k in this) {
        cont++;
    }
    return cont;
}
*/
function isArray(value){
  return Object.prototype.toString.apply(value) === '[object Array]';
}


