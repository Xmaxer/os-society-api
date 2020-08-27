module Types
  module PayoutTypes
    class PayoutType < BaseObject
      description "All the possible payout data"
      field :id, ID, null: false, description: "The unique ID of the payout"
      field :amount, GraphQL::Types::BigInt, null: false, description: "The amount paid out"
      field :user, Types::UserTypes::UserType, null: false, description: "The user that paid it"
    end
  end
end
