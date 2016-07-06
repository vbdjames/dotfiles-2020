cd "$(dirname $0)"

FILES=*.app

for f in $FILES
do
    if [ ! -d /Applications/$f ]
    then
        echo "Copying fluidapp: ${f}"
        cp -r $f /Applications
    fi
done

