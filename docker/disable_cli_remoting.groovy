import jenkins.model.*

def instance = Jenkins.getInstance()
jenkins.model.Jenkins.instance.getDescriptor("jenkins.CLI").get().setEnabled(false)
instance.save()
