import mysql.connector
import os
import csv
from tqdm import tqdm

cnx = mysql.connector.connect(user='root', password=os.environ['mysqlroot'], host='127.0.0.1', database='imdb')
with cnx.cursor() as db:
    insert_genre = "INSERT INTO genres VALUES (%s)"
    insert_movie = "INSERT INTO movie_genres VALUES (%s, %s)"
    seen_genres = set()

    with open('./Lessons/Lesson 28 - Performance Tuning/title.basics.tsv', 'r', encoding='utf8') as in_file:
        tsv = csv.DictReader(in_file, delimiter='\t')

        for row in tqdm(tsv):
            if row and row['genres']:
                genres = row['genres'].lower().split(',')
                try:
                    genres.remove('\t')
                except:
                    pass

                try:
                    genres.remove('\n')
                except:
                    pass

                for genre in genres:
                    if genre not in seen_genres:
                        seen_genres.add(genre)
                        db.execute(insert_genre, (genre, ))
                    db.execute(insert_movie, (row['tconst'], genre))

            cnx.commit()
    
cnx.close()