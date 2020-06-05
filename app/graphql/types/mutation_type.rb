module Types
  class MutationType < Types::BaseObject
    field :login, mutation: Mutations::AuthMutations::LoginMutation
    field :logout, mutation: Mutations::AuthMutations::LogoutMutation
  end
end
