# coding: utf-8

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Lista todos los modelos disponibles
  def list_models
    Dir.new(RAILS_ROOT + "/app/models").inject([]){|arr, v| arr << v.gsub(/\.rb$/,"") if v =~ /\.rb$/; arr}
  end

  # Outputs the corresponding flash message if any are set
  def flash_messages
    messages = ""
    flash.each do |key, msg|
      messages << content_tag(:div, link_to_function(image_tag("icons/cross.png"), "$('#flash').hide()", :class => "close", :title => t("Cerrar mensaje")) + msg , :class => key, :id => 'flash')
    end
    flash.discard
    messages
  end

  def odd_even()
    cycle("odd", "even")
  end

  def cycles(*list)
    unless list == @list
      @pos = 0
      @list = list
    end
    @pos = 0 if @pos >= @list.size
    @pos ||= 0
    @pos += 1
    list[@pos - 1]
  end

  def ext_include
    if RAILS_ENV == "development"
      path = File.join( File.expand_path(RAILS_ROOT), "public", "javascripts", "ext" )
      file = ActiveSupport::JSON.decode( File.read(File.join(path, "extjsb2") ) )

      file['pkgs'].find{|v| v['file'] == 'ext-all.js'}['pkgDeps'].inject(""){|js , v|
        js << %(<script type="text/javascript" src="/javascripts/ext/#{v}"></script>)
      }
    else
      %(<script type="text/javascript" src="/javascripts/ext/ext-all.js"></script>)
    end
  end

  # Presenta el menu en caso de que el usuario se haya loguado
  def mostrar_menu
    if session['usuario_credentials']
      %Q(<ul id="navigation">
        <li><a href="/usuarios" class="ui-state-default">Usuarios</a></li>
        <li><a href="/archivos" class="ui-state-default">Archivos</a></li>
        <li><a href="#{password_usuario_path(1)}" class="ui-state-default">Cambiar contraseña</a></li>
        <li><a href="/logout" class="ui-state-default">Salir</a></li>
      </ul>)
    end
  end

end

#ActionView::Helpers::FormBuilder.class_eval do
#  def error_messages(options = {})
#    unless @object.errors.empty?
#      text = "<h2>#{I18n.t 'activerecord.errors.template.body'}</h2>"
#      text << "<p class=\"red b\">#{I18n.t 'activerecord.errors.template.text'}</p>"
#      @template.content_tag(:div, text, :class => "errorExplanation", :id => "errorExplanation")
#    end
#  end
#end
#
## Cambia la forma de presentar los errores
#ActionView::Base.field_error_proc = Proc.new do |html_tag, instance| 
#  unless html_tag =~ /^<label/ 
#    if instance.error_message.kind_of?(Array)
#      text = %(#{html_tag}<span class="validation-error"> #{instance.error_message.join(',')}</span>)
#    else  
#      text = %(#{html_tag}<span class="validation-error"> #{instance.error_message}</span>) 
#    end
#    %(<div class="fieldWithErrors">#{text}</div>)
#  else
#    html_tag
#  end
#end 
#
