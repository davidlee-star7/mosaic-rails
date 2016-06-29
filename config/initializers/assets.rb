# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( close.png )
Rails.application.config.assets.precompile += %w( spinner.gif )

Rails.application.config.assets.precompile += %w( fileicons/file_extension_jpg.png )
Rails.application.config.assets.precompile += %w( fileicons/file_extension_jpg.pdf )
Rails.application.config.assets.precompile += %w( fileicons/file_extension_jpg.jpg )

Rails.application.config.assets.precompile += %w(*.svg *.eot *.woff *.ttf *.gif *.png *.ico *.jpg *.pdf *.png)
Rails.application.config.assets.precompile << /\A(?!active_admin).*\.(js|css)\z/