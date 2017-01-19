
class Search < ApplicationRecord
  def self.search(search)
    if search
      find(:conditions => ['title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end


end
