class JobsController < ApplicationController
  def index
    @jobs = LookingForService.recent_jobs
  end
  
  def show
    @job = LookingForService.job(params[:id])
    @job_data = @job.to_json
  end
end
