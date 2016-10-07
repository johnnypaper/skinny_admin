require 'rails/generators'

module SkinnyAdmin
  class ControllerGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :controller_name, :type => :string
    class_option :stylesheet, :type => :boolean, :default => true, :desc => "Include stylesheet file."
    class_option :javascript, :type => :boolean, :default => true, :desc => "Include javascript file."
    class_option :index_partial, :type => :boolean, :default => false, :desc => "Include an index partial file for your controller."

    def gen_skinny_admin

      template 'controller_templates/skinny_admin_controller.rb.erb', "#{Rails.root}/app/controllers/admin/#{option_name}_controller.rb"
      template 'controller_templates/views/skinny_admin_controller_index.html.erb', "#{Rails.root}/app/views/admin/#{option_name}/index.html.erb"
      template 'controller_templates/views/skinny_admin_controller_show.html.erb', "#{Rails.root}/app/views/admin/#{option_name}/show.html.erb"
      template 'controller_templates/views/skinny_admin_controller_new.html.erb', "#{Rails.root}/app/views/admin/#{option_name}/new.html.erb"
      template 'controller_templates/views/skinny_admin_controller_edit.html.erb', "#{Rails.root}/app/views/admin/#{option_name}/edit.html.erb"
      template 'controller_templates/views/skinny_admin_controller_form.html.erb', "#{Rails.root}/app/views/admin/#{option_name}/_form.html.erb"

      if options.index_partial?
        template 'controller_templates/views/skinny_admin_controller_index_partial.html.erb', "#{Rails.root}/app/views/admin/#{option_name}/_index.html.erb"
      end

      if options.javascript?
        copy_file 'init/skinny_admin.js', "#{Rails.root}/app/assets/javascripts/admin/#{option_name}.js"
      end

      if options.stylesheet?
        copy_file 'init/skinny_admin.css', "#{Rails.root}/app/assets/stylesheets/admin/#{option_name}.css"
      end

      inject_into_file "#{Rails.root}/config/routes.rb", :after => "namespace :admin do\n" do
        "    resources :#{option_name}\n"
      end

      inject_into_file "#{Rails.root}/app/views/admin/layouts/admin.html.erb", :before => '<div class="row" style="display: none;" id="lastModel"></div>' do
        "<div class=\"col-xs-1\" style=\"text-align: center; font-size: 17px; position: relative; top: 3px;  font-family: 'PT Sans Narrow';\">\n\t\t\t\t<div><%= link_to '#{reg_name}', admin_#{option_name}_path, style: ' color: black; background-color: transparent; text-decoration: none;' %></div>\n\t\t\t</div>\n\t\t\t"
      end

    end


    private

    def option_name
      controller_name.underscore
    end

    def reg_name
      controller_name
    end

  end
end

