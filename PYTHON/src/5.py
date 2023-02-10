import pandas
import numpy as np
import tensorflow as tf
from keras.models import load_model, save_model
import autokeras as ak
from sklearn.model_selection import train_test_split


train = pandas.read_csv('../dataset/classified_cleaned_data.csv')

X = train['tweet']
y_n = train['neuroticism']
y_e = train['extraversion']
y_o = train['openness']
y_a = train['agreeableness']
y_c = train['conscientiousness']

X_train, X_test, y_train_n, y_test_n, y_train_e, y_test_e, y_train_o, y_test_o, y_train_a, y_test_a, y_train_c, y_test_c = train_test_split(X, y_n, y_e, y_o, y_a, y_c, test_size=0.2)

X_train = np.array(X_train)
X_test = np.array(X_test)
y_train_n = np.array(y_train_n)
y_train_e = np.array(y_train_e)
y_train_o = np.array(y_train_o)
y_train_a = np.array(y_train_a)
y_train_c = np.array(y_train_c)
y_test_n = np.array(y_test_n)
y_test_e = np.array(y_test_e)
y_test_o = np.array(y_test_o)
y_test_a = np.array(y_test_a)
y_test_c = np.array(y_test_c)

loaded_model = load_model('../models/n_model', custom_objects=ak.CUSTOM_OBJECTS)
# loaded_model.fit(tf.expand_dims((X_train), -1), y_train_c, epochs=250)

# loaded_model.save("../models/c_model", save_format='tf')
y_pred_n = loaded_model.predict(tf.expand_dims(X_test, -1))

for a in range(0, len(y_pred_n)):
    print(y_pred_n[a] + " -> " + y_test_n[a])