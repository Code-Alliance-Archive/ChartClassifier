require "opencv"

load 'lib/basic.rb'

class Image
  features = []
  
  FEATURE_NAMES = ['a', 'b']
  
  def initialize(file)
    @file_path = file
    @image =  OpenCV::IplImage.load(file)
  end
  
  
  def features
    [1,2]
  end
  
  
  def detect_rectanges
    rectanges = []
    cvmat = OpenCV::CvMat.load(@file_path)
    cvmat = cvmat.BGR2GRAY
    canny = cvmat.canny(50, 150)
    contour = canny.find_contours(:mode => OpenCV::CV_RETR_LIST, :method => OpenCV::CV_CHAIN_APPROX_SIMPLE)
    
    while contour
      # No "holes" please (aka. internal contours)
      unless contour.hole?
        box = contour.bounding_rect
        puts "BOUNDING RECT FOUND"
        cvmat.rectangle! box.top_left, box.bottom_right, :color => OpenCV::CvColor::Black
        #box = contour.min_area_rect
        rectanges.push(box)
      end
      contour = contour.h_next
    end
    
    rectanges
  end
  
end