class TicketsController < ApplicationController

  def show
    @ticket = Ticket.last
    @code = @ticket.code
    @qrcode = RQRCode::QRCode.new(@code)

    png = @qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: 'black',
      file: nil,
      fill: 'white',
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 120
    )
    
    IO.binwrite("app/assets/images/qrcode#{@ticket.code}.png", png.to_s)
    
    @ticket.qr_code.attach(io: File.open("app/assets/images/qrcode#{@ticket.code}.png"), filename: "qrcode#{@ticket.code}.png")
 
  end
  
end
