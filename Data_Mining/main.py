import pre_processing
import tf_idf_key_words

import numpy
import pandas

from sklearn.externals import joblib
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report
from gensim.models.word2vec import Word2Vec

# Load data
print("加载数据...")
data = pandas.read_csv(
    "./Test_data/test_data.csv",
    header=None
)
dan_ma_ku_list = data.ix[:, 0].tolist()
label = data.ix[:, 1].tolist()
# Load Models
print("加载模型...")
# Word2vector model
w2v_model = Word2Vec.load("./models/model_128.wvm")
# Sentiment word model
sw_model = joblib.load("./models/sentiment_word_lr_model.pkl")
# Load Dictionary
data = pandas.read_csv("./Dictionaries/s_dictionary_1.csv", header=0).ix[:, 0].tolist()
sentiment = pandas.read_csv("./Dictionaries/s_dictionary_1.csv", header=0).ix[:, 1].tolist()
s_dict = dict(zip(data, sentiment))

# Preprocessing and create the train and test sets
X = list()
y = list()
for i in range(len(dan_ma_ku_list)):
    processed = pre_processing.word_segmentation(dan_ma_ku_list[i])
    if len(processed) != 0:
        X.append(processed)
        y.append(label[i])
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=388)
# Get key words by TF-IDF value
tf_idf_key_words.word_select(X)
# Load key words
f = open("./tmp/key_words.txt")
key_words = list()
lines = list(f.readlines())
for line in lines:
    key_words.append(line[0: -1])
f.close()
word_list = list()
vectors = list()
for i in range(len(key_words)):
    try:
        vector = w2v_model[key_words[i]]
    except Exception as e:
        continue
    word_list.append(key_words[i])
    vectors.append(vector)

# # Get Expand Dictionary
# print("构建扩展情感词典...")
# s = sw_model.predict(vectors)
# ex_dict = dict(zip(word_list, sentiment))
# # Save expanded dictionary
# f = open('./tmp/ex_dict.txt', 'a+')
# f.write(str(ex_dict))
# f.close()
# Load expanded dictionary
f = open('./tmp/ex_dict.txt')
a = f.read()
ex_dict = eval(a)
f.close()

# 尝试常规的机器学习情感分析方法，做一个简单的比较
# Get TF-IDF feature
tf_idf = TfidfVectorizer(
    min_df=3,
    max_features=None,
    strip_accents='unicode',
    analyzer='word',
    token_pattern=r'\w{1,}',
    ngram_range=(1, 2),
    use_idf=1,
    smooth_idf=1,
    sublinear_tf=1,
    stop_words='english'
)
tf_idf.fit(X_train + X_test)
X_train = tf_idf.transform(X_train)
X_test_1 = tf_idf.transform(X_test)
# Set up Classifier
classifier0 = SVC(
    kernel="linear",
)
classifier1 = RandomForestClassifier()
# Training
classifier0.fit(X_train, y_train)
classifier1.fit(X_train, y_train)
# Predict
prediction0 = classifier0.predict(X_test_1)
prediction1 = classifier1.predict(X_test_1)
# Scores
c_matrix0 = classification_report(y_test, prediction0)
c_matrix1 = classification_report(y_test, prediction1)

# 扩展词典情感分析
prediction2 = list()
s_key = s_dict.keys()
ex_key = ex_dict.keys()
for dan_ma_ku in X_test:
    score = 0
    words = dan_ma_ku.split(' ')
    for word in words:
        if word in s_key:
            score += s_dict[word]
        elif word in ex_key:
            score += ex_dict[word]
        else:
            continue
    if score > 0:
        score = 1
    elif score < 0:
        score = -1
    prediction2.append(score)
prediction2 = numpy.array(prediction2)
c_matrix2 = classification_report(y_test, prediction2)

# Print the result
print("TF-IDF + SVM:")
print(c_matrix0)
print("TF-IDF + Random Forest:")
print(c_matrix1)
print("Extend Dictionary:")
print(c_matrix2)
