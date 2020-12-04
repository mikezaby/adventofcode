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

  VALID_BIRTH_YEAR = (1920..2002)
  VALID_ISSUE_YEAR = (2010..2020)
  VALID_EXP_YEAR = (2020..2030)
  VALID_EYE_COLOR = %w(amb blu brn gry grn hzl oth)

  attr_accessor(*MAPPING.values)

  def initialize(data)
    map_data(data)
  end

  def valid?
    MAPPING.values.all? do |attr_name|
      next true if attr_name == :country_id
      return false if attr_empty?(public_send(attr_name))

      public_send("valid_#{attr_name}?")
    end
  end

  def valid_birth_date?
    VALID_BIRTH_YEAR.include?(birth_date.to_i)
  end

  def valid_issue_year?
    VALID_ISSUE_YEAR.include?(issue_year.to_i)
  end

  def valid_exp_year?
    VALID_EXP_YEAR.include?(exp_year.to_i)
  end

  def valid_height?
    _, num, metric = height.match(/^(\d+)(cm|in)$/).to_a
    num = num.to_i

    if metric == "cm"
      (150..193).include?(num)
    else
      (59..76).include?(num)
    end
  end

  def valid_hair_color?
    hair_color.match?(/^#[a-f 0-9]{6}$/)
  end

  def valid_eye_color?
    VALID_EYE_COLOR.include?(eye_color)
  end

  def valid_passport_id?
    passport_id.match?(/^\d{9}$/)
  end

  private

  def attr_empty?(value)
    value.nil? || value.empty?
  end

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
