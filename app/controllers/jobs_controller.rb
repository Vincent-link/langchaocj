class JobsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :find_job_and_check_permission, only: [:edit, :destroy, :update]

    def index
        @jobs = case params[:order]
                when 'by_lower_bound'
                    Job.published.order('wage_lower_bound DESC')
                when 'by_upper_bound'
                    Job.published.order('wage_upper_bound DESC')
                else
                    Job.published.recent
                end
        @jobs = Job.search(params[:search])
    end

    def show
        @job = Job.find(params[:id])
        if !current_user && current_user != @job.user
            redirect_to new_user_registration_path
        end
    end

    private

    def job_params
        params.require(:job).permit(:title, :description, :wage_lower_bound, :wage_upper_bound, :contact_email, :is_hidden)
    end

    def find_job_and_check_permission
        @job = Job.find(params[:id])

        if current_user != @job.user
            redirect_to root_path, alert: 'You have no permission.'
        end
    end
end
