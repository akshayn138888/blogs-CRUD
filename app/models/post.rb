class Post < ApplicationRecord
    has_many(:comments, dependent: :destroy)
    belongs_to :user
    validates(:title, presence: true, uniqueness: true)
    validates(
        :body,
        presence: { message: "must exist" },
        length: { minimum: 50 }
    )
end
