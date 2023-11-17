class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @bookmark.list = @list

    if @bookmark.save
      redirect_to list_path(@list), notice: 'Bookmark was successfully added.'
    else
      render 'lists/show' # Render the list show view on failure
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    list = @bookmark.list
    @bookmark.destroy
    redirect_to list_path(list), notice: 'Bookmark was successfully removed.'
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
    # Ensure :movie_id and :comment are the correct parameters for your bookmark
  end
end
