class ReviewsController < ApplicationController

  before_filter :authorize 
  
  def new
    @review = Review.new
  end

  def create
    @product = Product.find(params[:product_id])    
    @review = Review.new(review_params)
    @review.product = @product
    @review.user = current_user
    if @review.save!
      redirect_to(@product, {notice: 'Review successfully created'})
    else
      redirect_to(@product, {notice: 'Failed to create comment'})
    end
  end

  def destroy
    @product = params[:product_id]
    Review.find(params[:id]).destroy
    redirect_to :back
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description, :product_id, :user_id)
  end
end
