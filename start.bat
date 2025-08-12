@echo off
title VIN_MIX查询系统
cd /d %~dp0
:: 检查虚拟环境是否存在
if not exist "venv\" (
    echo 正在创建虚拟环境...
    python -m venv venv
    call .\venv\Scripts\activate
    pip install -r requirements.txt
) else (
    call .\venv\Scripts\activate
)

python app.py
pause