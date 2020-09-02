module Types
  class MutationType < Types::BaseObject
    field :deletePlayer, mutation: Mutations::PlayerMutations::DeletePlayerMutation
    field :createPlayer, mutation: Mutations::PlayerMutations::CreatePlayerMutation
    field :updatePlayer, mutation: Mutations::PlayerMutations::UpdatePlayerMutation
    field :login, mutation: Mutations::AuthMutations::LoginMutation
    field :logout, mutation: Mutations::AuthMutations::LogoutMutation
    field :updateUser, mutation: Mutations::AuthMutations::ResetPasswordMutation
    field :createCompetition, mutation: Mutations::CompetitionMutations::CreateCompetitionMutation
    field :updateCompetition, mutation: Mutations::CompetitionMutations::UpdateCompetitionMutation
    field :deleteCompetition, mutation: Mutations::CompetitionMutations::DeleteCompetitionMutation
    field :createCompetitionRecord, mutation: Mutations::CompetitionRecordMutations::CreateCompetitionRecordMutation
    field :updateCompetitionRecord, mutation: Mutations::CompetitionRecordMutations::UpdateCompetitionRecordMutation
    field :deleteCompetitionRecord, mutation: Mutations::CompetitionRecordMutations::DeleteCompetitionRecordMutation
    field :createPayout, mutation: Mutations::PayoutMutations::CreatePayoutMutation
    field :updatePayout, mutation: Mutations::PayoutMutations::UpdatePayoutMutation
    field :deletePayout, mutation: Mutations::PayoutMutations::DeletePayoutMutation
  end
end
