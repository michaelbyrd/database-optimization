class ReportMailer < ApplicationMailer
  def report(address, name = "a1")
    @address = address
    @assembly = Assembly.find_by_name(name)
    @hits = @assembly.hits.order("percent_similarity DESC")
    mail(to: @address, subject: "Heres that DNA you ordered")
  end
end
