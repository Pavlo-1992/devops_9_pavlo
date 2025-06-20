import requests


BASE_URL = 'http://127.0.0.1:5000'
RESULTS_FILE = 'results.txt'

def log_results(message):
    with open(RESULTS_FILE, 'a') as f:
        f.write(message + '\\n')

#Retrieve all existing students (GET).
def test_get_all_student():
    response = requests.get(f'{BASE_URL}/students')
    print(f'GET /students:', response.status_code, response.json()) 
    log_results(f'GET /students: {response.status_code} {response.json()}')


#Create students (POST).
def test_post_student():
    students = [
        {'first_name': 'Pavlo', 'last_name': 'First', 'age': 32},
        {'first_name': 'Bob', 'last_name': 'Second', 'age': 21},
        {'first_name': 'Carol', 'last_name': 'Third', 'age': 44}
    ]
    
    for student in students:
        response = requests.post(f'{BASE_URL}/students', json=student)
        print('POST /students:', response.status_code, response.json())

#Update the age of the student (PATCH).
def test_patch_student_age(student_id):
    patch_data = {'age': 99}
    response = requests.patch(f'{BASE_URL}/students/{student_id}', json=patch_data)
    print(f'PATCH /students/{student_id}:', response.status_code, response.json())
    log_results(f'PATCH /students: {response.status_code} {response.json()}')

#Retrieve information about student (GET).
def test_get_student(student_id):
    response = requests.get(f'{BASE_URL}/students/{student_id}')
    print(f'GET /students/{student_id}:', response.status_code, response.json())
    log_results(f'GET /students: {response.status_code} {response.json()}')

#Update the fist name, last name and the age of the student (PUT).
def test_put_student(student_id):
    put_data = {'first_name': 'New', 'last_name': 'Wen', 'age':88 }
    response = requests.put(f'{BASE_URL}/students/{student_id}', json=put_data)
    print(f'PUT /students:', response.status_code, response.json())
    log_results(f'PUT /students: {response.status_code} {response.json()}')


#Delete the student (DELETE).
def test_delete_student(student_id):
    response = requests.delete(f'{BASE_URL}/students/{student_id}')
    print(f'DELETE /students/{student_id}:', response.status_code, response.json())
    log_results(f'DELETE /students: {response.status_code} {response.json()}')

if __name__ == '__main__':
    test_get_all_student()
    test_post_student()
    test_get_all_student()
    test_patch_student_age(2)
    test_get_student(2)
    test_put_student(3)
    test_get_student(3)
    test_get_all_student()
    test_delete_student(1)
    test_get_all_student()    
