module Types
  class QueryType < Types::BaseObject
    field :is_authenticated, resolver: Resolvers::AuthResolvers::AuthenticatedResolver
  end
end
