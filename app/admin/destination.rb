ActiveAdmin.register Destination do
  form do |f|
    f.inputs 'Details' do
      f.input :picture
    end
    f.actions
  end

  index do
    column :picture do |destination|
      image_tag destination.picture, style: 'max-width: 400px; max-height: 400px; align: center'
    end
    column :full_qualified_name
    actions
  end

  permit_params :picture
end
