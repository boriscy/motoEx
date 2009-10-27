# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
private

  def current_user_session  
     return @current_user_session if defined?(@current_user_session)  
     @current_user_session = UsuarioSession.find  
   end  
     
   def current_user  
     @current_user = current_user_session && current_user_session.record  
   end  

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
protected
  def adicionar_paginacion
    @page = params[:page] || 1
  end

  # Fución que permite verificar el permiso de un usuario
  def revisar_permiso
    redirect_to "/" unless current_user
  end

end
