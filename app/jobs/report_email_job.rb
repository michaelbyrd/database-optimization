class ReportEmailJob < ActiveJob::Base
  queue_as :nightly

  def perform(*args)
    ReportMailer.report(args[0], args[1])
  end
end
