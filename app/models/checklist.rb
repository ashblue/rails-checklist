class Checklist
  include MongoMapper::Document

  many :entries
  belongs_to :user

  key :title, String
  key :created_at, Time, :default => Time.now
  key :updated_at, Time, :default => Time.now
end
