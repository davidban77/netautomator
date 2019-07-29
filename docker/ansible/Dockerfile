FROM davidban77/netautomator:workstation

RUN mkdir /etc/ansible/
RUN /bin/echo -e "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

RUN pip install ansible ansible_runner

CMD ["zsh"]
