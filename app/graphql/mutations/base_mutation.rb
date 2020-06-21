module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def model_errors(model)
      model.errors.each do |attr, error|
        context.add_error(GraphQL::ExecutionError.new(error, extensions: {field: attr}))
      end
    end

  end
end
