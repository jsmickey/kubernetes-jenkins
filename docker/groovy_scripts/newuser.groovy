import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("jmickey","Password1!")
instance.setSecurityRealm(hudsonRealm)
instance.save()
