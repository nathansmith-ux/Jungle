require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    before do
    User.create!(
      first_name: 'Alex',
      last_name: 'Jones',
      email: 'test@test.COM',
      password: 'password123',
      password_confirmation: 'password123'
    )
    end

    it 'is valid with a matching password and password_confirmation' do
      user = User.new(
        first_name: 'Nate',
        last_name: 'Smt',
        email: 'hello123@gmail',
        password: 'hello123',
        password_confirmation: 'hello123'
      )

      expect(user).to be_valid
    end

    it 'is not valid with a mismatch between password and password_confirmation' do
      user = User.new(
        first_name: 'Nate',
        last_name: 'Smt',
        email: 'hello123@gmail',
        password: 'hello123',
        password_confirmation: 'Hello123'
      )

      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is not valid without a password' do
      user = User.new(
        first_name: 'Nate',
        last_name: 'Smt',
        email: 'hello123@gmail',
        password: '',
        password_confirmation: 'Hello123'
      )

      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is not valid without a password_confirmation' do
      user = User.new(
        first_name: 'Nate',
        last_name: 'Smt',
        email: 'hello123@gmail',
        password: 'hello123',
        password_confirmation: ''
      )

      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is not valid without an email' do
      user = User.new(
        first_name: 'Nate',
        last_name: 'Smt',
        email: nil,
        password: 'hello123',
        password_confirmation: 'hello123'
      )

      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is not valid without a first name' do
      user = User.new(
        first_name: nil,
        last_name: 'Smt',
        email: 'hello123@gmail',
        password: 'hello123',
        password_confirmation: 'hello123'
      )

      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'is not valid without a last name' do
      user = User.new(
        first_name: 'Nate',
        last_name: nil,
        email: 'hello123@gmail',
        password: 'hello123',
        password_confirmation: 'hello123'
      )

      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'is not valid if the password is too short' do
      user = User.new(
        first_name: 'Nate',
        last_name: 'hello123@gmail.com',
        email: 'hello123@gmail',
        password: 'hello',
        password_confirmation: 'hello'
      )

      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      User.create!(
        first_name: 'Alex',
        last_name: 'Jones',
        email: 'example@domain.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      end

    it 'authenticates correctly with valid credentials' do
      expect(User.authenticate_with_credentials('example@domain.com', 'password123')).to be_present
    end
  
    it 'authenticates correctly with spaces around email' do
      expect(User.authenticate_with_credentials(' example@domain.com ', 'password123')).to be_present
    end
  
    it 'authenticates correctly with different cases in email' do
      expect(User.authenticate_with_credentials('EXAMPLe@DOMAIN.CoM', 'password123')).to be_present
    end
  
    it 'returns nil for incorrect credentials' do
      expect(User.authenticate_with_credentials('wrong@example.com', 'password123')).to be_nil
    end
  end
end
