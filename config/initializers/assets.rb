# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Creates RailsUpload-folder, if it doesn't exist
RailsUpload.setup

# Set paperclip to use this folder
Paperclip::Attachment.default_options[:path] = "#{RailsUpload.folder_path}/:class/:attachment/:id_:style_:filename"
Paperclip::Attachment.default_options[:url] = "#{RailsUpload.base_url}/:class/:attachment/:id_:style_:filename"

ember_build_folder = Rails.root.join("tmp", "ember-cli","apps").to_s

# Add additional assets to the asset load path
Rails.application.config.assets.paths << ember_build_folder

# Precompile ember-apps
Rails.application.config.assets.precompile << Proc.new do |path|
  if path =~ /\.(html|map|xml|txt|css|js||eot|ttf|woff|fnt|svg|appcache|json)\z/
    full_path = Rails.application.assets.resolve(path)
    app_assets_path = ember_build_folder
    full_path.starts_with?(app_assets_path) ? true : false
  else
    false
  end
end

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( bootstrap.css.map )
Rails.application.config.assets.precompile += %w( game/*.js )
