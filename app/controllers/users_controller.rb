class UsersController < ApplicationController
  def info_window
    user = User.includes(owned_artworks: { photo_attachment: :blob }).find(params[:id])
    render partial: 'users/info_window', locals: { user: user }
  end
end
