module Types
  class MutationType < Types::BaseObject
    field :deletePlayer, mutation: Mutations::PlayerMutations::DeletePlayer
    field :createPlayer, mutation: Mutations::PlayerMutations::CreatePlayer
    field :updatePlayer, mutation: Mutations::PlayerMutations::UpdatePlayer
    field :login, mutation: Mutations::AuthMutations::LoginMutation
    field :logout, mutation: Mutations::AuthMutations::LogoutMutation
    field :updateUser, mutation: Mutations::UserMutations::UpdateUser
  end
end
