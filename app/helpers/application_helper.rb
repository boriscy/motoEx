# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Lista todos los modelos disponibles
  def list_models
    Dir.new(RAILS_ROOT + "/app/models").inject([]){|arr, v| arr << v.gsub(/\.rb$/,"") if v =~ /\.rb$/; arr}
  end

  # Presenta las opciones de un modelo
  def models_options
    ([""] + list_models).map{|v| "<option value=\"#{v}\">#{v.classify}</option>"}.join("")
  end

  def col_types(type)
    case type
      when "number" then ["integer", "decimal", "float"]
      when "date" then ["date", "datetime", "time"]
    end
  end

  # Presenta el texto para presentar una columna
  def show_col(col)
    if [].include? col.sql_type and !(col.name =~ /_id$/)
      cl = 'class=num'
    end
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

end

ActionView::Helpers::FormBuilder.class_eval do
  def error_messages(options = {})
    unless @object.errors.empty?
      text = "<h2>#{I18n.t 'activerecord.errors.template.body'}</h2><p>#{I18n.t 'activerecord.errors.template.text'}</p>"
      @template.content_tag(:div, text, :class => "errorExplanation", :id => "errorExplanation")
    end
  end
end

# Cambia la forma de presentar los errores
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance| 
  unless html_tag =~ /^<label/ 
    if instance.error_message.kind_of?(Array)
      text = %(#{html_tag}<span class="validation-error"> #{instance.error_message.join(',')}</span>)
    else  
      text = %(#{html_tag}<span class="validation-error"> #{instance.error_message}</span>) 
    end
    %(<div class="fieldWithErrors">#{text}</div>)
  else
    html_tag
  end
end 

