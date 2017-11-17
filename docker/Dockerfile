FROM jenkins/jenkins:2.90
MAINTAINER John Mickey
ENV JAVA_OPTS="-Xmx1024m -Djenkins.install.runSetupWizard=false -Dorg.jenkinsci.remoting.engine.JNLP3-connect.disabled=true -Dorg.jenkinsci.remoting.engine.JnlpProtocol2.disabled=true -Dorg.jenkinsci.remoting.engine.JnlpProtocol1.disabled=true"
ENV JENKINS_OPTS="--logfile=/var/log/jenkins/jenkins.log"
USER root
RUN mkdir /var/log/jenkins
RUN chown -R 1000:1000 /var/log/jenkins
RUN chown -R 1000:1000 /usr/share/jenkins
RUN chown -R 1000:1000 /var/jenkins_home
USER jenkins
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
COPY config.xml /usr/share/jenkins/ref/config.xml
COPY credentials.xml /usr/share/jenkins/ref/credentials.xml
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
COPY groovy_scripts/* /usr/share/jenkins/ref/init.groovy.d/
RUN mkdir -p /usr/share/jenkins/ref/jobs/sleep/
COPY sleep_job.xml /usr/share/jenkins/ref/jobs/sleep/config.xml
