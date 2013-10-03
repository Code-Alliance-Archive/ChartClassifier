#!/usr/bin/env ruby

#require 'RMagick'
require "rubygems"
require 'opencv' 
include OpenCV
#include Magick

if ARGV.size == 0
  puts "Usage: ruby #{__FILE__} ImageToLoadAndDisplay"
  exit
end

# first create a new version of the image in grey scale
#image = Magick::Image::read(ARGV[0]).first
#image.quantize(256, Magick::GRAYColorspace).write 'gray_path.jpg'
 
image = nil
begin
  image = CvMat.load(ARGV[0], CV_LOAD_IMAGE_COLOR) # Read the file.
  #gray = OpenCV::IplImage.load("gray_path.jpg")
rescue
  puts 'Could not open or find the image.'
  exit
end

original_window = GUI::Window.new "original"
hough_window = GUI::Window.new "hough circles"

gray = image.BGR2GRAY
#gray = gray.threshold(150, 70, CV_THRESH_BINARY)
#gray = gray.canny(50,200,3)

result = gray.clone
original_window.show image
detect = gray.hough_circles(CV_HOUGH_GRADIENT, 2.0, gray.rows/4, 200, 100, gray.rows/3, gray.rows*0.75)
#puts "rows is #{gray.rows}"

puts detect.size
#circle = detect[0]
detect.each{|circle|
  puts "#{circle.center.x},#{circle.center.y} - #{circle.radius}"
  result.circle! circle.center, circle.radius, :color => CvColor::Red, :thickness => 3
}
hough_window.show result
GUI::wait_key