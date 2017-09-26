class Marker < ActiveRecord::Base

  # Watermarking image with another image using Imagemagick 'composite', 'watermark' and 'dissolve'.
  require "rubygems"
  require "rmagick"
  include Magick

  def self.watermark(source, watermark)

# Read the image in the memory with RMagick
#   puts "What is the image file you want to watermark?"
#   puts "Drag and drop the file here or enter the full path to the image"
#   path = gets.chomp
#
#   path = "/Users/i851546/Screen Shot 2017-09-14 at 12.45.40.png" if path.length == 0

    img                   = Magick::Image.from_blob(source.read).first

# the original image was in jpg format
# need to make the white background color transparent
# also changed the format to png since JPG does not support transparency.
# run the command below to create an image with transparent background using ImageMagick
# convert cc.png -transparent white -fuzz 2% watermark.png

# puts "What watermark file do you want to use?"
# puts "Drag and drop the file here or enter the full path to the image"
# watermark_path = gets.chomp
#
# watermark_path = "/Users/i851546/Documents/SAP/sap_anywhere_logo.png" if watermark_path.length == 0

    mark                  = Magick::Image.from_blob(watermark.read).first

# set the canvas to transparent
# if we do not specify 'background_color' on 'mark' then on rotation the background color will be black.
# we want it to be transparent.
    mark.background_color = "Transparent"

# resize the watermark to 60% of the image we want to watermark

    watermark             = mark.resize_to_fit(img.rows * 0.6, img.columns * 0.6)

# rotate this mark by 45 degrees anticlockwise (optional)
# watermark.rotate!(-45)

# using composite
# place the watermark in the center of the image
# default 'compose over' overlays the watermark on the background image
# SoftLightCompositeOp darkens or lightens the colors, dependent on the source color value.
# If the source color is lighter than 0.5, the destination is lightened.
# If the source color is darker than 0.5, the destination is darkened, as if it were burned in.
# The degree of darkening or lightening is proportional to the difference between the source color and 0.5.
# If it is equal to 0.5, the destination is unchanged.
# Painting with pure black or white produces a distinctly darker or lighter area, but does not result in pure black or white.
# img1 = img.composite(watermark, Magick::SouthEastGravity, Magick::SoftLightCompositeOp)

# using overlay
# We define which image to composite (img is the source image we want watermarked), then we define where that watermark should start
# finally we say that the watermark should be composed over the top of the source image with OverCompositeOp

    img1                  = img.composite(watermark, Magick::SouthEastGravity, 25, 25, Magick::OverCompositeOp)

# save the watermarked image

    filename = "watermarked_at_#{Time.now.to_i}"

    img1.write(Rails.root.join('public', "#{filename}.jpg"))

    path_to_file = Rails.root.join('public', "#{filename}.jpg")
    return path_to_file


# using watermark
# place the watermark in the center of the image with gravity
# watermark the image with 20% brightness and 30% saturation
# img2 = img.watermark(watermark, 0.2, 0.3, Magick::CenterGravity)
# save the watermarked image
# img2.write("/home/aditya/Pictures/wm_old_england_pic_image_watermark.jpg")

# using dissolve
# add watermark with 40% opacity for watermark, 100% opacity for image and position is center
# img3 = img.dissolve(watermark, 0.4, 1, Magick::CenterGravity)
# save the watermarked image
# img3.write("/home/aditya/Pictures/wm_old_england_pic_image_dissolve.jpg")
  end
end
