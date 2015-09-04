class Api::V1::StaticPagesController < ApplicationController
  def home
    render 'home.html'
  end
end
