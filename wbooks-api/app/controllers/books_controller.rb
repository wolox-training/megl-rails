class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all
    render json: @books, each_serializer: BookIndexSerializer
  end

  def show
    @book = Book.find(params[:id])
    render json: @book, serializer: BookShowSerializer
  end
end
