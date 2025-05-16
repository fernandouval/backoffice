class ApplicationMailer < ActionMailer::Base
  default from: 'soporte@fuvals.uy', host: 'fuvals.uy'
  layout 'mailer'
end
