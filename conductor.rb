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
    #TODO: Log the call as a completed task in Salesforce, attached to the contact record of the caller
    #make sure that this returns the task_id from Salesforce 
    
    @switchvox = switchvox_login()
    initiate_dictation(@switchvox, recipient_phone_number, incoming_phone_number)
  end

  def initiate_dictation(switchvox, recipient_number, incoming_phone_number)
    # TODO:  Set an task_id variable in the request to the task id returned from salesforce 
    switchvox.request("switchvox.call", { :dial_first  => recipient_number,
                                          :dial_second => DICTATION_IVR })
  end

  def switchvox_login()
    Switchvox::Base.new(@switchvox_uri, @switchvox_username, @switchvox_password, {:debug => false})
  end

end

# Some notes:
#
# The upload action should handle setting the follow up task given the number of days that the callee
# sets as the desired duration until the followup.  This will be creating a new task in Salesforce.
