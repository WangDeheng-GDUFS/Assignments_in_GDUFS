import logging
from gensim.models.word2vec import LineSentence, Word2Vec

print("加载数据...")
logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
sentences = LineSentence('./tmp/sub_corpus.txt')
print("开始训练...")
word_model = Word2Vec(
    sentences,
    sg=1,
    size=128,
    window=3,
    min_count=40,
    negative=3,
    sample=1e-3,
    hs=1,
    workers=4
)
print('保存模型...')
word_model.init_sims(replace=True)
model_name = "model_128.wvm"
word_model.save(model_name)
