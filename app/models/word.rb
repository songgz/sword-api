class Word
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search

  field :no, type: String
  field :book_category, type: String
  field :word, type: String
  field :phonetic_symbol, type: String #音标
  field :acceptation, type: String #词义
  field :example, type: String #用例
  field :picture, type: String
  field :parse, type: String #解析
  field :pronunciation, type: String #读音
  field :usage, type: String #用法
  field :status, type: String
  field :seq, type: Integer
  field :my_id, type: Integer

  has_and_belongs_to_many :units

  search_in :word, :acceptation

  validates_uniqueness_of :no
  validates_uniqueness_of :my_id


end
