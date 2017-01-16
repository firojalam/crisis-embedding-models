<<<<<<< HEAD
# Crisis Embedding models

## Data
The data set consists of all tweets collected by AIDR system till December, 2016. After preprocessing and cleaning, it consists 364,635,750 (~364 millions) tweets. We needed to preprocess the data before training the Word-vector model. The preprocessing part took around 5 hours in a machine with 24 cores and 128GB memory. Please check scripts/cmd_data_prep_parallel.sh for details.

**NOTE**: The models we trained are in text format, therefore, please load the model with an appropriate format setting.

### Data cleaning:
1. Lowercased
2. Time pattern replaced with  DATE tag
3. Digits pattern replaced with  DIGIT tag    
4. Pattern replaced with  URL tag    



## Word-vector training model and parameters:
For training the Word-vector the training parameters are as follows:

```sh
./word2vec -train $input_file -output $w2vFile -cbow 0 -size 400 -window 5 -alpha 0.025 -negative 5 -hs 1 -sample 1e-4 -threads 24 -binary 0 -iter 15 -min-count 5 -save-vocab $vocabFile
```
The trained model consists of a vocabulary with size: 7976291 (~7 millions) and 400 dimensional vector. The training file contains 5379772529 (~5 billions) words.
The time required to train this model was 12 hours, 28 minutes.


## Phrase-vector training model and parameters:
The same data has been used for training the phrase vector model. Below are the parameters that has been used to design the phrase vector model. The idea of phrase is basically designing bigram based on unigram and bigram counts as discussed in this [paper](https://papers.nips.cc/paper/5021-distributed-representations-of-words-and-phrases-and-their-compositionality.pdf). Typical approach is to use more than one pass (2-4) to design phrase, here, we used two passes as shown below.  

```sh
./word2vec/bin/word2phrase -train $input_file -output $phrase0 -threshold 100 -debug 2
./word2vec/bin/word2phrase -train $phrase0 -output $phrase1 -threshold 50 -debug 2
./word2vec/bin/word2vec -train $phrase1 -output $w2vFile -cbow 0 -size 300 -window 5 -alpha 0.025 -negative 5 -hs 1 -sample 1e-4 -threads 40 -binary 0 -iter 15 -min-count 5 -save-vocab $vocabFile
```
The vocabulary size of the trained model is 13054016 (~13 millions), which includes unigrams and bigrams. Moreover, the training file consists of 3963405531 (~3 billions) words. The time required to train the model was 14 hours, 17 minutes on the machine mentioned above.

## Sentence-vector training model and parameters:
Coming soon ....



## Directory Structure:
1. *data/crisis_tweets_raw_data.tar.gz* - raw tweets extracted from json file, which is collected by AIDR system over the time till December 2016.
2. *data/crisis_data_preprocessed.tar.gz* - preprocessed tweets from raw tweets.
3. *scripts/** - contans various scripts for preprocessing and training.
4. *model/** - contains different trained model in text format.
=======
# crisis-tweets

Few examples from tweets how we use shorthand forms:



639482119295668224
I c how it is

639864522652655617	"Is it only Suffolk bc Becky and I are p sure ppl had like a month off in college lmao"	


639616631367434240	"@SenWarren @stonehill_info so if you could do that for them how come you couldn't meet with small group from suffolk that had an appt w you?"

>>>>>>> 126dc08dcb21c0714526b8b43713861853d3559a
