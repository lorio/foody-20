class Recipe < ActiveRecord::Base
  belongs_to :user
	has_many :ingredients, dependent: :destroy
 # has_many :ingredients, inverse_of: :recipe
	has_many :directions, dependent: :destroy
	#accepts_nested_attributes_for :ingredients, reject_if: proc { |attributes|['name'.blank?] },allow_destroy: true
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :directions, reject_if: :all_blank, allow_destroy: true
																														
  validates :title, :description, :image, presence: true
  has_attached_file :image, styles: { medium: "400x400#" }, default_url: "/images/medium/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end

