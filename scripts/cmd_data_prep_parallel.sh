#! /bin/bash

pathdata="$PWD/data/all_data"
path="$PWD"
corpus=$pathdata


data_prep()
{
input_files=$1
outdir=$2
START=$(date +%s)
printf "${path}/$1...\n"
args=()
while read line
do
	args+=("$line");
done <"${path}/$input_files" 

echo "starting...."
export -f doit
$HOME/tools/parallel/bin/parallel --no-notice -j40 doit ::: "${args[@]}" ::: $outdir

END=$(date +%s)
MIN=$(( $(($END - $START)) /60 ))

printf "\n\nTime taken: $MIN min\n\n"

}

doit()
{
pathdata="$PWD/data/all_data"
path="$PWD"
corpus=$pathdata
fname=$1
outdir=$2
#/export/sc1/firoj/tools/anaconda2/bin/python scripts/Prep_data_for_W2V.py -i $fname -o $outdir
$HOME/anaconda2/bin/python scripts/Prep_data_for_W2V.py -i $fname -o $outdir

}

data_prep $1 $2

