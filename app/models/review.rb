class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game

  has_many :comments, dependent: :destroy
  has_many :emotitions, dependent: :destroy

  class << self
    def top_reviews
      review_ids = Emotition.where(emotition_type: :like).group(:review_id).
        order("COUNT(review_id)").pluck :review_id
      review_ids += pluck(:id) if review_ids.empty?
      where id: review_ids.uniq
    end
  end
end
