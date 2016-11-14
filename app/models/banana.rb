class Banana < ApplicationRecord
	validates :length, presence: true
	validates :flavour, presence: true,
			   		 format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }

end
