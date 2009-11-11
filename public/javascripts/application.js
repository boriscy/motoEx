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
    success : function(event){
      $('#cargando').hide(1000);
    }
  });

});

