from sklearn.feature_extraction.text import TfidfVectorizer


def word_select(docs):
    stopwords = [
        line.strip()
        for line in
        open("./Dictionaries/stopwords.txt", 'r', encoding='utf-8').readlines()
    ]
    tf_idf_model = TfidfVectorizer(
        min_df=3,
        max_features=None,
        strip_accents='unicode',
        analyzer='word',
        token_pattern=r'\w{1,}',
        ngram_range=(1, 2),
        use_idf=1,
        smooth_idf=1,
        sublinear_tf=1,
        stop_words=stopwords
    )
    tf_idf = tf_idf_model.fit_transform(docs)
    docs = []
    word = tf_idf_model.get_feature_names()
    weight = tf_idf.toarray()

    word_list = list()
    for i in range(len(weight)):
        max_weight = 0
        word0 = ''
        for j in range(len(word)):
            if weight[i][j] > max_weight:
                word0 = word[j]
                max_weight = weight[i][j]
        word_list.append(word0)
    word_list = set(word_list)
    with open("./tmp/key_words.txt", "a+") as f2:
        for w in word_list:
            f2.write(w + '\n')
