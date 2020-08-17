require 'minitest/autorun'
require 'test_helper'

class UserMutationTest < ActionDispatch::IntegrationTest
  def setup
    User.create({username: 'test', password: "123456"})
  end

  def teardown
    p "TEARING DOWN"
  end

  test "Should be able to reset password" do
    query_string = "mutation User($id: ID!, $password: String!){
  updateUser(input: {attributes: {password: $password}, id: $id}) {
    user {
      id
      username
      resetPassword
    }
  }
}"
    variables = {id: 1, password: "newpassword"}
    post '/api', params: {query: query_string, variables: variables}
  end
end