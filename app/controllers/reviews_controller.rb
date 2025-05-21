class ReviewsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.build(review_params.merge(user: current_user))
    @review.save
    redirect_to @product
  end

  def destroy
    @review = current_user.reviews.find(params[:id])
    product = @review.product
    @review.destroy
    redirect_to product
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
