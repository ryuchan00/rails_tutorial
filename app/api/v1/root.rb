require 'grape-swagger'

module V1
  class Root < Grape::API
    format :json
    mount V1::Users
    mount V1::Microposts
    mount V1::Relationships
    # add_swagger_documentation
  end
end
