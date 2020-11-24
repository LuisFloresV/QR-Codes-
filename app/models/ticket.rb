class Ticket < ApplicationRecord
  has_one_attached :qr_code
end
