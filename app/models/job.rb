class Job < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 0 }
  validates :wage_upper_bound, presence: true


  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  def self.search(search)
    if search
      find(:conditions => ['title LIKE ?', "%#{'php'}%"])
    else
      find(:all)
    end
  end

  scope :published, -> { where(is_hidden: false) }
  scope :recent, -> { order('created_at DESC') }


  has_many :resumes


end
