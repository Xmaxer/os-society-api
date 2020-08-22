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


