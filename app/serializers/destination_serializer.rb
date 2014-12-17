class DestinationSerializer < ActiveModel::Serializer
  attributes :city, :state, :country, :full_qualified_name, :location_image

  def location_image
    @suckr ||= ImageSuckr::GoogleSuckr.new
    @suckr.get_image_url('q' => object.full_qualified_name, \
                         'imgsz' => 'large', 'imgType' => 'photo')
  end
end
