module ModelBase
  extend ActiveSupport::Concern

  included do
    include Mongoid::Document
    include Mongoid::Timestamps

    field :status, type: String, default: 'ENABLED'
    field :datatype, type: String, default: 'app' #:sys, :app
    field :desc, type: String
    field :seq, type: Integer, default: 0
    field :updated_by_name, type: String
    field :created_by_name, type: String

    default_scope -> { where(status: 'ENABLED')}
    scope :keyword_search, -> (key) { where(_keywords: key) }

    belongs_to :created_by, class_name: 'User', foreign_key: :created_by_id, required: false
    belongs_to :updated_by, class_name: 'User', foreign_key: :updated_by_id, required: false

    # set_callback(:save, :before) do |doc|
    #   if Ctx.user
    #     if new_record?
    #       doc.created_by = Ctx.user
    #       doc.created_by_name_translations = Ctx.user.name_translations
    #     end
    #     doc.updated_by = Ctx.user
    #     doc.updated_by_name_translations = Ctx.user.name_translations
    #   end
    # end

  end
end
