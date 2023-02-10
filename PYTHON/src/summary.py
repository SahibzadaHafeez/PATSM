import pandas
import numpy as np
import tensorflow as tf
from keras.models import load_model, save_model
import autokeras as ak
from sklearn.model_selection import train_test_split

loaded_model = load_model(('../models/n_model'), custom_objects=ak.CUSTOM_OBJECTS)
loaded_model.summary()