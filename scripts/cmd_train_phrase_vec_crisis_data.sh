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
phrase0=$dname"/"$fname".phrase0"
phrase1=$dname"/"$fname".phrase1"
fname=`basename $w2vFile .txt`
dname=`dirname $w2vFile`
vocabFile=$dname"/"$fname"_vocab.txt"


$HOME/tools/word2vec/bin/word2phrase -train $input_file -output $phrase0 -threshold 100 -debug 2
$HOME/tools/word2vec/bin/word2phrase -train $phrase0 -output $phrase1 -threshold 50 -debug 2
$HOME/tools/word2vec/bin/word2vec -train $phrase1 -output $w2vFile -cbow 0 -size 300 -window 5 -alpha 0.025 -negative 5 -hs 1 -sample 1e-4 -threads 40 -binary 0 -iter 15 -min-count 5 -save-vocab $vocabFile

END=$(date +%s)
DIFF=$((END-START))
printf "\n\nTime taken: $DIFF min\n\n"
echo "$(($DIFF / 3600)) hours, $((($DIFF / 60) % 60)) minutes and $(($DIFF % 60)) seconds elapsed."


}



train $1 $2

