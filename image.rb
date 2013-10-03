require "opencv"

load 'lib/basic.rb'

class Image
  features = []
  
  FEATURE_NAMES = ['a', 'b']
  
  def initialize(file)
    @image =  OpenCV::IplImage.load(file)
  end
  
  
  def features
    [1,2]
  end
  
  
  #detect objects
  #http://www.informedgeek.com/2011/07/detecting-objects-in-a-photograph-with-opencv-part-2/
  #http://www.informedgeek.com/2011/07/detecting-objects-in-a-photograph-with-opencv/

  def detect_rectanges
    classifier = 'haarcascade_eye.xml'
    detector = OpenCV::CvHaarClassifierCascade::load(classifier)
    detector.detect_objects(image) do |region|
      color = OpenCV::CvColor::Blue
      image.rectangle! region.top_left, region.bottom_right, :color => color
    end
  end
  
end