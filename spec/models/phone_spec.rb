require 'spec_helper'

describe Phone do
    it "does not allow duplciate phone numbers per contact" do
        contact = create(:contact)
        create(:home_phone, contact: contact, phone: '785-555-1234')
        mobile_phone = build(:mobile_phone, contact: contact, phone: '785-555-1234')
        expect(mobile_phone).to have(1).errors_on(:phone)
    end

    it "allows two contacts to share a phone number" do
       contact = create(:contact)
        create(:home_phone, contact: contact, phone: '785-555-1234')
        other_contact = create(:contact)
        other_phone = build(:home_phone, contact: other_contact, phone: '785-555-1234')
        expect(other_phone).to be_valid 
    end
 
end