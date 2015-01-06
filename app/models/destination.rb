class Destination < ActiveRecord::Base
  before_save :add_picture

  has_many :trips
  validates_presence_of :city, :state, :country, :full_qualified_name

  private

  def add_picture
    @suckr ||= ImageSuckr::GoogleSuckr.new
    query = full_qualified_name + ' wallpaper'
    picture = @suckr.get_image_url('q' => query, \
                                   'imgsz' => 'xlarge', 'imgType' => 'photo')
    self.picture = picture
  end
end
