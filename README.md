# Crisis Embedding models

## Data
The data set consists of all tweets collected by AIDR system till December, 2016. After preprocessing and cleaning, it consists 364,635,750 (~364 millions) tweets. We needed to preprocess the data before training the Word-vector model. The preprocessing part took around 5 hours in a machine with 24 cores and 128GB memory. Please check scripts/cmd_data_prep_parallel.sh for details.

**NOTE**: The models we trained are in text format, therefore, please load the model with an appropriate format setting.

### Data cleaning/preprocessing:
1. Lowercased
2. Removed time pattern
3. Removed digits pattern
4. Removed URL pattern    
5. Removed special characters and # symbol
6. Removed single character
7. Removed username started with @
8. Reduced repeated characters
9. Has not removed retweet
10. Removed stop words


## Word-vector training model and parameters:
For training the Word-vector the training parameters are as follows:

```sh
./word2vec -train $input_file -output $w2vFile -cbow 0 -size 300 -window 5 -alpha 0.025 -negative 5 -hs 1 -sample 1e-4 -threads 24 -binary 0 -iter 15 -min-count 5 -save-vocab $vocabFile
```
The trained model consists of a vocabulary with size: 2152854 (~2 millions) and 300 dimensional vector. The training file contains 2896124746 (~3 billions) words.
The time required to train this model was 6 hours, 31 minutes.


## Phrase-vector training model and parameters:
The same data has been used for training the phrase vector model. Below are the parameters that has been used to design the phrase vector model. The idea of phrase is basically designing bigram based on unigram and bigram counts as discussed in this [paper](https://papers.nips.cc/paper/5021-distributed-representations-of-words-and-phrases-and-their-compositionality.pdf). Typical approach is to use more than one pass (2-4) to design phrase, here, we used two passes as shown below.  

```sh
./word2vec/bin/word2phrase -train $input_file -output $phrase0 -threshold 100 -debug 2
./word2vec/bin/word2phrase -train $phrase0 -output $phrase1 -threshold 50 -debug 2
./word2vec/bin/word2vec -train $phrase1 -output $w2vFile -cbow 0 -size 300 -window 5 -alpha 0.025 -negative 5 -hs 1 -sample 1e-4 -threads 40 -binary 0 -iter 15 -min-count 5 -save-vocab $vocabFile
```

The vocabulary size of the trained model is 9681957 (~9 millions), which includes unigrams and bigrams. Moreover, the training file consists of 1935598447 (~2 billions) words. The time required to train the model was 8 hours, 5 minutes on the machine mentioned above.

## Sentence-vector training model and parameters:
Coming soon ....

## Converting text format model to binary format:

```python
from gensim.models import word2vec

model = word2vec.Word2Vec.load_word2vec_format('crisis_word_vector.txt', binary=False)
model.save_word2vec_format('crisis_word_vector.bin', binary=True)

```

## Download:
Please download the model from [CrisisNLP](http://crisisnlp.qcri.org/crisis_w2v_model/crisis_word_vector.tar.gz).

## How to use?:
**Find the top ten most similar words of the word 'shelter'**

```python
from gensim.models import word2vec
model = word2vec.Word2Vec.load_word2vec_format('crisis_word_vector.bin', binary=True)
words=model.most_similar(positive=['shelter'], negative=[], topn=20)

for w in words:
  print w[0]
# Few examples of most similar words
needs
somewhere
safe
needing
gurdwara
tonight
opened
give
stranded
offering
temple
unicef
help
#Finding the word vector
vector = model['shelter']
```

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

## Please Cite the Following Papers

*Firoj Alam, Shafiq Joty, Muhammad Imran. Graph Based Semi-supervised Learning with Convolutional Neural Networks to Classify Crisis Related Tweets, International AAAI Conference on Web and Social Media (ICWSM), 2018, Stanford, California, USA.*
```bib
@inproceedings{alam2016bidirectional,
  title={Graph Based Semi-supervised Learning with Convolutional Neural Networks to Classify Crisis Related Tweets},
  author={Firoj Alam, Shafiq Joty, Muhammad Imran},
  booktitle={International AAAI Conference on Web and Social Media (ICWSM)},
  year={2018},
  organization={AAAI}
}
```


*Firoj Alam, Shafiq Joty, Muhammad Imran. Domain Adaptation with Adversarial Training and Graph Embeddings. 56th Annual Meeting of the Association for Computational Linguistics (ACL), 2018, Melbourne, Australia.*

```bib
@inproceedings{alam2016bidirectional,
  title={Domain Adaptation with Adversarial Training and Graph Embeddings},
  author={Firoj Alam, Shafiq Joty, Muhammad Imran},
  booktitle={56th Annual Meeting of the Association for Computational Linguistics (ACL)},
  year={2018},
  organization={ACL}
}
```
