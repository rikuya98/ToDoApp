class Comment < ApplicationRecord
    belongs_to :task
    belongs_to :user
    belongs_to :board, optional: true
    validates :content, presence: true
end
