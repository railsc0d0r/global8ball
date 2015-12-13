module PersonSerializerConcern
  extend ActiveSupport::Concern

  included do
    def nickname
      object.person.nickname
    end

    def title
      object.person.title
    end

    def email
      object.person.email
    end

    def phone
      object.person.phone
    end

    def date_of_birth
      object.person.date_of_birth
    end
  end
end
