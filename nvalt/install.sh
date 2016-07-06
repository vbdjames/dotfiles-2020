if [ ! -f ~/Library/Preferences/net.elasticthreads.nv.plist ]
then
    echo "nvAlt has to be started and shit down before options can be set."
    open /Applications/nvALT.app
    echo "After nvAlt starts, please exit normally, and press return to continue."
    read dummy
fi

defaults write net.elasticthreads.nv HorizontalLayout -int 1
defaults write net.elasticthreads.nv TableFontPointSize -int 12
defaults write net.elasticthreads.nv KeepsMaxTextWidth -int 1
defaults write net.elasticthreads.nv AlternatingRows -int 1
defaults write net.elasticthreads.nv NoteBodyMaxWidth -int 880

defaults write net.elasticthreads.nv SearchTermHighlightColor -data "040b73747265616d747970656481e803840140848484074e53436f6c6f72008484084e534f626a656374008584016301840466666666838f4b7d3f83d03b753f8306335d3f0186"

defaults write net.elasticthreads.nv ForegroundTextColor -data "040b73747265616d747970656481e803840140848484074e53436f6c6f72008484084e534f626a65637400858401630184046666666683bc93e13e831177023f83ce50043f0186"

defaults write net.elasticthreads.nv BackgroundTextColor -data "040b73747265616d747970656481e803840140848484074e53436f6c6f72008484084e534f626a65637400858401630184046666666683e673823c83b38e013e835a87233e0186"

