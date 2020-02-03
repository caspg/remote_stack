ActiveAdmin.register JobPost do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description, :origin_id, :origin_name, :publication_datetime, :link, :benefits, :company_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :origin_id, :origin_name, :publication_datetime, :link, :benefits, :company_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column

    column :title
    column :origin_name
    column :company
    column :description do |job_post|
      job_post.description.truncate(50)
    end

    column :skills do |job_post|
      job_post.skills.map do |skill|
        link_to(skill.name, hq_skill_path(skill.id))
      end
    end

    actions
  end
end
