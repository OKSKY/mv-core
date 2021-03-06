require 'mv/core/services/uninstall'
require 'mv/core/services/delete_constraints'
require 'mv/core/services/create_constraints'
require 'mv/core/services/show_constraints'
require 'mv/core/services/create_migration_validators_table'

module Mv
  module Core
    class Railtie < ::Rails::Railtie
      rake_tasks do
        namespace :mv do
          task :uninstall => :environment  do
            STDOUT.puts "Uninstall is irreversible operation. All constraints descriptions and declarations will be removed. 
                         You will have to either load schema or re - run all migrations to restore that info. Please enter YES if you want to continue anyway: ".squish

            if STDIN.gets.chomp == "YES"
              Mv::Core::Services::Uninstall.new.execute
            end
          end

          task :install => :environment  do
            Mv::Core::Services::CreateMigrationValidatorsTable.new.execute
          end

          task :show_constraints, [:tables] => :environment do |task, args|
            Mv::Core::Services::ShowConstraints.new((args[:tables] || '').split(/\s+/)).execute
          end

          task :delete_constraints, [:tables] => :environment do |task, args|
            Mv::Core::Services::DeleteConstraints.new((args[:tables] || '').split(/\s+/)).execute
          end

          task :create_constraints, [:tables] => :environment do |task, args|
            Mv::Core::Services::CreateConstraints.new((args[:tables] || '').split(/\s+/)).execute
          end
        end
      end 
    end
  end
end
