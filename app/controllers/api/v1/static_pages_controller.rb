class Api::V1::StaticPagesController < ApplicationController
  def home
    render 'readme.html'
  end
end
