module Constants
  module Errors
    USER_USERNAME_TOO_SHORT_ERROR = {code: 1, message: "Username too short (Minimum: %{count})"}
    USER_USERNAME_TOO_LONG_ERROR = {code: 2, message: "Username too long (Maximum: %{count})"}
    USER_USERNAME_NOT_PRESENT_ERROR = {code: 3, message: "Username is required"}
    USER_USERNAME_NOT_VALID_ERROR = {code: 4, message: "'%{value}' is not a valid username"}
    USER_PASSWORD_TOO_SHORT_ERROR = {code: 5, message: "Password too short (Minimum: %{count})"}
    USER_PASSWORD_TOO_LONG_ERROR = {code: 6, message: "Password too long (Maximum: %{count})"}
    USER_PASSWORD_NOT_PRESENT_ERROR = {code: 7, message: "Password is required"}
    AUTHENTICATION_USERNAME_INVALID_ERROR = {code: 40, message: "Invalid username"}
    AUTHENTICATION_PASSWORD_INVALID_ERROR = {code: 41, message: "Invalid password"}
    NOT_AUTHENTICATED_ERROR = {code: -1, message: "Not authenticated"}

  end
end
