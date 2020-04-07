FROM davidban77/netautomator:workstation

RUN mkdir /etc/ansible/ \
        && /bin/echo -e "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

COPY ansible.cfg /etc/ansible/ansible.cfg

RUN pip install --no-cache-dir ansible \
        ansible_runner \
        netaddr

CMD ["zsh"]
