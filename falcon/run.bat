echo off
waitress-serve --listen=*:8000 server.app:api > nul 2>&1