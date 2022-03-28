ActiveAdmin.register Website do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description, :url, :admin, :password_digest, :client_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :url, :admin, :password_digest, :client_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.inputs do
      f.input :title
      f.input :description, as: :ckeditor
      #f.input :images, as: :file, input_html: { multiple: true }
      f.input :url
      f.input :admin
      f.input :password_digest
      f.inputs "Client" do
        f.input :client_id, :as => :select, :collection => Client.all.map{|s| [s.name, s.id]}
      end
    end
    f.actions
  end
  
end
