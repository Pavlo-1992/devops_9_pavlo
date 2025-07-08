with open("test", "w") as file:
    file.write("Hello, World!\n")
    file.write("This is a new file.\n")

with open("test", "a") as file:
    file.write("This line is appended.")


'''
with open("test", "r") as file:
    content = file.read()
    print(content)
'''

with open("test", "r") as file:
    for line in file:
        if "World" in line:
         print(f"{line.strip()} has word World in it")
        else: 
         print(f"{line.strip()} does not hane word World in it")


