#!/bin/bash
set -e

# Fix Apache MPM conflict at runtime before Apache starts
a2dismod mpm_event mpm_worker 2>/dev/null || true
rm -f /etc/apache2/mods-enabled/mpm_event.* \
      /etc/apache2/mods-enabled/mpm_worker.* 2>/dev/null || true
a2enmod mpm_prefork 2>/dev/null || true

# Execute original Mautic entrypoint
exec /docker-entrypoint.sh "$@"
