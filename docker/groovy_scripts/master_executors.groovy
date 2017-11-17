import jenkins.model.*

def instance = Jenkins.getInstance()
Jenkins.instance.setNumExecutors(0)
instance.save()
