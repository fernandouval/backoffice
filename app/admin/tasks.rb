ActiveAdmin.register Task do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :website_id, :title, :description, :end_date, :fixed_price, :worked_hours, :deadline_id, :status, :priority, :admin_user_id, :estimated_hours
  #
  # or
  #
  # permit_params do
  #   permitted = [:client_id, :title, :description, :end_date, :fixed_price, :worked_hours, :deadline_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  scope :all
  scope :open, default: true do |tasks|
    tasks.where( status: ['open', 'assigned'] ).order(:priority)
  end
  scope :answered do |tasks|
    tasks.where( status: ['answered', 'data_needed', 'scheduled'] ).order(:updated_at)
  end
  scope :closed do |tasks|
    tasks.where(:status => ['closed'] ).order(:updated_at)
  end

  show do
    attributes_table do
      row :website_id do |s|
        s.website.title
      end
      row :title
      row :description
      row :status
      row :priority do |s|
        div s.priority, class: s.priority
      end
      row :worked_hours
      row :updated_at
      row :created_at
    end
    active_admin_comments
    panel "Respuestas" do
      table_for Answer.where(task_id: resource.id).order(:created_at) do
        column :title  do |s|
          auto_link(s)
        end
        column :comment do | s |
          s.comment.html_safe
        end
        column :worked_time
        column :visible
        column :send_email
      end
    end
  end

  index do
    selectable_column
    column :website_id do |s|
      s.website.title
    end
    column :title
    column :description do | s |
      s.description.html_safe
    end
    column :status
    column :priority do |s|
      div s.priority, class: s.priority
    end
    column :worked_hours
    column :created_at
    actions
  end

  filter :website_id, as: :select, collection: Website.all.map{|s| [s.title, s.id]}
  filter :title
  filter :priority, as: :select, collection: Task.priorities.keys
  filter :status, as: :select, collection: Task.statuses.keys

  form do |f|
    f.inputs do
      f.inputs "Website" do
        f.input :website_id, :as => :select, :collection => Website.all.map{|s| [s.title, s.id]}, required: true
      end
      f.input :title, input_html: {required: true}
      f.input :description, as: :ckeditor, input_html: {required: true}
      #f.input :images, as: :file, input_html: { multiple: true }
      f.input :priority, input_html: {required: true}
      f.input :estimated_hours
      f.input :fixed_price
      f.input :worked_hours
      f.input :deadline_id
      f.input :end_date
      f.input :status, input_html: {required: true}
      f.input :admin_user_id, as: :select, collection: AdminUser.all.map{|s| [s.email, s.id]}
    end
    f.actions
  end

  controller do
    def new
      if !resource.status
        resource.status = 'open'
        resource.save
      end
    end
    def update
      pre_task = resource.dup
      super do |tsk|
        if !pre_task.admin_user_id && resource.admin_user_id
          resource.status = 'assigned'
          resource.save
        end
        if pre_task.status != 'assigned' && resource.status == 'assigned'
          resource.send_assignment
        end
      end
    end
  end
end
