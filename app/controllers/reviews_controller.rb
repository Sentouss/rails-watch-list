class ReviewsController < ApplicationController
  before_action :set_list

  def create
    @review = Review.new(review_params)
    @review.list = @list
    if @review.save
      redirect_to @list, notice: 'Review added successfully.'
    else
      render 'lists/show'
    end
  end

private

  def set_list
    @list = List.find(params[:list_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
