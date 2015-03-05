class Destination < ActiveRecord::Base
  before_save :add_picture

  has_many :trips
  validates_presence_of :city, :state, :country, :full_qualified_name

  def update_picture
    add_picture
  end

  private

  def add_picture
    return unless picture.blank?

    @suckr ||= ImageSuckr::GoogleSuckr.new
    query = full_qualified_name + ' wallpaper'

    picture = nil

    loop do
      picture = get_picture(query)
      break if
      ['.jpg', '.png', '.jpeg'].include? File.extname(picture)
    end

    self.picture = picture
  end

  def get_picture(query)
    @suckr.get_image_url('q' => query, \
                         'imgsz' => 'xlarge', 'imgType' => 'photo')
  end
end
