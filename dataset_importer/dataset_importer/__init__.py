import pandas as pd
from pymongo import MongoClient
from dotenv import dotenv_values

config = dotenv_values("../.env")  # config = {"USER": "foo", "EMAIL": "foo@example.org"}

# reading csv file 
df_restaurantes = pd.read_csv("/home/workstation/Projetos/DesafioTecnicoGraoDireto/datasets/restaurants.csv")
df_cardapios = pd.read_csv("/home/workstation/Projetos/DesafioTecnicoGraoDireto/datasets/restaurant-menus.csv")
# print(df_restaurantes.columns.to_list())

myclient = MongoClient(f"mongodb://{config["DB_USER"]}:{config["DB_PASS"]}@localhost:27017/")
mydb = myclient["desafio_tecnico"]
tabela_restaurantes = mydb["restaurantes"]

'''
mydict = { "name": "John", "address": "Highway 37" }

x = mycol.insert_one(mydict)
'''

for index, row in df_restaurantes.iterrows():
    # ['id', 'position', 'name', 'score', 'ratings', 'category', 'price_range', 'full_address', 'zip_code', 'lat', 'lng']
    # print(row['id'], row['position'])

    cardapio_convertido = []

    cardapio = df_cardapios.loc[df_cardapios['restaurant_id'] == row['id']]

    # cardapio = cardapio.drop(columns=['restaurant_id'])

    # print(cardapio.columns.to_list())

    for indice, linha in cardapio.iterrows():
        # print (linha)
        item = {
            'categoria': linha['category'],
            'nome': linha['name'],
            'descricao': linha['description'],
            'preco': linha['price']
        }

        cardapio_convertido.append(item)

    # print(cardapio.head())

    restaurante = {
        'id': row['id'],
        'posicao': row['position'],
        'nome': row["name"],
        'pontuacao': row["score"],
        'avaliacoes': row['ratings'],
        'categoria': row['category'],
        'faixa_preco': row['price_range'],
        'endereco': row['full_address'],
        'codigo_zip': row['zip_code'],
        'lat': row['lat'],
        'lng': row['lng'],
        'cardapio': cardapio_convertido
    }

    x = tabela_restaurantes.insert_one(restaurante)
    
    print(x)

