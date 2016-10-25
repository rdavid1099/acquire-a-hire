class Requesters::ReviewsController < ApplicationController
  def new
    @job = Job.find(params[:job_id])
    @review = Review.new(requester_id: @job.requester_id,
                        professional_id: @job.professional_id,
                        reviewee_role: current_user.inverse_role)
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to requesters_review_path(@review)
    else
      flash.now[:error] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  private

    def review_params
      params.require(:review).permit(:review, :rating, :professional_id, :requester_id)
    end

end
