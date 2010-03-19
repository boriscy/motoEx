# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :adicionar_paginacion
  helper_method :current_user, :admin?
  filter_parameter_logging :password, :password_confirmation

  # Permite presentar en un layout AJAX automaticamente
  layout lambda{|c| c.request.xhr? ? false : "application" }
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

   def admin?
     current_user.rol == 'admin'
   end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
protected
  def adicionar_paginacion
    @page = params[:page] || 1
  end

  # Fución que permite verificar el permiso de un usuario
  def revisar_permiso
    redirect_to "/login" unless current_user
  end

end
