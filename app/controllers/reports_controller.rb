class ReportsController < ApplicationController
  def all_data
    @assemblies = Assembly.all
  end

  def report_email
    puts params
    ReportEmailJob.perform_later(params[:email], params[:assembly][:name])
    redirect_to root_path
  end
end
