#!/bin/bash

bot_token="7568506442:AAEVTRjN-56c6FeS1Rg9DLcNjzPCw65iGbc"
chat_id="@mrchandiootp"

login_url="https://www.ivasms.com/login"
username="chandiomujeebrehman612@gmail.com"
password="Mujeeb@612"
inbox_url="https://www.ivasms.com/portal/live/my_sms"

curl -s -c cookies.txt -X POST "$login_url" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "email=$username&password=$password" > /dev/null

echo "✅ Logged in. Watching SMS..."

html=$(curl -s -b cookies.txt "$inbox_url")
sms=$(echo "$html" | grep -oP '(?<=<td class="text-center">)[^<]+' | head -n 1)

if [ -n "$sms" ]; then
  curl -s -X POST "https://api.telegram.org/bot$bot_token/sendMessage" \
    -d chat_id="$chat_id" \
    -d text="📥 *GitHub SMS:*\n$sms" \
    -d parse_mode=Markdown

  echo "🔔 Sent to Telegram: $sms"
else
  echo "❌ No SMS found"
fi
