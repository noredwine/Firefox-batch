::
@echo off
Title Creatie Firefox profile and proxy
echo ---------------------------------
set /P c= Enter Profile name :
set /P d= Enter   Proxy name :
set /P e= Enter   Proxy port :
echo ---------------------------------
echo "Firefox Profile name: %c%, proxy: %d%:%e%"
echo ------------------------------------------------------------
pause
c:
"c:\Program Files (x86)\Mozilla Firefox\firefox.exe" -CreateProfile  "%c%"

for /f %%i in ('dir /b %APPDATA%\Mozilla\Firefox\Profiles\*."%c%"') do set VAR=%%i

cd %APPDATA%\Mozilla\Firefox\Profiles\%VAR%

echo CUSTOM >> prefs.js
echo user_pref("network.proxy.backup.ssl", "") >> prefs.js
echo user_pref("network.proxy.backup.ssl_port", 0);  >> prefs.js
echo user_pref("network.proxy.http", "%d%");  >> prefs.js
echo user_pref("network.proxy.http_port", %e%);  >> prefs.js
echo user_pref("network.proxy.share_proxy_settings", true);  >> prefs.js
echo user_pref("network.proxy.ssl", "%d%");  >> prefs.js
echo user_pref("network.proxy.ssl_port", %e%);  >> prefs.js
echo user_pref("network.proxy.type", 1);  >> prefs.js

timeout /t 1 /nobreak
"c:\Program Files (x86)\Mozilla Firefox\firefox.exe" -p  "%c%" -new-tab about:preferences

pause
timeout /t 5 /nobreak
cd\
c:

rmdir /S /Q %APPDATA%\Mozilla\Firefox\Profiles\%VAR%

"c:\Program Files (x86)\Mozilla Firefox\firefox.exe" -P
