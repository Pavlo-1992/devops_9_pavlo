import string

class Alphabet:
    def __init__(self, lang, letters):
        self.lang = lang
        self.letters = letters

    def print(self):
        print(" ".join(self.letters))

    def letters_num(self):
        return len(self.letters)

class EngAlphabet(Alphabet):
    _letters_num = 26

    def __init__(self):
        super().__init__("En", list(string.ascii_uppercase))

    def is_en_letter(self, letter):
        return letter.upper() in self.letters

    def letters_num(self):
        return EngAlphabet._letters_num

    @staticmethod
    def example():
        return "This is the English alphabet?"


if __name__ == "__main__":
    eng_alphabet = EngAlphabet()

    print("English Alphabet:")
    eng_alphabet.print()

    print(f"Number of letters in the English alphabet: {eng_alphabet.letters_num()}")

    print(f"Is 'F' an English letter? {eng_alphabet.is_en_letter('F')}")

    print(f"Is 'Щ' an English letter? {eng_alphabet.is_en_letter('Щ')}")


    print("Example text:")
    print(EngAlphabet.example())

