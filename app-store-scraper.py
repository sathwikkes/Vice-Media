import pandas as pd
import numpy as np
import json
from api_keys import app_store_api_key

from app_store_scraper import AppStore
vice_media = AppStore(country='us', app_name='vice-media', app_id = app_store_api_key)

vice_media.review(how_many=200)

vice_media.reviews
vice_media_df = pd.DataFrame(np.array(vice_media.reviews),columns=['review'])
vice_media_df1 = vice_media_df.join(pd.DataFrame(vice_media_df.pop('review').tolist()))
vice_media_df1.head()


#vice_media_df1.to_csv("vice-app-reviews.csv")


