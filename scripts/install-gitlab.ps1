#requires -version 5.1

"1. Install and configure the necessary dependencies"
& sudo apt-get update
& sudo apt-get install -y curl openssh-server ca-certificates tzdata perl


# sudo apt-get install -y postfix

"2. Add the GitLab package repository and install the package"
& curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash


