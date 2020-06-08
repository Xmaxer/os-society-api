module Constants
  module Errors
    USER_USERNAME_TOO_SHORT_ERROR = {code: 1, message: "Username too short (Minimum: %{count})"}
    USER_USERNAME_TOO_LONG_ERROR = {code: 2, message: "Username too long (Maximum: %{count})"}
    USER_USERNAME_NOT_PRESENT_ERROR = {code: 3, message: "Username is required"}
    USER_USERNAME_NOT_VALID_ERROR = {code: 4, message: "'%{value}' is not a valid username"}
    USER_PASSWORD_TOO_SHORT_ERROR = {code: 5, message: "Password too short (Minimum: %{count})"}
    USER_PASSWORD_TOO_LONG_ERROR = {code: 6, message: "Password too long (Maximum: %{count})"}
    USER_PASSWORD_NOT_PRESENT_ERROR = {code: 7, message: "Password is required"}
    PLAYER_USERNAME_ALREADY_EXISTS_ERROR = {code: 8, message: "'%{value}' is already taken"}
    PLAYER_USERNAME_TOO_SHORT_ERROR = {code: 9, message: "Username too short (Minimum: %{count})"}
    PLAYER_USERNAME_TOO_LONG_ERROR = {code: 10, message: "Username too long (Maximum: %{count})"}
    PLAYER_JOIN_DATE_IN_FUTURE_ERROR = {code: 11, message: "Join date cannot be in the future."}
    PLAYER_JOIN_DATE_NOT_PRESENT_ERROR = {code: 11, message: "Join date is required"}
    PLAYER_RANK_INVALID_ERROR = {code: 12, message: "Specified rank is invalid"}
    PLAYER_PREVIOUS_NAME_INVALID = {code: 13, message: "Previous name is invalid"}
    PLAYER_COMMENT_TOO_LONG_ERROR = {code: 15, message: "Comment is too long"}
    USER_USERNAME_ALREADY_EXISTS_ERROR = {code: 16, message: "'%{value}'is already taken"}
    PLAYER_USERNAME_NOT_PRESENT_ERROR = {code: 17, message: "Username is required"}
    PLAYER_USERNAME_NOT_VALID_ERROR = {code: 18, message: "'%{value}' is not a valid username"}
    PLAYER_DOES_NOT_EXIST_ERROR = {code: 19, message: "Specified player does not exist"}
    AUTHENTICATION_USERNAME_INVALID_ERROR = {code: 40, message: "Invalid username"}
    AUTHENTICATION_PASSWORD_INVALID_ERROR = {code: 41, message: "Invalid password"}
    NOT_AUTHENTICATED_ERROR = {code: -1, message: "Not authenticated"}

  end
end
