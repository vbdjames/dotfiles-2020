find . -name "*.terminal" | while read profile ; do 
    sh -c "open -g ${profile}"
done
