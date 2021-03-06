require_relative 'index'
require_relative 'trigger'

module Mv
  module Core
    module Constraint
      module Builder
        class Factory
          include Singleton

          def create_builder constraint
            factory_map[constraint.class].new(constraint)
          end

          def register_builder constraint_class, builder_class
            factory_map[constraint_class] = builder_class
          end

          def register_builders opts
            opts.each do |constraint_class, builder_class|
              register_builder(constraint_class, builder_class)
            end
          end

          class << self
            delegate :create_builder, :register_builder, :register_builders, to: :instance
          end


          private

          def factory_map
            @factory_map ||= {
              Mv::Core::Constraint::Index => Mv::Core::Constraint::Builder::Index,
              Mv::Core::Constraint::Trigger => Mv::Core::Constraint::Builder::Trigger
            }
          end
        end
      end
    end
  end
end
