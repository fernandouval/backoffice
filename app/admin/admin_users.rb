ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :role, :name, :phone, :personal_email

  menu if: proc{ current_admin_user.is_superadmin? }
  before_action :authenticate

  controller do
    def authenticate
      if !current_admin_user.is_superadmin?
        render :file => "public/401.html", :status => :unauthorized
      end
    end
    def update
      if params[:admin_user][:password].blank? && params[:admin_user][:password_confirmation].blank?
        params[:admin_user].delete("password")
        params[:admin_user].delete("password_confirmation")
      end
      super
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :role
      f.input :phone
      f.input :personal_email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    @admin = AdminUser.find(params[:id])
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        ul do
          li @admin.name
          li @admin.email
          li @admin.phone
          li @admin.personal_email
        end
        start = Time.utc("2000-01-01 00:00:00").to_i
        hours = Answer.from_this_month.where(admin_user_id: @admin.id).map {|a| a.worked_time.to_i - start}.sum/3600.to_f
        last_month = Answer.from_last_month.where(admin_user_id: @admin.id).map {|a| a.worked_time.to_i - start}.sum/3600.to_f
        span "Horas trabajadas del mes: #{hours}"
        span "Horas trabajadas en el mes anterior: #{last_month}"
      end
    end
    panel "Tareas del mes" do
      table_for Answer.from_this_month.where(admin_user_id: @admin.id).order(created_at: :asc) do
        column :title
        column :website do |a|
          a.task.website
        end
        column :task  do |a|
          auto_link(a.task)
        end
        column :status do |a|
          a.task.status
        end
        column :hours do |a|
          a.worked_time
        end
        column :priority do |a|
          div a.task.priority, class: a.task.priority
        end
      end
    end
    panel "Tareas del mes anterior" do
      table_for Answer.from_tlas_month.where(admin_user_id: @admin.id).order(created_at: :asc) do
        column :title
        column :website do |a|
          a.task.website
        end
        column :task  do |a|
          auto_link(a.task)
        end
        column :status do |a|
          a.task.status
        end
        column :hours do |a|
          a.worked_time
        end
        column :priority do |a|
          div a.task.priority, class: a.task.priority
        end
      end
    end
  end
end
