# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authorize_trader, only: :edit
end
