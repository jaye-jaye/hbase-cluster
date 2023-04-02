FROM 192.168.9.128:5000/jayeljj/hbase-base:2.4.15

COPY run.sh /run.sh
COPY health.sh /health.sh
COPY prestop_hook.sh /prestop_hook.sh

CMD ["/run.sh"]