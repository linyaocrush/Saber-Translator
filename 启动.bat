@echo off
:: 切换编码为UTF-8，避免中文输出乱码
chcp 65001 >nul 2>&1

:: 核心：切换到bat文件所在目录（确保无论从哪启动，都以bat目录为基准）
cd /d "%~dp0"

:: 第一步：激活虚拟环境
echo ==============================
echo 正在激活Python虚拟环境...
echo ==============================
:: 调用虚拟环境激活脚本（call 确保激活后继续执行后续命令）
call venv\Scripts\activate.bat

:: 检查激活是否失败
if errorlevel 1 (
    echo 错误：虚拟环境激活失败！
    echo 请检查以下问题：
    echo 1. bat文件同目录是否存在「venv」文件夹；
    echo 2. venv\Scripts\activate.bat 是否存在；
    echo 3. 是否为Python venv创建的虚拟环境。
    pause
    exit /b 1
)

:: 第二步：在后台运行app.py并自动打开浏览器
echo ==============================
echo 虚拟环境激活成功！
echo 正在后台启动app.py并等待服务器就绪...
echo ==============================

:: 使用start命令在后台启动Python应用
start /b python app.py

:: 保持窗口打开以便查看日志
pause