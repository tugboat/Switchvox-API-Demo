require 'rubygems'
require 'switchvox'
require 'rforce'

class Conductor
  attr_accessor :switchvox_uri,
    :switchvox_username,
    :switchvox_password

  SALESFORCE_USERNAME = "me@example.com"
  SALESFORCE_PASSWORD = "s00pers3cr3t"
  DICTATION_IVR = 808

  def initialize(uri, username, password)
    @switchvox_uri      = uri
    @switchvox_username = username
    @switchvox_password = password
  end

  def log_call(duration, incoming_phone_number, recipient_phone_number)
    @switchvox = switchvox_login()
    
    initiate_dictation(@switchvox, recipient_phone_number)
  end

  def initiate_dictation(switchvox, recipient_number)
    switchvox.request("switchvox.call", { :dial_first  => recipient_number,
                                          :dial_second => DICTATION_IVR })
  end

  def switchvox_login()
    Switchvox::Base.new(@switchvox_uri, @switchvox_username, @switchvox_password, {:debug => false})
  end

end
