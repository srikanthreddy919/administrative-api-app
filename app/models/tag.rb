class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  has_many :user_tags, dependent: :destroy
end
