import random

def guess_number_game():
    random_number = random.randint(1, 100)
    counter = 5

    while counter > 0:
        try:
            number = int(input("Enter a number:"))  

            if number == random_number:
                print("Congratulations! You guessed the right number.")
                break
            elif number > random_number:
                print("Too high!")
            if number < random_number:
                print("Too low!")

            counter -= 1
            print(f"Attempts left: {counter}")
        except ValueError:
            print("Invalid input! Please enter an integer.")

    if counter == 0:
      print(f"Sorry, you've run out of attempts. The correct number was {random_number}.")


if __name__ == "__main__":
    guess_number_game()
