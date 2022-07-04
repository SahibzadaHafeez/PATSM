import pandas
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.feature_extraction import DictVectorizer
from scipy.sparse import hstack
from sklearn.linear_model import Ridge
from sklearn.model_selection import train_test_split

from keras.preprocessing import sequence
from keras.models import Sequential
from keras.preprocessing import text
from keras.utils import pad_sequences
import wandb

from sklearn.ensemble import RandomForestRegressor


train = pandas.read_csv('../dataset/cleaner_dataset.csv')

train['tweet'] = train['tweet'].str.lower()
train['tweet'] = train['tweet'].replace('[^a-zA-Z0-9]', ' ', regex = True)

X = train['tweet']
y = train['neuroticism']

wandb.init()
config = wandb.config

#set papameters
config.vocab_size = 2000
config.maxlen = 30
config.batch_size = 32
config.embedding_dims = 10
config.filters = 16
config.kernel_size = 3
config.hidden_dims = 250
config.epochs = 10

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

tokenizer = text.Tokenizer(num_words = config.vocab_size)
tokenizer.fit_on_texts(X_train)
X_train = tokenizer.texts_to_matrix(X_train)
X_test = tokenizer.texts_to_matrix(X_test)

#X_train = pad_sequences(X_train, maxlen = config.maxlen)
#X_test = pad_sequences(X_test, maxlen = config.maxlen)

model = RandomForestRegressor(n_estimators=200)
model.fit(X_train, y_train)

for i in range(len(X_train[0])):
    print(X_train[1][i])