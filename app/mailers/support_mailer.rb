class SupportMailer < ApplicationMailer
  #
  def task_new
    @task = params[:task]
    admins_emails = AdminUser.all.map {|a| a.email}.join(',')
    mail(to: admins_emails, subject: 'FUval - Nueva tarea')
  end
  def task_answered
    #self.website.client.email
    @task = params[:task]
    admins_emails = AdminUser.all.map {|a| a.email}.join(',')
    mail(to: admins_emails, subject: 'FUval - Tarea para revisión')
  end
  def task_closed
    @task = params[:task]
    admins_emails = AdminUser.all.map {|a| a.email}.join(',')
    mail(to: admins_emails, subject: 'FUval - Tarea cerrada')
  end
end
