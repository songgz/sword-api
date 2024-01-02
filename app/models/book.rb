class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  field :no, type: String
  field :name, type: String
  field :desc, type: String
  field :cover, type: String
  field :unit_count, type: Integer
  field :word_count, type: Integer
  field :can_exam, type: String
  field :seq, type: Integer
  field :status, type: String
  field :my_id, type: Integer
  field :category, type: String # "ENGLISH_WORD",
  field :kind, type: String # "GO_ABROAD",


  has_many :units, class_name: 'Unit'

  validates :name, :my_id, presence: true

  def self.columns
    methods
    fields.map {|f|  f[1]}
  end


end
