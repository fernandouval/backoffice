class ApplicationMailer < ActionMailer::Base
  default from: 'soporte@fuval.uy', host: 'fuval.uy'
  layout 'mailer'
end
