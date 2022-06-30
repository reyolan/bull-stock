# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  after_action :remove_notice, only: %i[destroy create]

  private

  def remove_notice
    flash.delete(:notice)
  end
end
