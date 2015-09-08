class Page < ActiveRecord::Base

	belongs_to :subject

  has_many :sections, :dependent => :destroy

	has_and_belongs_to_many :editors, class_name: 'AdminUser'

  acts_as_list :scope => :subject

  before_destroy :no_referenced_sections
  before_validation :add_default_permalink
  after_save :touch_subject

  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_presence_of :permalink
  validates_length_of :permalink, :within => 3..255

  validates_uniqueness_of :permalink

  scope(:sorted, -> { order('name')})
  scope(:visible, -> { where(:visible => true)})

  private
    def no_referenced_sections
      return if sections.empty?
      errors[:base]  << "The page \"#{name}\" can't be deleted! It's referenced by section(s): #{sections.map(&:name).to_sentence}"
      false
    end

    def add_default_permalink
      if permalink.empty?
        self.permalink = "#{id}-#{name.parameterize}"
      end
    end

    def touch_subject
      subject.touch
    end

end
