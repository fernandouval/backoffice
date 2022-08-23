# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }
  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        start = Time.utc("2000-01-01 00:00:00").to_i
        hours = Answer.from_this_month.where(admin_user_id: current_admin_user.id).map {|a| a.worked_time.to_i - start}.sum/3600.to_f
        span "Horas trabajadas del mes: #{hours}"
      end
      span class: "blank_slate" do
        span "Cerrado automático"
        small "Si una tarea pasa más de 72 hs en answered la tarea se cierra automáticamente"
      end
    end
    if current_admin_user.is_superadmin?
      panel "Horas del mes" do
        start = Time.utc("2000-01-01 00:00:00").to_i
        table_for AdminUser.order(name: :asc) do
          column :name do |a|
            link_to a.name, auto_url_for(a)
          end
          column :worked_hours  do |a|
            a.answers.from_this_month.map {|a| a.worked_time.to_i - start}.sum/3600.to_f
          end
        end
      end
    end

    columns do
      column do
        panel "Tareas" do
          table_for Task.where(admin_user_id: current_admin_user.id, status: ['assigned', 'in_progress', 'scheduled']).order(priority: :desc) do
            column :website
            column :title  do |s|
              auto_link(s)
            end
            column :description do | s |
              s.description.html_safe
            end
            column :status
            column :priority do |s|
              div s.priority, class: s.priority
            end
            column("Actions") do |s|
              "#{ link_to "Edit", edit_admin_task_path(s) } #{ link_to "Reply", "#{new_admin_answer_path()}?task=#{s.id}", target: :_blank }".html_safe
            end
          end
        end
      end
    end
  end # content
end
