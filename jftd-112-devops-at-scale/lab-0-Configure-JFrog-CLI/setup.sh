export JFROG_PLATFORM=
export JFROG_HOST=
export JFROG_PLATFORM_2=
export JFROG_EDGE=
export ADMIN_USER=
export ADMIN_PASSWORD=
export ACCESS_TOKEN=

jf config add swampup --url=${JFROG_PLATFORM} --user=${ADMIN_USER} --password=${ADMIN_PASSWORD} --interactive=false
jf config add jpd2 --artifactory-url=${JFROG_PLATFORM_2}artifactory --xray-url=${JFROG_PLATFORM_2}xray --user=${ADMIN_USER} --password=${ADMIN_PASSWORD} --interactive=false
jf config add swampupedge --artifactory-url=${JFROG_EDGE}artifactory --user=${ADMIN_USER} --password=${ADMIN_PASSWORD} --interactive=false

jf c use swampup