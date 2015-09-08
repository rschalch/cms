class Subject < ActiveRecord::Base

	has_many :pages

	acts_as_list

	before_destroy :no_referenced_pages

	validates_presence_of :name
	validates_length_of :name, :maximum => 255

	scope :visible, lambda { where :visible => true }
	scope :invisible, lambda { where :visible => false }
	scope :sorted, lambda { order('subjects.position ASC') }
	scope :newest_first, lambda { order('subjects.created_at DESC') }
	scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"]) }

	private
		def no_referenced_pages
			return if pages.empty?
    		errors[:base]  << "The subject \"#{name}\" can't be deleted! It's referenced by page(s): #{pages.map(&:name).to_sentence}"
    		false
 		end
end
