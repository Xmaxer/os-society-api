module Types
  class MutationType < Types::BaseObject
    field :login, mutation: Mutations::AuthMutations::LoginMutation
    field :logout, mutation: Mutations::AuthMutations::LogoutMutation
    field :player, mutation: Mutations::PlayerMutations::PlayerMutation
    field :delete_player, mutation: Mutations::PlayerMutations::DeletePlayerMutation
  end
end
