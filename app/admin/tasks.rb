ActiveAdmin.register Task do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :website_id, :title, :description, :end_date, :fixed_price, :worked_hours, :deadline_id, :status, :priority
  #
  # or
  #
  # permit_params do
  #   permitted = [:client_id, :title, :description, :end_date, :fixed_price, :worked_hours, :deadline_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  filter :website_id, as: :select, collection: Website.all.map{|s| [s.title, s.id]}
  filter :title
  filter :priority
  filter :status

  form do |f|
    f.inputs do
      f.inputs "Website" do
        f.input :website_id, :as => :select, :collection => Website.all.map{|s| [s.title, s.id]}, required: true
      end
      f.input :title, required: true
      f.input :description, as: :ckeditor, required: true
      f.input :end_date
      #f.input :images, as: :file, input_html: { multiple: true }
      f.input :fixed_price
      f.input :worked_hours
      f.input :deadline_id
      f.input :status, required: true
      f.input :priority, required: true
    end
    f.actions
  end
end
