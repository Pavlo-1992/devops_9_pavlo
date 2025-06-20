from flask import Flask, jsonify, request
from flask_restful import Api, Resource
from marshmallow import Schema, fields, ValidationError
import csv
import os

app = Flask(__name__)
CSV_FILE = 'students.csv'

def read_students():
    students = []
    if not os.path.exists(CSV_FILE):
        return students
    with open(CSV_FILE, newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            row['id'] = int(row['id'])
            row['first_name'] = row['first_name']
            row['last_name'] = row['last_name']
            row['age'] = int(row['age']) 
            students.append(row)
    return students

def write_students(students):
    with open(CSV_FILE, 'w', newline='') as csvfile:
        fieldnames = ['id', 'first_name', 'last_name', 'age']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        for s in students:
            writer.writerow(s)

#Retrieve information about student by their ID
@app.route('/students/<int:id>', methods=['GET'])
def get_student(id):
    students = read_students()
    for s in students:
        if s['id'] == id:
            return jsonify(s)
    return jsonify(error="Student not found"), 404

#Retrieve information about student by their lastname
@app.route('/students/last_name/<last_name>', methods=['GET'])
def get_students_by_last_name(last_name):
    students = read_students()
    matching_students = [s for s in students if s['last_name'] == last_name]
    if matching_students:
        return jsonify(matching_students)
    return jsonify(error="Students not found"), 404

#Retrieve a list of all students
@app.route('/students', methods=['GET'])
def get_all_students():
    return jsonify(read_students()), 200

#Create a new student
@app.route('/students', methods=['POST'])
def create_student():
    data = request.get_json()
    if not data or not all(k in data for k in ('first_name', 'last_name', 'age')):
        return jsonify(error="Missing fields"), 400
    students = read_students()
    new_id = max([s['id'] for s in students], default=0) + 1

    new_student = {
        'id': new_id,
        'first_name': data['first_name'],
        'last_name': data['last_name'],
        'age': int(data['age']),
    }
    students.append(new_student)
    write_students(students)
    return jsonify(new_student), 201

#Update student information by their ID
@app.route('/students/<int:id>', methods=['PUT'])
def update_student(id):
    data = request.get_json()
    if not data or not all(k in data for k in ('first_name', 'last_name', 'age')):
        return jsonify(error="Missing fields"), 400
    
    students = read_students()
    for student in students:
        if student['id'] == id:
            student['first_name'] = data['first_name']
            student['last_name'] = data['last_name']
            student['age'] = str(data['age'])
            write_students(students)
            return jsonify(student), 200

    return jsonify({"error": "Student not found"}), 404

#Update student age by their ID
@app.route('/students/<int:id>', methods=['PATCH'])
def patch_student(id):
    data = request.get_json()
    if not data or 'age' not in data:
        return jsonify(error="Missing age field"), 400
    students = read_students()
    for s in students:
        if s['id'] == id:
            s['age'] = int(data['age'])
            write_students(students)
            return jsonify(s)
    return jsonify(error="Student not found"), 404


#Delete student by their ID
@app.route('/students/<int:id>', methods=['DELETE'])
def delete_student(id):
    students = read_students()
    for student in students:
        if student['id'] == id:
            students.remove(student)
            write_students(students)
            return jsonify({"message": "Student deleted successfully"}), 200

    return jsonify({"error": "Student not found"}), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)


