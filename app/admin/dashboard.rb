# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span "Computando tareas"
        small "Las tareas se computan al cierre del mes corriente, cuando las mismas se pasan a closed"
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
          Task.
          where(admin_user: current_admin_user, status: 'assigned').
          order(:priority).
          map do |task|
            ul do
              li "#{task.title}"
              li "#{task.description}"
              li "#{task.priority}"
            end
          end
        end
      end
    end
  end # content
end
