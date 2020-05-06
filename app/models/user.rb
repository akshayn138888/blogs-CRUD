class User < ApplicationRecord
    has_secure_password
    
    has_many :posts
    has_many :comments
    
    validates(:email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    validates(:name, presence: true)
    validates(:password, presence: true)
end
