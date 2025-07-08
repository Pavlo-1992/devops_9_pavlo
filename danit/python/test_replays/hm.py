class Alphabet:
    def __init__(self, lang, letters):
        """
        Initialize the Alphabet class with language and a list of letters.
        :param lang: Language of the alphabet (e.g., 'En', 'Ru').
        :param letters: List of letters in the alphabet.
        """
        self.lang = lang
        self.letters = letters

    def print(self):
        """
        Print all the letters of the alphabet.
        """
        print("".join(self.letters))

    def letters_num(self):
        """
        Return the number of letters in the alphabet.
        """
        return len(self.letters)

class EngAlphabet(Alphabet):
    # Static attribute for the number of letters in the English alphabet
    _letters_num = 26

    def __init__(self):
        """
        Initialize the EngAlphabet class by calling the parent class constructor
        with language as 'En' and the list of English alphabet letters.
        """
        super().__init__('En', list("ABCDEFGHIJKLMNOPQRSTUVWXYZ"))

    def is_en_letter(self, letter):
        """
        Check if a given letter belongs to the English alphabet.
        :param letter: Letter to check.
        :return: True if the letter belongs to the English alphabet, False otherwise.
        """
        return letter.upper() in self.letters

    def letters_num(self):
        """
        Return the number of letters in the English alphabet.
        """
        return self._letters_num

    @staticmethod
    def example():
        """
        Provide an example text in English.
        :return: Example text.
        """
        return "The quick brown fox jumps over the lazy dog."

# Testing the classes
def main():
    # Create an object of the EngAlphabet class
    eng_alphabet = EngAlphabet()

    # Print the alphabet letters
    print("Alphabet letters:")
    eng_alphabet.print()

    # Output the number of letters in the alphabet
    print("Number of letters in the English alphabet:", eng_alphabet.letters_num())

    # Check if the letter 'F' belongs to the English alphabet
    print("Is 'F' an English letter?", eng_alphabet.is_en_letter('F'))

    # Check if the letter 'Щ' belongs to the English alphabet
    print("Is 'Щ' an English letter?", eng_alphabet.is_en_letter('Щ'))

    # Output an example text in English
    print("Example text:", eng_alphabet.example())

if __name__ == "__main__":
    main()

