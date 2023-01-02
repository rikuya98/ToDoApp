class Task < ApplicationRecord
    belongs_to :board
    belongs_to :user
    has_one_attached :eyecatch
    validates :name, presence: true
    validates :description, presence: true
end
