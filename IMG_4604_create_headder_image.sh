#!/bin/sh

#
# Todo:
#   Using font
#   Using line
#


# 4032x3024 to 2016x1512
# convert -strip -resize 2016x1512 -quality 90 IMG_4604.png _IMG_4604.png


# Fred's ImageMagick Scripts: POPART
# http://www.fmwconcepts.com/imagemagick/popart/index.php
# ./__popart -r 1 -c 1 -g 0 -i bilinear -c1 "yellow  red red red"       _IMG_4604.png _yl-rd-rd-rd.png
# ./__popart -r 1 -c 1 -g 0 -i bilinear -c1 "yellow  green green green" _IMG_4604.png _yl-gr-gr-gr.png
# ./__popart -r 1 -c 1 -g 0 -i bilinear -c1 "yellow  blue blue blue"    _IMG_4604.png _yl-bl-bl-bl.png

# Create mask image
# convert -size 2016x1512 xc:'#00000000' -fill '#ff00ffff' -draw \
#     "polygon 0,0 380,0 880,1512 0,1512"         _mask1.png
# convert -size 2016x1512 xc:'#00000000' -fill '#ff00ffff' -draw \
#     "polygon 380,0 880,1512 1600,1512 1170,0"   _mask2.png
# convert -size 2016x1512 xc:'#00000000' -fill '#ff00ffff' -draw \
#     "polygon 1170,0 1600,1512 2016,1512 2016,0" _mask3.png

# Masking
# composite -compose dst-in _mask1.png _yl-rd-rd-rd.png -alpha on _z1.png
# composite -compose dst-in _mask2.png _yl-gr-gr-gr.png -alpha on _z2.png
# composite -compose dst-in _mask3.png _yl-bl-bl-bl.png -alpha on _z3.png


# Combined, composite, compound
# composite -compose over  _z1.png _z2.png _zz1.png
# composite -compose over _zz1.png _z3.png _zz7.png


# Crop Twitter size(1500x500)
# convert -crop 2016x672+0+400 _zz7.png _zz8.png

# Fred's ImageMagick Scripts: VINTAGE1 http://www.fmwconcepts.com/imagemagick/vintage1/index.php
# scratchy window | For use in your creations, please credit m… | Flickr https://www.flickr.com/photos/borealnz/2473360890 (2048x1367)
# ./__vintage1 _zz8.png _textures/2473360890_47e771a3e6_k.jpg _IMG_4604_twitter.png

# Resize
# convert -resize 1500x -quality 90 _IMG_4604_twitter.png IMG_4604_twitter.png


# Crop Facebook size
#  PC: 820x312
#  Smart Phone: 640x360
# convert -crop 1640x720+100+400 _zz7.png _zz9.png

# ./__vintage1 _zz9.png _textures/2473360890_47e771a3e6_k.jpg _IMG_4604_facebook.png

# convert -resize 1500x -quality 90 _IMG_4604_facebook.png IMG_4604_facebook.png











#
# The following, try and error...
#



#convert                                -size 504x1512 xc:'#ff00ffff' -size 1512x1512 xc:'#00000000' +append mask1.png
#convert -size  504x1512 xc:'#00000000' -size 504x1512 xc:'#000000ff' -size 1008x1512 xc:'#00000000' +append mask2.png
#convert -size 1008x1512 xc:'#00000000' -size 504x1512 xc:'#000000ff' -size  504x1512 xc:'#00000000' +append mask3.png
#convert -size 1512x1512 xc:'#00000000' -size 504x1512 xc:'#000000ff'                                +append mask4.png


# convert -size 504x1512 xc:'#000000ff' -size 1512x1512 xc:'#00000000' +append mask1.png
# convert mask1.png -compose atop IMG_4604.png -geometry +0+0 -composite z.png
#convert mask1.png -compose atop IMG_4604.png -geometry +0+0 -composite z.png


#composite -compose dst-in mask1.png zzz/gy-rd-rd-rd.png -alpha on z1.png
#composite -compose dst-in mask2.png zzz/gy-gr-gr-gr.png -alpha on z2.png
#composite -compose dst-in mask3.png zzz/gy-bl-bl-bl.png -alpha on z3.png
#composite -compose dst-in mask4.png zzz/gy-yl-yl-yl.png -alpha on z4.png


#composite -compose over z1.png  z2.png zz1.png
#composite -compose over zz1.png z3.png zz2.png
#composite -compose over zz2.png z4.png zz3.png
#convert -crop 2016x672+0+400 zz3.png z.png


#convert IMG_4604.png -colorspace gray -write mpr:img +delete \
#mpr:img \( mpr:img -fill red    -colorize 100 \) mask1.png -compose blend -composite -write mpr:img +delete \
#mpr:img \( mpr:img -fill green1 -colorize 100 \) mask2.png -compose blend -composite -write mpr:img +delete \
#mpr:img \( mpr:img -fill blue   -colorize 100 \) mask3.png -compose blend -composite -write mpr:img +delete \
#mpr:img \( mpr:img -fill yellow -colorize 100 \) mask4.png -compose blend -composite \
#result1.png


#convert barn.jpg -colorspace gray -write mpr:img +delete \
#mpr:img \( mpr:img -fill red -colorize 100 \) mask1.png -compose overlay -composite -write mpr:img +delete \
#mpr:img \( mpr:img -fill green1 -colorize 100 \) mask2.png -compose overlay -composite -write mpr:img +delete \
#mpr:img \( mpr:img -fill blue -colorize 100 \) mask3.png -compose overlay -composite -write mpr:img +delete \
#mpr:img \( mpr:img -fill yellow -colorize 100 \) mask4.png -compose overlay -composite \
#result3.jpg


#convert -size 672x1512 xc:red xc:green -size 672x1512 xc:blue +append rgb.jpg
#convert -size 504x1512 xc:red xc:green xc:blue xc:yellow +append rgb.png
#composite -compose Blend      IMG_4604.png rgb.png rgb_Blend.jpg
#composite -compose Bumpmap    IMG_4604.png rgb.png rgb_Bumpmap.jpg
#composite -compose Difference IMG_4604.png rgb.png rgb_Difference.jpg


#  convert -size 2016x1512 xc:'#00000000' -fill '#ff00ffff' -draw "polygon 0,0 260,0 774,1258 524,1512 0,1512" mask1.png
#  convert -size 2016x1512 xc:'#00000000' -fill '#ff00ffff' -draw "polygon 260,0 774,1258 1346,890 1114,0" mask2.png
#  convert -size 2016x1512 xc:'#00000000' -fill '#ff00ffff' -draw "polygon 1114,0 1346,890 2016,1104 2016,0" mask3.png
#  convert -size 2016x1512 xc:'#00000000' -fill '#ff00ffff' -draw "polygon 524,1512 774,1258 1346,890 2016,1104 2016,1512" mask4.png


#  convert -size 2016x1512 xc:'#00000000' -fill '#ff00ffff' -draw "polygon 0,715 325,565 505,920 775,1260 525,1510 0,1512" mask1.png
#  convert -size 2016x1512 xc:'#00000000' -fill '#ff00ffff' -draw "polygon 560,375 775,1075 1290,880 1150,245" mask2.png
#  convert -size 2016x1512 xc:'#00000000' -fill '#ff00ffff' -draw "polygon 1150,0 1150,245 1290,880 2015,1070 2015,0" mask3.png
#  convert -size 2016x1512 xc:'#00000000' -fill '#ff00ffff' -draw "polygon 0,0 0,715 325,565 505,920 775,1260 525,1510 2016,1512 2016,1070 1290,880 775,1075 560,375 1150,245 1150,0" mask4.png


#convert -size 2016x1512 xc:'#00000000' -fill '#ff00ffff' -draw \
#    "polygon 0,645 290,510 495,930 755,1270 510,1515 0,1512" mask1.png

# convert -size 2016x1512 xc:'#00000000' -fill '#ff00ffff' -draw \
#     "polygon 580,335 670,710 795,1075 1280,880 1140,570 1140,215" mask2.png






#convert -size 2016x1512 xc:'#00000000' -fill '#ff00ffff' -draw \
#    "polygon 0,0 380,0 880,1512 0,1512" mask1.png

#convert -size 2016x1512 xc:'#00000000' -fill '#ff00ffff' -draw \
#    "polygon 380,0 880,1512 1600,1512 1170,0" mask2.png

#convert -size 2016x1512 xc:'#00000000' -fill '#ff00ffff' -draw \
#    "polygon 1170,0 1600,1512 2016,1512 2016,0" mask3.png


#   composite -compose dst-in mask1.png zzz/yl-rd-rd-rd.png -alpha on z1.png
#   composite -compose dst-in mask2.png zzz/yl-gr-gr-gr.png -alpha on z2.png
#   composite -compose dst-in mask3.png zzz/yl-bl-bl-bl.png -alpha on z3.png
#   composite -compose dst-in mask4.png zzz/gy-yl-yl-yl.png -alpha on z4.png
#   composite -compose dst-in mask4.png zzz/yl-yl-yl-yl.png -alpha on z4.png
# composite -compose dst-in mask4.png IMG_4604_vintage1.jpg -alpha on z4.png


#composite -compose over z1.png zzz/mg-gy-gy-gy.png xx1.png
#composite -compose over z1.png IMG_4604_vintage1.jpg xx1.png



#composite -compose over z2.png xx1.png xx2.png


#composite -compose over z1.png  z2.png zz1.png
#composite -compose over zz1.png z3.png zz7.png


#  composite -compose over zz2.png z4.png zz3.png

# composite -compose over zz3.png z4.png zz3.png

# ./__vintage1 zz3.png _textures/2473360890_47e771a3e6_k.jpg zz4.png


#convert -font /usr/share/fonts/TTF/Raleway-Regular.ttf \
#    -fill '#ff00ff' -pointsize 30 -annotate +1200+980 "EndeavourOS"  \
#    -fill '#ff00ff' -pointsize 30 -annotate +1200+1010 "macOS" \
#    -fill '#ff00ff' -pointsize 30 -annotate +1200+1040 "Windows" \
#    zz4.png zz5.png


# convert -crop 2016x672+0+400 zz7.png zz8.png

#./__vintage1 zz8.png _textures/2473360890_47e771a3e6_k.jpg zz9.png
