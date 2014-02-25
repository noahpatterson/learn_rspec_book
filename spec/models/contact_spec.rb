require 'spec_helper'

describe Contact do
    it "has a valid factory" do
        expect(build(:contact)).to be_valid 
    end

    it "has three phone numbers" do
        expect(create(:contact).phones.count).to eq 3
    end

    it "is valid with a firstname, lastname, email, and phone" do
        contact = Contact.new(
            firstname: 'Aaron',
            lastname: 'Sumner',
            email: 'tester@exmaple.com',
            phones: [build(:mobile_phone), build(:work_phone), build(:home_phone)]
            )
        expect(contact).to be_valid
    end

    it "is invalid without a firstname" do
        contact = build(:contact, firstname: nil)
        expect(contact).to have(1).errors_on(:firstname)
    end
  
    it "is invalid without a lastname" do 
        contact = build(:contact, lastname: nil)
        expect(contact).to have(1).errors_on(:lastname) 
    end

    it "is invalid without a email address" do 
        contact = build(:contact, email: nil)
        expect(contact).to have(1).errors_on(:email)  
    end

    it "is invalid with a duplicate email address" do 
        # Contact.create(firstname: 'noah', lastname: 'p', email: "this@that.com")
        create(:contact, email: "this@that.com")
        expect(build(:contact, email: "this@that.com")).to have(1).errors_on(:email)
    end

    it "returns a contact's full name as a string" do 
        contact = build(:contact, firstname: "Jane", lastname: "Doe")
        expect(contact.name).to eq 'Jane Doe'
    end

    describe "filter first name by letter" do
        before :each do
                @john = create(:contact, firstname: 'john', lastname: 'p', email: "this@that1.com")
                @sam = create(:contact, firstname: 'sam', lastname: 'p', email: "this@that2.com")
                @judith = create(:contact, firstname: 'judith', lastname: 'p', email: "this@that3.com")
            end

        context 'matching letters' do
            it "returns a sorted array by first letter" do
                expect(Contact.name_search('j')).to eq([@john, @judith])
            end
        end

        context 'non-matching letters' do
            it "returns a sorted array by first letter" do
                expect(Contact.name_search('j')).to_not include @sam
            end     
        end
    end

    describe "#hide contact" do
      it "hides a contact" do
          contact = create(:contact)
          expect(contact.hidden).to be_true
      end
    end
end