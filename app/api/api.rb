module API
  class Root < Grape::API
    format :json
    mount V1::Root
    # mount V2::Root
  end
end
