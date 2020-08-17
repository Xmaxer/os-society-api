class ActionDispatch::IntegrationTest
  graphql_path = '/api'

  def setup
    User.create({username: "test", password: "123456", reset_password: false})
  end

  def teardown
    super
  end
end
