require 'rails/generators'

module SkinnyAdmin
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    class_option :stylesheet, :type => :boolean, :default => true, :desc => "Include stylesheet file."
    class_option :javascript, :type => :boolean, :default => true, :desc => "Include javascript file."

    def gen_skinny_admin

      empty_directory "#{Rails.root}/app/controllers/admin"
      empty_directory "#{Rails.root}/app/views/admin"
      empty_directory "#{Rails.root}/app/views/admin/layouts"
      empty_directory "#{Rails.root}/app/views/admin/dashboard"
      empty_directory "#{Rails.root}/app/assets/stylesheets/admin"
      empty_directory "#{Rails.root}/app/assets/javascripts/admin"

      copy_file 'init/skinny_admin_controller.rb', "#{Rails.root}/app/controllers/skinny_admin_controller.rb"
      copy_file 'init/skinny_admin_layout.html.erb', "#{Rails.root}/app/views/admin/layouts/admin.html.erb"
      copy_file 'init/dashboard.rb', "#{Rails.root}/app/controllers/admin/dashboard_controller.rb"
      copy_file 'init/dashboard.html.erb', "#{Rails.root}/app/views/admin/dashboard/index.html.erb"

      if options.javascript?
        copy_file 'init/skinny_admin.js', "#{Rails.root}/app/assets/javascripts/admin/admin_layout.js"
        copy_file 'init/skinny_admin.js', "#{Rails.root}/app/assets/javascripts/admin/dashboard.js"
      end

      if options.stylesheet?
        copy_file 'init/skinny_admin.css', "#{Rails.root}/app/assets/stylesheets/admin/admin_layout.css"
        copy_file 'init/skinny_admin.css', "#{Rails.root}/app/assets/stylesheets/admin/dashboard.css"
      end

      inject_into_file "#{Rails.root}/config/initializers/assets.rb", :after => "# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.\n" do
        "Rails.application.config.assets.precompile += %w( admin/*.js admin/*.css )\n"
      end

      inject_into_file "#{Rails.root}/app/assets/stylesheets/application.css", :after => "*= require_self\n" do
        " *= require_tree ./admin\n"
      end

      route "namespace :admin do\n    get '/' => 'dashboard#index', as: 'dashboard'\n  end\n"

      inject_into_file "#{Rails.root}/app/views/admin/layouts/admin.html.erb", :before => '<div class="row" style="display: none;" id="lastModel"></div>' do
        "<div class=\"col-xs-1\" style=\"text-align: center; font-size: 17px; position: relative; top: 3px;  font-family: 'PT Sans Narrow';\">\n\t\t\t\t<div><%= link_to 'Dashboard', admin_dashboard_path, style: ' color: black; background-color: transparent; text-decoration: none;' %></div>\n\t\t\t</div>\n\t\t\t"
      end

    end

  end
end

