class SupportMailer < ApplicationMailer
  #
  def task_new
    @task = params[:task]
    admins_emails = AdminUser.superadmin.map {|a| a.email}.join(',')
    mail(to: admins_emails, subject: 'FUvals - Nueva tarea')
  end
  def task_answered
    #self.website.client.email
    @task = params[:task]
    admins_emails = AdminUser.superadmin.map {|a| a.email}.join(',')
    mail(to: admins_emails, subject: 'FUvals - Tarea para revisión')
  end
  def task_closed
    @task = params[:task]
    admins_emails = AdminUser.superadmin.map {|a| a.email}.join(',')
    mail(to: admins_emails, subject: 'FUvals - Tarea cerrada')
  end
  def task_assigned
    @task = params[:task]
    mail(to: params[:to], subject: 'FUvals - Nueva tarea asignada a ti')
  end
end
