@echo off
title VIN_MIX��ѯϵͳ
cd /d %~dp0
:: ������⻷���Ƿ����
if not exist "venv\" (
    echo ���ڴ������⻷��...
    python -m venv venv
    call .\venv\Scripts\activate
    pip install -r requirements.txt
) else (
    call .\venv\Scripts\activate
)

python app.py
pause