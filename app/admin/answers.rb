ActiveAdmin.register Answer do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  before_action :check_dependency, only: [:new]
  permit_params :task, :task_id, :title, :comment, :worked_time, :send_email, :visible, :admin_user_id, task_attributes:[:id, :status, :priority]
  #
  # or
  #
  # permit_params do
  #   permitted = [:task_id, :comment, :send_email, :visible]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  controller do
    def update_task
      logger.debug "\n\nINSPECTIONG RESOURCE #{resource.inspect}\n\n"
    end
  end

  index do
    start = Time.utc("2000-01-01 00:00:00").to_i
    tot = 0
    selectable_column
    column :task
    column :title
    column :comment do | s |
      s.comment.present? ? s.comment.html_safe : ''
    end
    column :worked_time do |s|
      if s.worked_time.present?
        tot += s.worked_time.to_i - start
        s.worked_time.strftime('%H:%M')
      else
        '0'
      end
    end
    column :status
    column :created_at
    actions
    span "Total de horas: #{ tot/3600 }"
  end

  form do |f|
    if params[:task] || resource.task_id
        task_id = resource.task_id ? resource.task_id : params[:task]
        resource.task_id = task_id
        task = Task.find(task_id)
      div class: 'new-answer-header' do
        h2 "Respuesta para la tarea #{task.title} en #{task.website.title}"
      end
    end
    f.inputs do
      f.input :title, input_html: {required: true}
      f.input :comment, as: :ckeditor, input_html: {required: true}
      f.input :worked_time, value: "%H:%M", label: "Horas/Minutos trabajados"
      f.input :visible
      f.input :send_email
      if task_id.present?
        f.has_many :task, new_record: false do |t|
        #@task, :url => '#' do |t|
          #f.has_many :class_tasks, heading: false, allow_destroy: false do |t|
          t.input :status
          t.input :priority
          #end
        end
      else
        f.input :task_id, as: :searchable_select, :collection => Task.where.not(status: ['closed']).map{|m| [m.title, m.id]}, input_html: {required: true}
      end
    end
    f.actions
  end

  controller do
    def create
      #logger.debug "\nPARAMETERS\n"
      params[:answer][:admin_user_id] = current_admin_user.id
      if ( params[:answer][:task_attributes] )
        task_id = params[:answer][:task_attributes][:id]
        Task.find(task_id).
        update(
          params[:answer][:task_attributes].
          except(:id).
          permit(:status, :priority)
        )
        params[:answer].delete :task_attributes
        params[:answer][:task_id] = task_id
        answer = Answer.new(params[:answer].permit(:task_id, :title, :comment, :worked_time, :send_email, :visible, :admin_user_id))
        if answer.save
          flash[:notice] = "Se ha creado la respuesta"
        else
          flash[:notice] = "No se ha podido crear la respuesta"
        end
        #logger.debug "\nENTRÓ #{answer.errors.inspect}\n"
      else
        super
        flash[:notice] = "Se ha creado la respuesta"
      end
      redirect_to admin_task_path(params[:answer][:task_id])
    end
    #
    def check_dependency
      if params[:task]
        @task = Task.find(params[:task])
        if @task.depends_on_id.present?
          if @task.depends_on.is_open
            redirect_to admin_task_url(@task.id), flash: { error: "La tarea está bloqueada por su dependencia con: #{@task.depends_on.title}" }
          end
        end
      end
    end
  end
end
