require 'mv/core/db/migration_validator'
require 'mv/core/migration/operations/list'
require 'mv/core/migration/operations/factory'

module Mv
  module Core
    module Migration
      class Base
        include Singleton

        SUPPORTED_METHODS = %i{ add_column remove_column rename_column 
                                change_column rename_table drop_table}

        attr_reader :operations_list, :operations_factory
        
        def initialize()
          @operations_list = Mv::Core::Migration::Operations::List.new
          @operations_factory = Mv::Core::Migration::Operations::Factory.new()
        end

        SUPPORTED_METHODS.each do |operation_name|
          define_method operation_name do |*args|

            operation = operations_factory.create_operation(operation_name, *args)
            operations_list.add_operation(operation)
          end
        end

        def execute
          operations_list.execute()
        end

        class << self
          alias_method :current, :instance

          delegate *[SUPPORTED_METHODS, :execute].flatten, to: :current, allow_nil: true
        end
      end
    end
  end
end