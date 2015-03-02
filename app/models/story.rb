class Story < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :story_likes, dependent: :destroy
  validates :user, presence: true
  validates :title, presence: true
  validate :presence_of_url_or_text
  validate :url_has_correct_format
=begin
    Returns all the comments related to the Story
    @return [Hash<Symbol,ActiveRecord_Associations_CollectionProxy>] a Hash
      containing the comments whose parents are the comments associated to the
      story
=end

    def get_comments
      comments = self.comments.where(parent_id: nil).order(:created_at).to_a
      comments_hash = {}
      while comments.any? do
        comment = comments.shift
        comment_comments = comment.comments.order(:created_at)
        comments_hash["#{comment.id}"] = comment_comments
        comments.concat(comment_comments)
      end
      comments_hash
    end

  private

    # Validates if the story has only a url or also a text
    def presence_of_url_or_text
      if self.url.present? && self.text.present?
        errors.add(:url, I18n.t('story.errors.url_text'))
      end
    end

    def url_has_correct_format
      if self.url.present?
        unless self.url.downcase.start_with?('https://', 'http://')
          errors.add(:url, I18n.t('story.errors.wrong_url_format'))
        end
      end
    end
end
