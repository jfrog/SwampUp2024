export JFROG_PLATFORM=https://swampup17253066040.jfrog.io/
export JFROG_HOST=swampup17253066040.jfrog.io
export JFROG_PLATFORM_2=https://b0rk8aehtegi0.jfrog.io/
export JFROG_EDGE=https://b0fyen5mwwhma.jfrog.io/
export ADMIN_USER=
export ADMIN_PASSWORD=

jf config add swampup --url=${JFROG_PLATFORM} --user=${ADMIN_USER} --password=${ADMIN_PASSWORD} --interactive=false
jf config add jpd2 --artifactory-url=${JFROG_PLATFORM_2}artifactory --xray-url=${JFROG_PLATFORM_2}xray --user=${ADMIN_USER} --password=${ADMIN_PASSWORD} --interactive=false
jf config add swampupedge --artifactory-url=${JFROG_EDGE}artifactory --user=${ADMIN_USER} --password=${ADMIN_PASSWORD} --interactive=false

jf c use swampup