class Destination < ActiveRecord::Base
  before_save :add_picture

  has_many :trips
  validates_presence_of :city, :state, :country, :full_qualified_name

  private

  def add_picture
    @suckr ||= ImageSuckr::GoogleSuckr.new
    picture = @suckr.get_image_url('q' => full_qualified_name, \
                                   'imgsz' => 'xlarge', 'imgType' => 'photo')
    self.picture = picture
  end
end
