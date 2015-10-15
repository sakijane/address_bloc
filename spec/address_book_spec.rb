require_relative '../models/address_book'

RSpec.describe AddressBook do
  let(:book) { AddressBook.new }

  def check_entry(entry, expected_name, expected_number, expected_email)
    expect(entry.name).to eql expected_name
    expect(entry.phone_number).to eql expected_number
    expect(entry.email).to eql expected_email
  end

  describe "attributes" do
    it "should respond to entries" do
      expect(book).to respond_to(:entries)
    end

    it "should initialize entries as an array" do
      expect(book.entries).to be_a(Array)
    end

    it "should initialize entries as empty" do
      expect(book.entries.size).to eq(0)
    end
  end

  describe "#add_entry" do
    it "adds only one entry to the address book" do
      book.add_entry('Ada Lovelace', '010,012.1815', 'augusta.king@lovelace.com')

      expect(book.entries.size).to eq(1)
    end

    it "adds the correct information to entries" do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      new_entry = book.entries[0]

      expect(new_entry.name).to eq('Ada Lovelace')
      expect(new_entry.phone_number).to eq('010.012.1815')
      expect(new_entry.email).to eq('augusta.king@lovelace.com')
    end
  end

  describe "#import_from_csv" do
    it "imports the correct number of entries" do
      book.import_from_csv("entries.csv")
      book.import_from_csv("entries_2.csv")
      book_size = book.entries.size

      expect(book_size).to eql 8
    end

    it "imports the 1st entry" do
       book.import_from_csv("entries.csv")
       entry_one = book.entries[0]
       check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com")
     end

     it "imports the 2nd entry" do
      book.import_from_csv("entries.csv")
      entry_two = book.entries[1]
      check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
    end

    it "imports the 3rd entry" do
      book.import_from_csv("entries.csv")
      entry_three = book.entries[2]
      check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
    end

    it "imports the 4th entry" do
      book.import_from_csv("entries.csv")
      entry_four = book.entries[3]
      check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")
    end

    it "imports the 5th entry" do
      book.import_from_csv("entries.csv")
      entry_five = book.entries[4]
      check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")
    end

    it "imports the 6th entry" do
      book.import_from_csv("entries_2.csv")
      entry_six = book.entries[0]

      expect(entry_six.name).to eql "Juni"
      expect(entry_six.phone_number).to eql "555-555-1234"
      expect(entry_six.email).to eql "juni@okpte.com"
      #check_entry(entry_six, "Juni", "555-555-1234", "juni@okpte.com")
    end

    it "imports the 7th entry" do
      book.import_from_csv("entries_2.csv")
      entry_seven = book.entries[1]
      check_entry(entry_seven, "Lupita", "555-555-6789", "lupita@okpte.com")
    end

    it "imports the 8th entry" do
      book.import_from_csv("entries_2.csv")
      entry_eight = book.entries[2]
      check_entry(entry_eight, "Oliver", "555-555-1212", "oliver@okpte.com")
    end
  end

  describe "#remove_entry" do
    it "removes an entry using the name, phone_number and email" do
      book.add_entry('Michael Faraday', '010.210.5181', 'michael.faraday@faraday.com')

      name = 'Ada Lovelace'
      phone_number = '010.012.1815'
      email = 'augusta.king@lovelace.com'
      book.add_entry(name, phone_number, email)

      expect(book.entries.size).to eq(2)
      book.remove_entry(name, phone_number, email)
      expect(book.entries.size).to eq(1)
      expect(book.entries.first.name).to eq('Michael Faraday')
    end
  end
end
