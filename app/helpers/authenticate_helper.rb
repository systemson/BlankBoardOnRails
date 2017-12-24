module AuthenticateHelper

  def credentials
  end

  def attemptLogin(params)
    login = attempt(credentials, remember)
  end

  def hasTooManyLoginAttempts
  end

  def sendLoginResponse
  end

  def sendFailedLoginResponse
  end

  def sendLockoutResponse
  end

  def sendForbiddenResponse
  end

  def incrementLoginAttempts
  end

  def userSuspension
  end
end
