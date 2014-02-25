class Contact < ActiveRecord::Base
    has_many :phones
    accepts_nested_attributes_for :phones

    validates :firstname, :lastname, :email, presence: true
    validates :email, uniqueness: true
    validates :phones, length: { is: 3 }

    def name
        "#{firstname} #{lastname}"
    end

    def hide
        @hidden = true
    end

    def self.name_search(letter)
        where("firstname LIKE ?", "#{letter}%").order(:firstname)
    end
end