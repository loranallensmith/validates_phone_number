require 'test_helper'

class TestValidator < MiniTest::Unit::TestCase
  def setup
    Person.reset_callbacks(:validate)
    Person._validators.clear
    @person = Person.new
  end

  def test_model_validates_with_phone_number_option
    Person.validates :phone_number, :phone_number => true
  end

  def test_invalid_record_if_invalid_phone_number
    Person.validates :phone_number, :phone_number => true
    @person.phone_number = "423432432452"
    assert !@person.valid?
  end
  
  def test_valid_record_if_valid_phone_number
    Person.validates :phone_number, :phone_number => true
    @person.phone_number = "555-565-5703"
    assert @person.valid?
  end

  def test_allow_nil_option_off
    Person.validates :phone_number, :phone_number => true
    @person.phone_number = nil
    assert !@person.valid?
  end

  def test_allow_nil_option_on
    Person.validates :phone_number, :phone_number => {:allow_nil => true}
    @person.phone_number = nil
    assert @person.valid?
  end

  def test_valid_record_by_format_option_off
    Person.validates :phone_number, :phone_number => true
    @person.phone_number = "555^555^555^5555"
    assert !@person.valid?
  end

  def test_valid_record_by_format_option_on
    Person.validates :phone_number, :phone_number => {:format => /(\d+\^){3}\d+/}
    @person.phone_number = "555^555^555^5555"
    assert @person.valid?
  end
end

