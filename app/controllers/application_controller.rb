class ApplicationController < ActionController::Base
  before_action :authenticate_admin!, if: :admin_url
  
  def admin_url
    request.fullpath.include?("/admin")
  end
  
  def after_sign_in_path_for(resource)
    case resource
    when Customer
      root_path
    when Admin
      admin_products_path
    end
  end
  
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      new_customer_session_path
    end
  end

end

