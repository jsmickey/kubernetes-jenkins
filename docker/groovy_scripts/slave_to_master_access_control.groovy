import jenkins.security.s2m.AdminWhitelistRule
import jenkins.model.Jenkins

def instance = Jenkins.instance
Jenkins.instance.getInjector().getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false)
instance.save()
