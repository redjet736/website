# == Schema Information
#
# Table name: custompages
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Custompage < ActiveRecord::Base
  belongs_to :user
  
  validates :content, presence: true, length: {maximum: 500}
  validates :title, presence: true
  validates :user_id, presence: true

  default_scope order: 'custompages.created_at DESC'
end
