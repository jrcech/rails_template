namespace :pagy do
  task link_module: :environment do
    FileUtils.ln_sf(
      Pagy.root.join('javascripts', 'pagy-module.js'),
      Rails.root.join('app/javascript/vendor')
    )
  end
end
