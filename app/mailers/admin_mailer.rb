class AdminMailer < ApplicationMailer
  default from: "fundraiser@connect2need.com"

  def sample_email(donor)
    @donor = donor
    mail(to: @donor.email, subject: 'Sample Email')
  end

  def message_email(message, donor)
    # attachments.inline['logo.png'] = File.read(Organization.first.image.path)

    @message = message
    @donor = donor
    mail(to: @donor.email, subject: @message.subject)
  end
end
