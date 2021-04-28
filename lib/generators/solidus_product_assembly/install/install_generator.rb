# frozen_string_literal: true

module SolidusProductAssembly
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false
      source_root File.expand_path('templates', __dir__)

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/backend/all.js', "//= require spree/backend/solidus_product_assembly\n"
      end

      def add_migrations
        run 'bin/rails railties:install:migrations FROM=solidus_product_assembly'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask('Would you like to run the migrations now? [Y/n]')) # rubocop:disable Layout/LineLength
        if run_migrations
          run 'bin/rails db:migrate'
        else
          puts 'Skipping bin/rails db:migrate, don\'t forget to run it!' # rubocop:disable Rails/Output
        end
      end
    end
  end
end
