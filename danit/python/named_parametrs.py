## Default and named parameters
def greet(name, greeting="Hello", punctuation="!"):
    return f"{greeting}, {name}{punctuation}"

# Example usage
# Using all default parameters
print(greet("Alice"))

# Using a named parameter to change the greeting
print(greet("Bob", greeting="Hi"))

# Using named parameters to change both the greeting and punctuation
print(greet("Charlie", greeting="Good morning", punctuation="."))

# Using all positional arguments
print(greet("David", "Hey", "?"))

# Mixing positional and named arguments
print(greet("Eve", punctuation="!!!"))

