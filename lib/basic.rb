require "rubygems"
require "opencv"
include OpenCV




#image features and object detection

def test_feature
  img = 'images/20100809230453673922.png'
  image = IplImage::load img
  gray = image.BGR2GRAY
end

##find circles
def find_circles
  result = image.clone
  detect = gray.hough_circles(CV_HOUGH_GRADIENT, 2.0, 10, 200, 50)
  puts detect.size
  detect.each{|circle|
    puts "#{circle.center.x},#{circle.center.y} - #{circle.radius}"
    result.circle! circle.center, circle.radius, :color => CvColor::Red, :thickness => 3
  }
end

##edge detection

##