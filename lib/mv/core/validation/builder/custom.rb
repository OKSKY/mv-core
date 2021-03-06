require_relative 'base'

module Mv
  module Core
    module Validation
      module Builder
        class Custom < Base
          delegate :statement, to: :validation

          def conditions
            [{
              statement: apply_allow_nil_and_blank("(#{preprocess_statement})"),
              message: message
            }]
          end

          private

          def preprocess_statement
            statement.gsub(/\{\s*#{column_name}\s*\}/, column_reference.to_s)
          end
        end
      end
    end
  end
end
