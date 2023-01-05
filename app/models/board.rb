class Board < ApplicationRecord

    belongs_to :user
    has_many :tasks, dependent: :destroy
    has_one_attached :eyecatch
    validates :name, presence: true
    validates :description, presence: true

    def comment_count
        comments.count
    end

end
