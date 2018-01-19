class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_country

  def set_country
    @country = "ru"

    @current_user = {
      name: "Tadadada"
    }
  end
end
