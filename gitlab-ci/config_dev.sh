# config django
# PostgreSQL
sed -i "s/%POSTGRESQL_DB%/${DEV_POSTGRESQL_DB}/g" registration/postgresql_connect.py
sed -i "s/%POSTGRESQL_USER%/${DEV_POSTGRESQL_USER}/g" registration/postgresql_connect.py
sed -i "s/%POSTGRESQL_PASS%/${DEV_POSTGRESQL_PASS}/g" registration/postgresql_connect.py
sed -i "s/%POSTGRESQL_HOST%/${DEV_POSTGRESQL_HOST}/g" registration/postgresql_connect.py
sed -i "s/%POSTGRESQL_PORT%/${DEV_POSTGRESQL_PORT}/g" registration/postgresql_connect.py
# allowed hosts
sed -i "s/%ALLOWED_HOST%/${DEV_ALLOWED_HOST}/g" registration/postgresql_connect.py

# config dbscripts
# PostgreSQL
sed -i "s/%POSTGRESQL_DB%/${DEV_POSTGRESQL_DB}/g" dbscripts/databases_connect.py
sed -i "s/%POSTGRESQL_USER%/${DEV_POSTGRESQL_USER}/g" dbscripts/databases_connect.py
sed -i "s/%POSTGRESQL_PASS%/${DEV_POSTGRESQL_PASS}/g" dbscripts/databases_connect.py
sed -i "s/%POSTGRESQL_HOST%/${DEV_POSTGRESQL_HOST}/g" dbscripts/databases_connect.py
sed -i "s/%POSTGRESQL_PORT%/${DEV_POSTGRESQL_PORT}/g" dbscripts/databases_connect.py
# Firebird
sed -i "s|%FIREBIRD_DB_PATH%|${DEV_FIREBIRD_DB_PATH}|g" dbscripts/databases_connect.py
sed -i "s/%FIREBIRD_USER%/${DEV_FIREBIRD_USER}/g" dbscripts/databases_connect.py
sed -i "s/%FIREBIRD_PASS%/${DEV_FIREBIRD_PASS}/g" dbscripts/databases_connect.py
sed -i "s/%FIREBIRD_PORT%/${DEV_FIREBIRD_PORT}/g" dbscripts/databases_connect.py


