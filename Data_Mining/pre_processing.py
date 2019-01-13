import re
import jieba

# Load user dictionary
# u_dict = "冰菓,冰菓,氷菓,冰菓,冰果,Hyouka".split(',')
u_dict = list()
with open("./Dictionaries/user_dictionary.txt") as ud:
    for l in ud.readlines():
        u_dict.append(l)
for word in u_dict:
    jieba.suggest_freq(word, True)


def clean_raw_data(path):
    res = open("./tmp/cleaned.txt", "w+")
    with open(path, "r") as raw:
        for line in raw.readlines():
            line = re.sub("</d>", '', line)
            line = re.sub("<d p=[\w\W]+?>", '\n', line)
            line = re.sub("<[\w\W]+?>", '', line)
            line = re.sub("chat.bilibili.com.+?-\w", '' ,line)
            res.write(line)
    res.close()


def word_segmentation(data):
    # Create stopwords list
    stopwords = [
        line.strip()
        for line in
        open("./Dictionaries/stopwords.txt", 'r', encoding='utf-8').readlines()
    ]
    segmented_data = jieba.cut(data.strip())
    stopwords_removed_data = ""
    for w in segmented_data:
        if w not in stopwords:
            if w != '\t':
                stopwords_removed_data += (w + " ")
    stopwords_removed_data.strip()
    return stopwords_removed_data


def remove_stopwords(seg_data):
    stopwords = [
        line.strip()
        for line in
        open("./Dictionaries/stopwords.txt", 'r', encoding='utf-8').readlines()
    ]


def main():
    clean_raw_data("/home/nico/GitHub/Assignments_in_GDUFS/Data_Mining/spider/raw_data/sub_corpus.xml")
    with open("./tmp/cleaned.txt", 'r') as f:
        for line in f.readlines():
            with open("./tmp/sub_corpus.txt", 'a+') as f1:
                if line != '':
                    f1.write(word_segmentation(line) + '\n')


if __name__ == "__main__":
    main()
