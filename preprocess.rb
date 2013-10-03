load 'utils.rb'
load 'image.rb'  
    
#indir = '/Users/a0mish/Dropbox/sample images/Bar Charts'
indir = 'images/'
#outdir = '/Users/a0mish/Projects/data'
outfile = 'out/features.csv'

files = Dir.entries(indir)

images=[]

for f in files
  if is_image?(f)
    image = Image.new(indir + f)
    images.push(image)
  end
end


#write features
s = Image::FEATURE_NAMES.join(",") + "\n"
for image in images
	s = s+ image.features.join(",") + "\n"
end

File.open(outfile, 'w') {|f| f.write(s) }

