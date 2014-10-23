if [ -z $1 ]; then
    echo "Empty extension"
    exit
fi

FIND_PATH=$2
if [ -z $2 ]; then
    FIND_PATH="."
fi

TYPE=$1

find ${FIND_PATH} -maxdepth 1 -type d -print0 | while read -d '' -r dir; do
    files=$(find $dir -type f -name "*.$TYPE" | wc -l);     
    printf "%5d $TYPE files in directory %s\n" "${files}" "$dir" 
done
