echo off
uvicorn --host=0.0.0.0 server.app:app > nul 2>&1