#/bin/bash
cp -r ~/.mozilla/firefox/*.profile ~/.mozilla/firefox/proxied.profile
echo 'user_pref("network.proxy.http", "127.0.0.1");'>> ~/.mozilla/firefox/proxied.profile/prefs.js
echo 'user_pref("network.proxy.http_port", $PROXY_PORT);'>> ~/.mozilla/firefox/proxied.profile/prefs.js
echo 'user_pref("network.proxy.type", 1);'>> ~/.mozilla/firefox/proxied.profile/prefs.js 
