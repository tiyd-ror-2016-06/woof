class UserForm
  include ActiveModel::Model

  attr_accessor :username, :phone_numbers

  validates :username, presence: true
  validate :phone_number_formats

  def model_name
    ActiveModel::Name.new User
  end

  def initialize id: nil
    if id
      @user              = User.find id
      self.username      = @user.name
      self.phone_numbers = @user.phones.pluck(:number) + [""]
    else
      @user              = User.new
      self.username      = ""
      self.phone_numbers = ["1", "2", "3"]
    end

    # self.phone_numbers.push "" until  self.phone_numbers.length > 2
    # self.phone_numbers.push "" unless self.phone_numbers.last == ""
  end

  # Explicit
  # def phone_0
  #   phone_numbers[0]
  # end
  # def phone_1
  #   phone_numbers[1]
  # end
  # def phone_2
  #   phone_numbers[2]
  # end

  # More magic
  # 0.upto(9) do |i|
  #   define_method "phone_#{i}" do
  #     phone_numbers[i]
  #   end
  # end

  def method_missing name, *args
    if name.to_s.start_with? "phone_"
      number = name.to_s.sub("phone_", "").to_i
      phone_numbers[number]
    else
      super name, *args
    end
  end

  def save updates
    # TODO: do updates
    # username, phone_0, phone_1, ....
    self.username = updates[:username]
    updates.each do |key, value|
      if key.to_s.start_with? "phone_"
        number = key.to_s.sub("phone_", "").to_i
        phone_numbers[number] = value
      end
    end

    # Idea:
    # updates.each do |k,v|
    #   send "#{k}=", v
    # end

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

  def persisted?
    @user.persisted?
  end

  def id
    @user.id
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
