module Skills
  class FindOrCreateSkills
    def initialize(skill_names:)
      @skill_names = normalize_skill_names(skill_names)
    end

    def call
      existing_skills + created_skills
    end

    private

    attr_reader :skill_names

    def existing_skills
      @existing_skills ||= Skill.where(name: skill_names)
    end

    def existing_skill_names
      existing_skills.map(&:name)
    end

    def created_skills
      (skill_names - existing_skill_names).map do |skill_name|
        Skill.create!(name: skill_name)
      end
    end

    def normalize_skill_names(skill_names)
      skill_names.map(&:downcase).uniq
    end
  end
end
