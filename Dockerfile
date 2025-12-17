# Imagen base Odoo 17
FROM odoo:17

# Módulos propios
COPY ./extra-addons /mnt/extra-addons

# Puerto HTTP de Odoo
EXPOSE 8069

ENV PGPORT=5432

CMD ["bash","-lc", "\
  echo '==> Initializing / updating Odoo & assets' && \
  odoo -d $PGDATABASE \
       -u web_editor \
       --without-demo=all \
       --db_host=$PGHOST --db_port=$PGPORT \
       --db_user=$PGUSER --db_password=$PGPASSWORD \
       --addons-path=/usr/lib/python3/dist-packages/odoo/addons,/mnt/extra-addons \
       --stop-after-init || true; \
  echo '==> Starting Odoo server' && \
  odoo --db_host=$PGHOST --db_port=$PGPORT \
       --db_user=$PGUSER --db_password=$PGPASSWORD \
       --addons-path=/usr/lib/python3/dist-packages/odoo/addons,/mnt/extra-addons \
       --db-filter=$PGDATABASE"]
