require 'rails_helper'

RSpec.describe User, type: :model do
  let (:organization) { Organization.create title: "test", access_code: "test" }

  context "access code" do
    let (:user) { User.new email: "test@test.test", password: "testing123" }

    it "should be valid with an organization access code" do
      user.access_code = organization.access_code
      expect(user).to be_valid
    end

    it "should be invalid if there is no access code" do
      user.access_code = ""
      expect(user).not_to be_valid
    end

    it "should be invalid if the access code does not match an existing organization" do
      user.access_code = "chumbawumba"
      expect(user).not_to be_valid
    end

    it "should not check access code on update" do
      user.access_code = organization.access_code
      user.save

      user.update_attributes({email: "new@new.new", access_code: "chumbawumba"})
      expect(user).to be_valid
    end
  end

  context "roles and abilities" do
    let (:admin_user) do 
      user = User.create(email: "admin@test.com", password: "testing123", access_code: "test")
      user.add_role("admin")
      user
    end
    let (:non_admin_user) { User.create(email: "bob@test.com", password: "testing123", access_code: "test") }

    let (:need_1) { Need.create(title: "testneed1", user_id: non_admin_user.id) }
    let (:need_2) { Need.create(title: "testneed2", user_id: 0) }

    it "admin should be able to edit needs" do
      ability = Ability.new(admin_user)
      expect(ability).to be_able_to(:edit, need_1)
    end

    it "non-admin should be able to edit it's own needs" do
      ability = Ability.new(non_admin_user)
      expect(ability).to be_able_to(:edit, need_1)
    end

    it "non-admin should not be able to edit others' needs" do
      ability = Ability.new(non_admin_user)
      expect(ability).not_to be_able_to(:edit, need_2)    
    end
  end
end
