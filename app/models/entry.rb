class Entry
  include MongoMapper::Document

  belongs_to :checklist
  belongs_to :user

  key :text, String
  key :complete, Boolean
  key :created_at, Time, :default => Time.now

  # def as_json(options = {})
  #   @json = super(options)
  #   @json[:checklist] = self.checklist.id
  #   @json[:user] = self.user.id
  #
  #   @json
  # end
end
