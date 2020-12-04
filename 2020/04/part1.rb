class PassportValidator
  MAPPING = {
    "byr" => :birth_date,
    "iyr" => :issue_year,
    "eyr" => :exp_year,
    "hgt" => :height,
    "hcl" => :hair_color,
    "ecl" => :eye_color,
    "pid" => :passport_id,
    "cid" => :country_id
  }

  attr_accessor *MAPPING.values

  def initialize(data)
    map_data(data)
  end

  def valid?
    MAPPING.values.all? do |attr_name|
      next true if attr_name == :country_id

      value = public_send(attr_name)
      !value.nil? && !value.empty?
    end
  end

  private

  def map_data(data)
    data.each do |k,v|
      public_send("#{MAPPING[k]}=", v)
    end
  end
end

passport_data = @data
  .file.read.to_s
  .gsub("\n\n", "|")
  .gsub("\n", " ")
  .gsub(" ", ",")
  .split("|")
  .map { |passport| passport.split(",").map { |pair| pair.split(":") }.to_h }

passports = passport_data.map { |passport| PassportValidator.new(passport) }

@output = passports.count(&:valid?)
