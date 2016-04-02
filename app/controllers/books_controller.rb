class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  def show
    respond_to do |format|
      format.html
      format.csv
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end
end
