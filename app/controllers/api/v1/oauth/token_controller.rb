class Api::V1::Oauth::TokenController < ApplicationController
  swagger_controller :token, "Oauth tokens"

  swagger_api :create do
    summary 'Send an oauth token to the user'
    notes 'Gives an oauth token required in other api calls. User must have previously authorized an application to access their account to get an oauth token'
  end

  def create
    user_api = find_user_api
    user_authorization = find_user_authorization(user_api)
    if valid_authorization(user_api, user_authorization)
      user_authorization.set_token
      @user_authorization = user_authorization
      render status: 201
    else
      render status: 403
    end
  end

  private
    def oauth_params
      params.permit(:api_key, :secret, :code, :redirect_url)
    end

    def find_user_api
      UserApi.find_by(key: oauth_params[:api_key], secret: oauth_params[:secret], redirect_url: oauth_params[:redirect_url])
    end

    def find_user_authorization(user_api)
      UserAuthorization.find_by(code: oauth_params[:code], user_api: user_api)
    end

    def valid_authorization(user_authorization, user_api)
      user_authorization && user_api
    end
end