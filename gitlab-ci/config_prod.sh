# config django
# PostgreSQL
sed -i "s/%POSTGRESQL_DB%/${PROD_POSTGRESQL_DB}/g" registration/postgresql_connect.py
sed -i "s/%POSTGRESQL_USER%/${PROD_POSTGRESQL_USER}/g" registration/postgresql_connect.py
sed -i "s/%POSTGRESQL_PASS%/${PROD_POSTGRESQL_PASS}/g" registration/postgresql_connect.py
sed -i "s/%POSTGRESQL_HOST%/${PROD_POSTGRESQL_HOST}/g" registration/postgresql_connect.py
sed -i "s/%POSTGRESQL_PORT%/${PROD_POSTGRESQL_PORT}/g" registration/postgresql_connect.py
# allowed hosts
sed -i "s/%ALLOWED_HOST%/${PROD_ALLOWED_HOST}/g" registration/postgresql_connect.py

#config dbscripts
# PostgreSQL
sed -i "s/%POSTGRESQL_DB%/${PROD_POSTGRESQL_DB}/g" dbscripts/databases_connect.py
sed -i "s/%POSTGRESQL_USER%/${PROD_POSTGRESQL_USER}/g" dbscripts/databases_connect.py
sed -i "s/%POSTGRESQL_PASS%/${PROD_POSTGRESQL_PASS}/g" dbscripts/databases_connect.py
sed -i "s/%POSTGRESQL_HOST%/${PROD_POSTGRESQL_HOST}/g" dbscripts/databases_connect.py
sed -i "s/%POSTGRESQL_PORT%/${PROD_POSTGRESQL_PORT}/g" dbscripts/databases_connect.py
# Firebird
sed -i "s|%FIREBIRD_DB_PATH%|${PROD_FIREBIRD_DB_PATH}|g" dbscripts/databases_connect.py
sed -i "s/%FIREBIRD_USER%/${PROD_FIREBIRD_USER}/g" dbscripts/databases_connect.py
sed -i "s/%FIREBIRD_PASS%/${PROD_FIREBIRD_PASS}/g" dbscripts/databases_connect.py
sed -i "s/%FIREBIRD_PORT%/${PROD_FIREBIRD_PORT}/g" dbscripts/databases_connect.py