#! /bin/bash

pathdata="$PWD/data/"
path="$PWD"
corpus=$pathdata


train()
{
input_file=$1
w2vFile=$2
START=$(date +%s)
printf "\n\nStarted: $START"

printf "${path}/$1...\n"

fname=`basename $input_file .txt`
dname=`dirname $input_file`
#echo $dname
fname=`basename $w2vFile .txt`
fpath=$(cd "$(dirname "$w2vFile")"; pwd)/$(basename "$w2vFile")
dname=`dirname $fpath`
vocabFile=$dname"/"$fname"_vocab.txt"

echo $w2vFile
echo $input_file
echo $vocabFile

$HOME/tools/word2vec/bin/word2vec -train $input_file -output $w2vFile -cbow 0 -size 300 -window 5 -alpha 0.025 -negative 5 -hs 1 -sample 1e-4 -threads 24 -binary 0 -iter 15 -min-count 6 -save-vocab $vocabFile

END=$(date +%s)
DIFF=$((END-START))
printf "\n\nTime taken: $DIFF\n\n"
echo "$(($DIFF / 3600)) hours, $((($DIFF / 60) % 60)) minutes and $(($DIFF % 60)) seconds elapsed."


}



train $1 $2

