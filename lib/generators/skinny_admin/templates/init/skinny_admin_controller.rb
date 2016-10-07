# noinspection ALL
class SkinnyAdminController < ApplicationController

  before_action :validate_admin_user

  layout 'admin/layouts/admin'

  # Configure validate_admin_user to your liking...The method is set upon Devise or a User Class
  # Methods user_signed_in? (Devise) and a Boolean is_admin column to Validate Admin User.

  # If you need levels of Admin or Restricted Admin Usage, you need another column in your DB
  # simply setting certain levels and testing against those levels in the individual admin controllers
  # located in app/controllers/admin/your_controller.rb

  # Please see website documentation for more information at http://skinnyadmin.org

  def validate_admin_user
    if user_signed_in? && current_user.is_admin?
    else
      redirect_to :root
    end
  end

end