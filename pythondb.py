import psycopg2
from config import config

database_params = config()

def main():
    while True: ## REPL - Read Execute Program Loop
        cmd = input("Command: ")

        if cmd == "list":
            read_dict()
        elif cmd == "quit":
            exit()
        elif cmd == 'add':
            add_to_table()
        elif cmd == 'delete':
            delete_record()
        else:
            print("error")

def db_connection():
    return psycopg2.connect(
        **database_params
)

def add_to_table():
    dbconn = db_connection()
    cur = dbconn.cursor()

    cur.execute('DROP TABLE IF EXISTS dictionary')
    create_database_script = '''CREATE TABLE IF NOT EXISTS dictionary (
                                    id SERIAL PRIMARY KEY,
                                    word TEXT NOT NULL,
                                    translation TEXT NOT NULL)'''
    cur.execute(create_database_script)

    insert_script = 'INSERT INTO dictionary (word, translation) VALUES (%s, %s)'
    insert_values = [('Hello', 'Hei'), ('Cake', 'Kake'), ('Programming', 'Programering'), ('Skole', 'School')]

    for record in insert_values:
        cur.execute(insert_script, record)

    cur.execute("SELECT id, word, translation FROM dictionary;")
    for record in cur.fetchall():
        print(record)

    cur.close()
    dbconn.close()

def delete_record():
    dbconn = db_connection()
    cur = dbconn.cursor()
    delete_script = 'DELETE FROM dictionary WHERE word = %s'
    delete_record = ('Two',)

    cur.execute(delete_script, delete_record)

    cur.execute("SELECT id, word, translation FROM dictionary;")
    for record in cur.fetchall():
        print(record)

    cur.close()
    dbconn.close()

def read_dict():
    dbconn = db_connection()
    cur = dbconn.cursor()
    cur.execute("SELECT id, word, translation FROM dictionary;")
    rows = cur.fetchall()
    for record in rows:
        print(record)

    cur.close()
    dbconn.close()

if __name__ == "__main__":
    main()