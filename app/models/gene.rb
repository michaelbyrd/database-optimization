class Gene < ActiveRecord::Base
  belongs_to :sequence, counter_cache: true
  has_many :hits, as: :subject

  validates :sequence_id, presence: true
end
