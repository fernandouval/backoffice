ActiveAdmin.register Client do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :email, :phone

  menu if: proc{ current_admin_user.is_superadmin? }
  before_action :authenticate
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :phone]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  controller do
    def authenticate
      if !current_admin_user.is_superadmin?
        render :file => "public/401.html", :status => :unauthorized
      end
    end
  end

  show do
    @client = Client.find(params[:id])
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        ul do
          li @client.name
          li @client.email
          li @client.phone
        end
        start = Time.utc("2000-01-01 00:00:00").to_i
        hours = Answer.from_this_month.joins(task: [:website]).where("websites.client_id": @client.id).map {|a| a.worked_time.to_i - start}.sum/3600.to_f
        span "Horas trabajadas del mes: #{hours}"
      end
    end
    panel "Tareas del mes" do
      table_for Answer.from_this_month.joins(task: [:website]).where("websites.client_id": @client.id).order(created_at: :asc) do
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
        column :priority do |a|
          div a.task.priority, class: a.task.priority
        end
      end
    end
  end

end
