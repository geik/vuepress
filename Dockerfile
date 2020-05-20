FROM centos:8.1.1911
RUN yum clean all -y && yum update -y && \
    yum search epel-release && \
    yum info epel-release && \
    yum install epel-release && \
    (curl -sL https://rpm.nodesource.com/setup_12.x | bash -) && \
    yum install -y nodejs && \
    curl https://packages.microsoft.com/config/rhel/7/prod.repo | tee /etc/yum.repos.d/microsoft.repo && \
    yum install -y powershell && \
    yum install -y sshpass lftp && \
    yum autoremove -y && yum clean all -y && \
    npm install npm --global && \
    curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo && \
    rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg && \
    dnf install -y yarn && yarn --version && \
    yarn global add vuepress && \
    yarn global add vuepress-plugin-mermaidjs && \
    chmod -R u=rwx,g=rwx,o=rwx /lost+found && \
    chmod -R u=rwx,g=rwx,o=rwx /usr/local/share/.config
COPY ["copy-to-image/","/"]    
# COPY --chown=1200 ["copy-to-image/","/"]
# USER 1200
CMD [ "sh"]