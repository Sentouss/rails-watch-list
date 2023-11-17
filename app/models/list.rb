class List < ApplicationRecord
  has_many :bookmarks
  has_many :movies, through: :bookmarks, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true, uniqueness: true
  validates :photo, content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'], message: 'must be a valid image format' }
  validates :photo, size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
end
