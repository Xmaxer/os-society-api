module Types
  class MutationType < Types::BaseObject
    field :deletePlayer, mutation: Mutations::PlayerMutations::DeletePlayer
    field :createPlayer, mutation: Mutations::PlayerMutations::CreatePlayer
    field :updatePlayer, mutation: Mutations::PlayerMutations::UpdatePlayer
    field :login, mutation: Mutations::AuthMutations::Login
    field :logout, mutation: Mutations::AuthMutations::Logout
    field :updateUser, mutation: Mutations::UserMutations::UpdateUser
    field :createCompetition, mutation: Mutations::CompetitionMutations::CreateCompetition
    field :updateCompetition, mutation: Mutations::CompetitionMutations::UpdateCompetition
    field :deleteCompetition, mutation: Mutations::CompetitionMutations::DeleteCompetition
    field :createCompetitionRecord, mutation: Mutations::CompetitionRecordMutations::CreateCompetitionRecord
    field :updateCompetitionRecord, mutation: Mutations::CompetitionRecordMutations::UpdateCompetitionRecord
    field :deleteCompetitionRecord, mutation: Mutations::CompetitionRecordMutations::DeleteCompetitionRecord
    field :createPayout, mutation: Mutations::PayoutMutations::CreatePayout
    field :updatePayout, mutation: Mutations::PayoutMutations::UpdatePayout
    field :deletePayout, mutation: Mutations::PayoutMutations::DeletePayout
  end
end
