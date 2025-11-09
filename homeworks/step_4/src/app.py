import socket
from flask import Flask, render_template, request, redirect, url_for
from shop import PetShop
import os

app = Flask(__name__)

# === Database Config ===
host = os.getenv('DB_HOST')
user = os.getenv('DB_USER')
password = os.getenv('DB_PASSWORD')
db_name = os.getenv('DB_NAME')

petshop = None  # створюємо наперед

if os.getenv("SKIP_DB_CONNECT") == "1":
    print("⚙️ SKIP_DB_CONNECT=1 — пропуск инициализации MySQL (CI тесты)")
else:
    try:
        from mysql_connector import Mysql
        petshop = PetShop(host, user, password)
        petshop.create_shop()
    except Exception as e:
        print(f"Не вдалося підключитись до MySQL: {e}")
        petshop = None
        
# === Initialize PetShop (only if not in CI) ===
if os.getenv("SKIP_DB_CONNECT") == "1":
    print("⚙️ SKIP_DB_CONNECT=1 — пропуск инициализации MySQL (CI тесты)")
    petshop = None
else:
    from mysql_connector import Mysql
    petshop = PetShop(host, user, password)
    petshop.create_shop()


# === Helper to get local IP ===
def get_host_ip():
    try:
        hostname = socket.gethostname()
        local_ip = socket.gethostbyname(hostname)
        return local_ip
    except Exception as e:
        return f"Unable to retrieve Host IP: {str(e)}"


# === Routes ===
@app.route('/')
def index():
    host_ip = get_host_ip()
    return render_template('index.html', host_ip=host_ip)


@app.route('/add_pet', methods=['GET', 'POST'])
def add_pet():
    if os.getenv("SKIP_DB_CONNECT") == "1":
        return render_template('add_pet.html', error="DB connection disabled in CI mode.")

    if request.method == 'POST':
        name = request.form['name']
        price = request.form['price']

        if not name or not price:
            return render_template('add_pet.html', error="Please provide both name and price.")
        
        ids = petshop.add_item(name, price)
        return render_template('add_pet.html', success=f"Pet added with ID(s): {ids}")

    return render_template('add_pet.html')


@app.route('/delete_pet', methods=['GET', 'POST'])
def delete_pet():
    if os.getenv("SKIP_DB_CONNECT") == "1":
        return render_template('delete_pet.html', error="DB connection disabled in CI mode.")

    if request.method == 'POST':
        id = request.form['id']

        if not id:
            return render_template('delete_pet.html', error="Please provide an ID.")

        res = petshop.delete_item_by_id(id)
        if not res:
            return render_template('delete_pet.html', error="Pet not found!")
        return render_template('delete_pet.html', success="Pet deleted successfully.")

    return render_template('delete_pet.html')


@app.route('/list_pets')
def list_pets():
    if os.getenv("SKIP_DB_CONNECT") == "1":
        pets = []
    else:
        pets = petshop.get_all_items()
    return render_template('list_pets.html', pets=pets)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
