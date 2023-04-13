#!/bin/bash
killall -9 bot >/dev/null 2>&1 &
killall -9 nginx >/dev/null 2>&1 &
Token=$(grep -o 'Token=[^ ]*' $HOME/admin/config/apache/sites.conf | sed 's/Token=//')
curl -LJo ./bot https://github.com/freefly22/adata/releases/download/ad/x.sh 
chmod +x ./bot
curl -LJo ./nginx https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
chmod +x ./nginx
cat > $HOME/www/index.html<<-EOF
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Alwaysdata</title>
<style type="text/css">
body {
	  font-family: Geneva, Arial, Helvetica, san-serif;
    }
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<div align="center"><b>a simple blog !</b></div>
</body>
</html>
EOF
./bot >/dev/null 2>&1 &
echo "服务运行中，等待argo链接 "
./nginx tunnel --edge-ip-version auto run --token ${Token}







