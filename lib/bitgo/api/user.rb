module Api
  module User
    def me
        get('user/me')
    end
  end
end