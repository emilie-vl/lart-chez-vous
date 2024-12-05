class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :info_window

  def info_window
    user = User.includes(owned_artworks: { photo_attachment: :blob }).find(params[:id])
    render partial: 'users/info_window', locals: { user: user }
  end
end
