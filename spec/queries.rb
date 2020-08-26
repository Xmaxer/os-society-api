def login_query(username, password)
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

def logout_query
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

def reset_password_query(id, password)
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


