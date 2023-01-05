class Task < ApplicationRecord
    belongs_to :board
    belongs_to :user
    has_one_attached :eyecatch
    has_many :comments, dependent: :destroy
    validates :name, presence: true
    validates :description, presence: true

    def comment_count
        comments.count
    end
end
