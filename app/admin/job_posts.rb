ActiveAdmin.register JobPost do
  index do
    selectable_column
    id_column

    column :title
    column :company
    column :job_origin
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
