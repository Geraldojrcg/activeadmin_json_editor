#-*- encoding: utf-8; tab-width: 2 -*-
require 'activeadmin/json_editor/version'
require 'activeadmin/resource_dsl'

module ActiveAdmin
  module JsonEditor
    class Engine < ::Rails::Engine
      if config.respond_to?(:assets)
        # Old Rails 6 behavior
        config.assets.precompile += %w(img/jsoneditor-icons.png)
      else
        # Rails 7 workaround: Use app.config instead
        Rails.application.config.assets.precompile += %w(img/jsoneditor-icons.png)
      end

      rake_tasks do
        task 'assets:precompile' do
          fingerprint = /\-[0-9a-f]{32}\./
          Dir['public/assets/img/jsoneditor-icons-*'].each do |file|
            next unless file =~ fingerprint
            nondigest = file.sub fingerprint, '.'
            FileUtils.cp file, nondigest, verbose: true
          end
        end
      end
    end
  end
end
