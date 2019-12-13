# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( forms.js )
Rails.application.config.assets.precompile += %w( forms_engine.js )
Rails.application.config.assets.precompile += %w( forms_parent.js )
Rails.application.config.assets.precompile += %w( forms_tutor.js )
Rails.application.config.assets.precompile += %w( forms.css )
Rails.application.config.assets.precompile += %w( admin.js )
Rails.application.config.assets.precompile += %w( admin.css )
Rails.application.config.assets.precompile += %w( welcome.css )
Rails.application.config.assets.precompile += %w( welcome.js )
Rails.application.config.assets.precompile += %w( teacherforms.js )
Rails.application.config.assets.precompile += %w( forms_engine.js )
Rails.application.config.assets.precompile += %w( display_matches.css )
Rails.application.config.assets.precompile += %w( display_database.css )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
