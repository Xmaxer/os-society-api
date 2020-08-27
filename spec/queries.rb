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