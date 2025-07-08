def calculate_sum(numbers):
    total = 0
    for number in numbers:
        total += number
    return total

# Example usage
numbers = [1, 2, 3, 4, 5]
result = calculate_sum(numbers)

print(f"The sum of {numbers} is {result}")

