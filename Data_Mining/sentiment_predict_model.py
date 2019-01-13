import numpy
import pandas

from sklearn.svm import SVC
from sklearn.neighbors import KNeighborsClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.metrics import confusion_matrix, classification_report
from sklearn.externals import joblib

from gensim.models.word2vec import Word2Vec

# Load data
print("加载数据...")
data = pandas.read_csv("./Dictionaries/s_dictionary_1.csv", header=0).ix[:, 0].tolist()
label = pandas.read_csv("./Dictionaries/s_dictionary_1.csv", header=0).ix[:, 1].tolist()
# Load word2vector
w2v_model = Word2Vec.load("./models/model_128.wvm")
# Get the vector feature and label
X = []
y = []
for i in range(len(data)):
    try:
        vector = w2v_model[data[i]]
    except Exception as e:
        continue
    X.append(vector)
    y.append(label[i])
# Split the data into train and test set
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
# Set up the classifier
# classifier1 = SVC(
#     kernel="rbf",
#     probability=True
# )
classifier1 = KNeighborsClassifier(
    n_neighbors=5,
    metric="cosine",
    n_jobs=1
)
classifier0 = KNeighborsClassifier(
    n_neighbors=5,
    metric="cosine",
    n_jobs=1
)
classifier3 = SVC(
    kernel="linear"
)
# classifier2 = RandomForestClassifier(
#     n_estimators=10,
#     criterion='gini',
#     max_depth=None,
#     min_samples_split=2,
#     min_samples_leaf=1,
#     min_weight_fraction_leaf=0.0,
#     max_features="auto",
#     max_leaf_nodes=None,
#     min_impurity_decrease=0.0,
#     min_impurity_split=None,
#     bootstrap=True,
#     oob_score=False,
#     n_jobs=1,
#     random_state=None,
#     verbose=0,
#     warm_start=False,
#     class_weight=None
# )


# Training
print("开始训练...")
classifier0.fit(X, y)
classifier1.fit(X_train, y_train)
# classifier2.fit(X_train, y_train)
classifier3.fit(X, y)

print("Model3")
score = cross_val_score(classifier3, X_train, y_train, cv=10).mean()
prediction = classifier3.predict(X_test)
print("Accuracy:{}".format(score))
print(confusion_matrix(y_test, prediction))
print(classification_report(y_test, prediction))

# print("Model1:")
# score = cross_val_score(classifier2, X_train, y_train, cv=10).mean()
# prediction = classifier2.predict(X_test)
# print("Accuracy:{}".format(score))
# print(confusion_matrix(y_test, prediction))
# print(classification_report(y_test, prediction))

# Save the model
print("保存模型...")
joblib.dump(classifier3, "./models/sentiment_word_svm_model.pkl")
