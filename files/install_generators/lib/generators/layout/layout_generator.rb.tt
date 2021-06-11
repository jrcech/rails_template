class LayoutGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def copy_initializer_file
    template 'app/controllers/layout_controller.rb.tt',
             "app/controllers/#{file_name}/#{file_name}_controller.rb"
    template 'app/views/layouts/layout.html.slim.tt',
             "app/views/layouts/#{file_name}.html.slim"
  end
end
