class Entry
  include MongoMapper::Document

  belongs_to :checklist
  belongs_to :user

  key :text, String
  key :complete, Boolean
end
