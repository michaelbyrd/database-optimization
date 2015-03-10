class ReportsController < ApplicationController
  def all_data

  end

  def report_email
    ReportEmailJob.perform_later(params[:email])
    # ReportMailer.report(params[:email]).deliver_later
    redirect_to root_path
  end
end
