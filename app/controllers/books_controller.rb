class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :set_publisher_id

  def show
    respond_to do |format|
      format.html
      format.csv
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to publisher_book_path, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def set_publisher_id
    @publisher = Publisher.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:id, :name, :price, :publisher_id)
  end
end
