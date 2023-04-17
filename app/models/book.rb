class Book < ApplicationRecord
    belongs_to :user
    
    has_one_attached :profile_image
    has_many :favorites, dependent: :destroy
    has_many :book_comments, dependent: :destroy
    
    def get_profile_image
    
     unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
     end
      profile_image.variant(resize_to_limit: [100, 100]).processed
    end
    
    validates :title, presence: true
    validates :body, length: { minimum: 1, maximum: 200 }
    
    def favorited_by?(user)
     favorites.exists?(user_id: user.id)
    end
  
end
