def login_mutation(username, password)
  {
      query: <<~GQL,
            mutation Login($username: String!, $password: String!){
          login(input: {attributes: {username: $username password: $password}}) {
            token
            user {
              username
              id
              resetPassword
            }
          }
        }
      GQL
      variables: {username: username, password: password}
  }
end

def logout_mutation
  {
      query: <<~GQL,
                    mutation {
          logout(input: {}) {
            success
          }
        }
      GQL
  }
end

def reset_password_mutation(id, password)
  {
      query: <<~GQL,
              mutation User($id: ID!, $password: String!){
          updateUser(input: {attributes: {password: $password}, id: $id}) {
            user {
              id
              username
              resetPassword
            }
          }
        }
      GQL
      variables: {password: password, id: id}
  }
end

def create_competition_mutation(external_url = nil)
  {
      query: <<~GQL,
                      mutation CreateCompetition($externalUrl: String){
          createCompetition(input: {attributes: {externalUrl: $externalUrl}}){
            competition {
                  competitionRecords {
                    id
                    xp
                    position
                    payout {
                      id
                      amount
                      user {
                        id
                        username
                      }
                    }
                    player {
                      id
                      username
                    }
                  }
            externalUrl
            id
            }
          }
        }
      GQL
      variables: {externalUrl: external_url}
  }
end

def update_competition_mutation(external_url = nil, id)
  {
      query: <<~GQL,
                            mutation UpdateCompetition($externalUrl: String, $id: ID!){
        updateCompetition(input: {attributes: {externalUrl: $externalUrl}, id: $id}){
          competition {
            competitionRecords {
                  id
                  xp
                  position
                  payout {
                    id
                    amount
                    user {
                      id
                      username
                    }
                  }
                  player {
                    id
                    username
                  }
                }
          externalUrl
          id
          }
          }
        }
      GQL
      variables: {externalUrl: external_url, id: id}
  }
end

def delete_competition_mutation(id)
  {
      query: <<~GQL,
                                 mutation DeleteCompetition($id: ID!){
          deleteCompetition(input: {id: $id}){
            competition {
                    competitionRecords {
                    id
                    xp
                    position
                    payout {
                      id
                      amount
                      user {
                        id
                        username
                      }
                    }
                    player {
                      id
                      username
                    }
                  }
            externalUrl
            id
            }
          }
        }
      GQL
      variables: {id: id}
  }
end

def create_competition_record_mutation(xp, position, player_id, competition_id)
  {
      query: <<~GQL,
                                         mutation CompetitionRecord($xp: BigInt!, $position: BigInt!, $playerId: ID!, $competitionId: ID!){
          createCompetitionRecord(input: {attributes: {xp: $xp, position: $position, playerId: $playerId, competitionId: $competitionId}}){
            competitionRecord {
              id
              position
              xp
              player {
                id
                username
              }
              payout {
                id
                amount
                user {
                  id
                  username
                }
              }
            }
          }
        }
      GQL
      variables: {xp: xp, position: position, playerId: player_id, competitionId: competition_id}
  }
end

def update_competition_record_mutation(id, xp, position, player_id, competition_id)
  {
      query: <<~GQL,
                                                 mutation CompetitionRecord($xp: BigInt!, $position: BigInt!, $playerId: ID!, $competitionId: ID!, $id: ID!{
          updateCompetitionRecord(input: {id: $id ,attributes: {xp: $xp, position: $position, playerId: $playerId, competitionId: $competitionId}}){
            competitionRecord {
              id
              position
              xp
              player {
                id
                username
              }
              payout {
                id
                amount
                user {
                  id
                  username
                }
              }
            }
          }
        }
      GQL
      variables: {id: id, xp: xp, position: position, playerId: player_id, competitionId: competition_id}
  }
end

def delete_competition_record_mutation(id)
  {
      query: <<~GQL,
                             mutation CompetitionRecord($id: ID!){
          deleteCompetitionRecord(input: {id: $id }){
            competitionRecord {
              id
              position
              xp
              player {
                id
                username
              }
              payout {
                id
                amount
                user {
                  id
                  username
                }
              }
            }
          }
        }
      GQL
      variables: {id: id}
  }
end

def create_payout_mutation(amount, paid_by_id, competition_record_id)
  {
      query: <<~GQL,
                                     mutation Payout($amount: Int!, $paidById: ID!, $competitionRecordId: ID!){
          createPayout(input: {attributes: {amount: $amount, paidById: $paidById, competitionRecordId: $competitionRecordId}}) {
            payout {
              id
              amount
              user {
                id
                username
              }
            }
          }
        }
      GQL
      variables: {amount: amount, paidById: paid_by_id, competitionRecordId: competition_record_id}
  }
end

def update_payout_mutation(id, amount, paid_by_id, competition_record_id)
  {
      query: <<~GQL,
                                             mutation Payout($amount: Int!, $paidById: ID!, $competitionRecordId: ID!, $id: ID!){
          updatePayout(input: {id: $id, attributes: {amount: $amount, paidById: $paidById, competitionRecordId: $competitionRecordId}}) {
            payout {
              id
              amount
              user {
                id
                username
              }
            }
          }
        }
      GQL
      variables: {id: id, amount: amount, paidById: paid_by_id, competitionRecordId: competition_record_id}
  }
end

def delete_payout_mutation(id)
  {
      query: <<~GQL,
                                                    mutation Payout($id: ID!){
          deletePayout(input: {id: $id}) {
            payout {
              id
              amount
              user {
                id
                username
              }
            }
          }
        }
      GQL
      variables: {id: id}
  }
end

def create_player_mutation(username, join_date, rank, comment = nil, previous_names = nil)
  {
      query: <<~GQL,
        mutation Player($username: String!, $joinDate: ISO8601DateTime!, $rank: Int!, $comment: String, $previousNames: [String!]){
          createPlayer(input: {attributes: {username: $username, rank: $rank, joinDate: $joinDate, previousNames: $previousNames, comment: $comment}}) {
            player {
              username
              id
              joinDate
              rank
              comment
              previousNames
              createdAt
              updatedAt
            }
          }
        }
      GQL
      variables: {username: username, joinDate: join_date, rank: rank, comment: comment, previousNames: previous_names}
  }
end

def update_player_mutation(id, username, join_date, rank, comment = nil, previous_names = nil)
  {
      query: <<~GQL,
                mutation Player($username: String!, $joinDate: ISO8601DateTime!, $rank: Int!, $comment: String, $previousNames: [String!], $id: ID!){
          updatePlayer(input: {attributes: {username: $username, rank: $rank, joinDate: $joinDate, previousNames: $previousNames, comment: $comment}, id: $id}) {
            player {
              username
              id
              joinDate
              rank
              comment
              previousNames
              createdAt
              updatedAt
            }
          }
        }
      GQL
      variables: {id: id, username: username, joinDate: join_date, rank: rank, comment: comment, previousNames: previous_names}
  }
end

def delete_player_mutation(id)
  {
      query: <<~GQL,
                       mutation DeletePlayer($id: ID!){
          deletePlayer(input: {id: $id}) {
            player {
              username
              id
              comment
              rank
              previousNames
              joinDate
              createdAt
              updatedAt
            }
          }
        }
      GQL
      variables: {id: id}
  }
end