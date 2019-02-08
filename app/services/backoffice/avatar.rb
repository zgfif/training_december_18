module Backoffice
  class Avatar
    include ActiveModel::Validations

    CONTENT_TYPE = ['image/png', 'image/jpeg', 'image/gif']

    attr_accessor :author, :params

    def initialize author, params
      @author = author

      @params = params
    end

    delegate :as_json, to: :author, allow_nil: true

    validate :is_image?

    def is_image?
      return if @params.blank?

      errors.add :avatar, 'has invalid format' unless content_type_image?
    end

    def content_type_image?
      CONTENT_TYPE.include? @params.content_type
    end

    def attach_avatar
      return if @author.blank?

      @author.avatar.attach @params
    end
  end
end
