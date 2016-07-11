class UserForm
  include ActiveModel::Model

  attr_accessor :username, :phone_numbers

  validates :username, presence: true
  validate :phone_number_formats

  def model_name
    ActiveModel::Name.new User
  end

  def initialize opts={}
    if opts[:id]
      @user = User.find opts[:id]
    else
      @user = User.new
    end

    self.username      = opts[:username]      || @user.name                  || ""
    self.phone_numbers = opts[:phone_numbers] || @user.phones.pluck(:number) || []

    self.phone_numbers.push "" until  self.phone_numbers.length > 2
    self.phone_numbers.push "" unless self.phone_numbers.last == ""
  end

  def save updates
    updates.each do |key, val|
      send "#{key}=", val
    end

    return false unless valid?

    # Update the user record
    @user.name = username
    @user.save!

    # Clear old phone numbers
    @user.phones.where.not(number: phone_numbers).delete_all

    # Make new phones
    phone_numbers.each do |n|
      @user.phones.where(number: n).first_or_create! if n.present?
    end
  end

  def id
    @user.id
  end

  def persisted?
    @user.persisted?
  end

  def method_missing name, *args
    if m = /^phone_(\d+)=$/.match(name)
      phone_numbers[ m[1].to_i ] = args.first
    elsif m = /^phone_(\d+)$/.match(name)
      phone_numbers[ m[1].to_i ]
    else
      super
    end
  end

  private

  def phone_number_formats
    phone_numbers.each_with_index do |p,i|
      unless p.empty? || p.start_with?("+")
        errors.add "phone_#{i}", "should include a country code"
      end
    end
  end
end
