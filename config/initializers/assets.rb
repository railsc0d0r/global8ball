# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Creates RailsUpload-folder, if it doesn't exist
RailsUpload.setup

# Set paperclip to use this folder
Paperclip::Attachment.default_options[:path] = "#{RailsUpload.folder_path}/:class/:attachment/:id_:style_:filename"
Paperclip::Attachment.default_options[:url] = "#{RailsUpload.base_url}/:class/:attachment/:id_:style_:filename"

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( bootstrap.css.map )
Rails.application.config.assets.precompile += %w( game/*.js )
