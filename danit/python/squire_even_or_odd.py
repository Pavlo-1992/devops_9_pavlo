#The program takes a list of numbers, 
#calculates their square, 
#and classifies each number as even or odd.


def calculation(numbers_list):

	for i in numbers_list:
		square = i ** 2
		if i % 2 == 0:
			print(f"The number {i} is even and its square is {square}")
		else:
			print("This number {0} is not even".format(i))


def main():
	numbers_list = [1, 2, 3, 4, 5, 6]

	calculation(numbers_list)

if __name__ == "__main__":
	main()

