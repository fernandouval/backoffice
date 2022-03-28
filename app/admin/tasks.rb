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

end
