echo off
waitress-serve --listen=*:8000 server.wsgi:app > nul 2>&1