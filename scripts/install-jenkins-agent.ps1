

mkdir /opt/jenkins-agent

cd /opt/jenkins-agent

curl -sO http://tau:8080/jnlpJars/agent.jar

sudo apt install default-jre

& java -jar agent.jar -url http://tau:8080/ -secret a7865adef7df7aa6ea222a3d523ee4bb62fa0c5c2a87f3b58a84fe30b979f9c0 -name pi -webSocket -workDir "/opt/jenkins-agent"

exit 0 # success
