FROM davidban77/netautomator:workstation

# Set extra properties
RUN apt-get update -y \
        && apt-get install -y --no-install-recommends software-properties-common

# Set extra repos and mibs-downloader
RUN apt-add-repository non-free \
        && apt-get update -y \
        && apt-get install -y --no-install-recommends snmp-mibs-downloader \
        && apt-get autoremove -y \
        && apt-get clean

# Enable usage of MIBs
RUN sed -i 's/mibs :/#mibs :/' /etc/snmp/snmp.conf \
        && download-mibs

CMD ["zsh"]
