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

:: 等待5秒让服务器启动（可根据实际情况调整）
echo 等待服务器启动...
ping 127.0.0.1 -n 6 >nul

:: 打开默认浏览器访问localhost:5000
echo 正在打开浏览器访问 http://localhost:5000
start http://localhost:5000

echo ==============================
echo 应用已启动并在浏览器中打开！
echo ==============================
echo 提示：
echo - 浏览器应该已自动打开 http://localhost:5000
echo - 如果未自动打开，请手动访问该地址
echo - 关闭此窗口将停止服务器运行
echo ==============================

:: 保持窗口打开以便查看日志
pause