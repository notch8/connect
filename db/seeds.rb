Organization.create title: "Organization1", access_code: "testing"

user = User.new name: "admin", email: "admin@example.com", password: "testing123", organization_id: 1, access_code: "testing"
user.add_role "admin"
user.save

User.create name: "user1", email: "user1@example.com", password: "testing123", organization_id: 1, access_code: "testing"

Need.create title: "Need1", amount_requested: 1000000, posted_at: Time.now, description: "The first test need", organization_id: 1, user_id: 1

Need.create title: "Need2", amount_requested: 1000000, posted_at: Time.now, description: "The second test need", organization_id: 1, user_id: 1

Donor.create name: "Donor1", email: "rob@notch8.com", password: "testing123", is_admin: true
Donor.create name: "Donor2", email: "donor2@example.com", password: "testing123"
Donor.create name: "Donor3", email: "donor3@example.com", password: "testing123"
Donor.create name: "Donor4", email: "donor4@example.com", password: "testing123"

Donation.create need_id: 1, donor_id: 2, amount: 10.00
Donation.create need_id: 1, donor_id: 3, amount: 10.00
Donation.create need_id: 1, donor_id: 4, amount: 10.00
