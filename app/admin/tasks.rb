ActiveAdmin.register Task do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :website_id, :title, :description, :end_date, :fixed_price, :worked_hours, :deadline_id, :status, :priority, :admin_user_id
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
      f.input :title, required: true
      f.input :description, as: :ckeditor, required: true
      #f.input :images, as: :file, input_html: { multiple: true }
      f.input :priority, required: true
      f.input :estimated_hours
      f.input :fixed_price
      f.input :worked_hours
      f.input :deadline_id
      f.input :end_date
      f.input :status, required: true
      f.input :admin_user_id, as: :select, collection: AdminUser.all.map{|s| [s.email, s.id]}
    end
    f.actions
  end

  controller do
    def update
      pre_task = resource.dup
      super do |tsk|
        if !pre_task.admin_user_id && resource.admin_user_id
          resource.status = 'assigned'
          resource.save
        end
      end
    end
  end
end
