class Entry
  include MongoMapper::Document

  belongs_to :checklist

  key :text, String
  key :complete, Boolean
end
