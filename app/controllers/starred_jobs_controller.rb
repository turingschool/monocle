class StarredJobsController < ApplicationController
  def index
    @jobs = current_user.starred_jobs
  end

  def create
    job = StarredJob.new(starred_job_params.merge({user_id: current_user.id}))
    job.save
  end

  def destroy
    StarredJob.find_by(uid: params[:id]).destroy
  end

  private

    def starred_job_params
      params.permit(:title, :decription, :posted_date, :remote, :location, :company_name, :technologies, :uid, :url)
    end
end
