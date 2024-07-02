import psycopg2
from config import config

def db_connection():
    return psycopg2.connect(
        **database_params
)

def read_dict():
    dbconn = db_connection()
    cur = dbconn.cursor()
    cur.execute("SELECT id, word, translation FROM dictionary;")
    rows = cur.fetchall()
    cur.close()
    dbconn.close()
    return rows

database_params = config()

while True: ## REPL - Read Execute Program Loop
    cmd = input("Command: ")

    if cmd == "list":
        read_dict()
    elif cmd == "quit":
        exit()
    else:
        print("error")