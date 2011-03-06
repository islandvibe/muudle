class Micropost < ActiveRecord::Base
  attr_accessible :content, :author, :agree, :disagree, :amused, :mood, :belongs_to_id

  belongs_to :user

  validates :content, :presence => true, :length => { :maximum => 75 }
  validates :user_id, :presence => true
  validates :author, :presence => true
  validates :agree, :presence => true
  validates :disagree, :presence => true
  validates :amused, :presence => true
  validates :belongs_to_id, :presence => true
  validates :mood, :presence => true

  default_scope :order => 'microposts.created_at DESC'

  # Return microposts from the users being followed by the given user.
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  private

    # Return an SQL condition for users followed by the given user.
    # We include the user's own id as well.
    def self.followed_by(user)
      followed_ids = %(SELECT followed_id FROM relationships
                       WHERE follower_id = :user_id)
      where("user_id IN (#{followed_ids}) OR user_id = :user_id",
            { :user_id => user })
    end
end
