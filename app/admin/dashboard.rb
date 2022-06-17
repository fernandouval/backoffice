# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }
  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        hours = 0
        #Task.where(admin_user_id: current_admin_user.id, status: 'closed').map{ |task| hours += task.worked_hours}
        span "Computando tareas"
        small "Las tareas se computan al cierre del mes corriente, cuando las mismas se pasan a closed."
        span "Horas trabajadas del mes: #{hours}"
      end
      span class: "blank_slate" do
        span "Cerrado automático"
        small "Si una tarea pasa más de 72 hs en answered la tarea se cierra automáticamente"
      end
    end
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span "Buen día #{current_admin_user.email}"
        small "Estas son las tareas que tienes asignadas:"
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
