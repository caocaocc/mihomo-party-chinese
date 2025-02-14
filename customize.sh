#!/bin/sh

# Helper function for sed command that works on both macOS and Linux
cmd_sed() {
  if [ "$(uname)" = "Darwin" ]; then
    sed -i '' "$@"
  else
    sed -i "$@"
  fi
}

# Download profile-item.tsx
curl -o "src/renderer/src/components/profiles/profile-item.tsx" "https://raw.githubusercontent.com/mihomo-party-org/mihomo-party/48475fb0eb72f9dea492da1792c0945efefc3d85/src/renderer/src/components/profiles/profile-item.tsx"

# Remove preview version
cmd_sed '76,133d' "src/renderer/src/pages/mihomo.tsx"

# Set default ports
cmd_sed 's/7891/0/g; s/7892/0/g' "src/main/utils/template.ts"
cmd_sed 's/7891/0/g; s/7892/0/g' "src/renderer/src/pages/mihomo.tsx"

# Remove auto-update menu
cmd_sed '97,105d' "src/renderer/src/components/settings/general-config.tsx"

# Reduce node list font size
cmd_sed 's/text-ellipsis overflow-hidden whitespace-nowrap/text-ellipsis overflow-hidden whitespace-nowrap text-xs/g' "src/renderer/src/components/proxies/proxy-item.tsx"
cmd_sed 's/text-sm/text-xs/g' "src/renderer/src/components/proxies/proxy-item.tsx"

# Modify delay display
cmd_sed '/success/s/500/1200/g' "src/renderer/src/components/proxies/proxy-item.tsx"
cmd_sed 's/delay.toString()/Math.round(delay\/4).toString()+" ms"/' "src/renderer/src/components/proxies/proxy-item.tsx"
cmd_sed 's|(${delay}ms)|${Math.floor(delay\/4)} ms|g' "src/main/resolve/tray.ts"
cmd_sed 's/(Timeout)/超时/g' "src/main/resolve/tray.ts"
cmd_sed 's/{proxy.name}/{proxy.name.padEnd(40)}/g' "src/main/resolve/tray.ts"

# Remove outbound mode
cmd_sed '95,145d' "src/main/resolve/tray.ts"
cmd_sed '/<OutboundModeSwitcher.*>/d' "src/renderer/src/App.tsx"

# Remove GeoData
cmd_sed '/GeoData/d' "src/renderer/src/pages/resources.tsx"
cmd_sed '114,122d' "src/main/utils/template.ts"

# Modify delay test URL
cmd_sed 's|www.gstatic.com/generate_204|detectportal.firefox.com/success.txt|g' "src/main/core/mihomoApi.ts"
cmd_sed 's|www.gstatic.com/generate_204|detectportal.firefox.com/success.txt|g' "src/renderer/src/components/settings/mihomo-config.tsx"

# Modify tun settings
cmd_sed "s/'mixed'/'gvisor'/g" "src/main/utils/template.ts"
cmd_sed "s/strictRoute = false/strictRoute = true/g" "src/renderer/src/pages/tun.tsx"

# Disable SubStore
cmd_sed '/useSubStore/s/true/false/g' "src/main/utils/template.ts"

# Set default proxy display mode to full
cmd_sed '/proxyDisplayMode/s/simple/full/g' "src/main/utils/template.ts"

# Disable auto update check
cmd_sed '/autoCheckUpdate/s/true/false/g' "src/main/utils/template.ts"
cmd_sed '/baseUrl/s/mihomo-party-org/caocaocc/g' "src/main/resolve/autoUpdater.ts"
cmd_sed '/win32-ia32/d' "src/main/resolve/autoUpdater.ts"

# Enable LAN connection
cmd_sed '/allow-lan/s/false/true/g' "src/main/utils/template.ts"

# Auto enable system proxy with PAC
cmd_sed '/sysProxy/s/false/true/g' "src/main/utils/template.ts"
cmd_sed '/sysProxy/s/manual/auto/g' "src/main/utils/template.ts"

# Use system HOSTS
cmd_sed '/use-system-hosts/s/false/true/g' "src/main/utils/template.ts"

# Configure external controller
cmd_sed "/external-controller/s/''/'127.0.0.1:9090'/g" "src/main/utils/template.ts"

# Configure DNS settings
cmd_sed "/default-nameserver.*=/s/\[.*\]/['114.114.114.114']/g" "src/renderer/src/pages/dns.tsx"
cmd_sed "/nameserver:/s/\[.*\]/['system', '114.114.114.114']/g" "src/main/utils/template.ts"
cmd_sed "/proxy-server-nameserver/s/\[.*\]/['system', '114.114.114.114']/g" "src/main/utils/template.ts"
cmd_sed "/direct-nameserver/s/\[.*\]/['system', '114.114.114.114']/g" "src/main/utils/template.ts"
cmd_sed 's|223.5.5.5|114.114.114.114|g' "src/main/core/manager.ts"

# Remove first-time guide
cmd_sed '/firstDriver\.drive()/d' "src/renderer/src/App.tsx"
cmd_sed '33,62d' "src/renderer/src/components/settings/actions.tsx"
cmd_sed '25,31d' "src/renderer/src/components/settings/actions.tsx"

# Replace subscription related text
cmd_sed "s/空白订阅/配置/g" "src/main/config/profile.ts"
cmd_sed "s/空白订阅/配置/g" "src/renderer/src/components/sider/profile-card.tsx"
cmd_sed "s/订阅配置/切换配置/g" "src/main/resolve/tray.ts"
cmd_sed "s/订阅管理/配置管理/g" "src/renderer/src/App.tsx"
cmd_sed "s/订阅管理/配置管理/g" "src/renderer/src/components/settings/sider-config.tsx"
cmd_sed "s/订阅管理/配置管理/g" "src/renderer/src/components/sider/profile-card.tsx"
cmd_sed "s/订阅管理/配置管理/g" "src/renderer/src/pages/profiles.tsx"
cmd_sed "s/更新全部订阅/更新全部配置/g" "src/renderer/src/pages/profiles.tsx"
cmd_sed "s/订阅导入/配置导入/g" "src/main/index.ts"
cmd_sed "s/订阅导入/配置导入/g" "src/renderer/src/App.tsx"
cmd_sed "s/订阅文件/配置文件/g" "src/main/sys/misc.ts"
cmd_sed "s/编辑订阅/编辑配置/g" "src/renderer/src/components/profiles/edit-file-modal.tsx"
cmd_sed "s/更新订阅/更新配置/g" "src/renderer/src/components/profiles/edit-file-modal.tsx"
cmd_sed "s/订阅地址/配置链接/g" "src/renderer/src/components/profiles/edit-info-modal.tsx"
cmd_sed "s/不同订阅/不同配置/g" "src/renderer/src/components/settings/mihomo-config.tsx"
cmd_sed "s/同步订阅/同步配置/g" "src/renderer/src/components/settings/mihomo-config.tsx"
cmd_sed "s/新建订阅/新建配置/g" "src/renderer/src/pages/profiles.tsx"

# Replace proxy group text
cmd_sed "s/代理组/策略组/g" "src/renderer/src/App.tsx"
cmd_sed "s/代理组/策略组/g" "src/renderer/src/components/settings/mihomo-config.tsx"
cmd_sed "s/代理组/策略组/g" "src/renderer/src/components/settings/sider-config.tsx"
cmd_sed "s/代理组/策略组/g" "src/renderer/src/components/sider/proxy-card.tsx"
cmd_sed "s/代理组/策略组/g" "src/renderer/src/pages/proxies.tsx"

# Maximize log card
cmd_sed '/logCardStatus/s/col-span-1/col-span-2/g' "src/renderer/src/components/settings/sider-config.tsx"
cmd_sed '/logCardStatus/s/col-span-1/col-span-2/g' "src/renderer/src/components/sider/log-card.tsx"

# Maximize proxy group card
cmd_sed '/proxyCardStatus/s/col-span-1/col-span-2/g' "src/renderer/src/components/settings/sider-config.tsx"
cmd_sed '/proxyCardStatus/s/col-span-1/col-span-2/g' "src/renderer/src/components/sider/proxy-card.tsx"

# Hide override card
cmd_sed '/overrideCardStatus/s/col-span-1/hidden/g' "src/renderer/src/components/settings/sider-config.tsx"
cmd_sed '/overrideCardStatus/s/col-span-1/hidden/g' "src/renderer/src/components/sider/override-card.tsx"

# Remove Github repository link
cmd_sed '18,57d' "src/renderer/src/pages/settings.tsx"

# Other text modifications
cmd_sed 's/默认 //g' "src/renderer/src/components/settings/mihomo-config.tsx"
cmd_sed "s/显示窗口/显示主窗口/g" "src/main/resolve/tray.ts"
cmd_sed "s/环境变量/终端代理命令/g" "src/main/resolve/tray.ts"
cmd_sed "s/环境变量/终端代理命令/g" "src/renderer/src/components/settings/general-config.tsx"

# Set empty default content for new config
cmd_sed "s/file: '.*'/file: ''/g" "src/renderer/src/pages/profiles.tsx"

# Modify config link prompt
cmd_sed 's/value={url}/value={url} placeholder="从 URL 下载配置"/g' "src/renderer/src/pages/profiles.tsx"
cmd_sed 's/导入/下载/g' "src/renderer/src/pages/profiles.tsx"
cmd_sed 's/>打开</>从文件导入</g' "src/renderer/src/pages/profiles.tsx"
cmd_sed 's/>新建</>新建空白配置</g' "src/renderer/src/pages/profiles.tsx"
cmd_sed 's/whitespace-nowrap/whitespace-nowrap transform scale-80 inline-block origin-right/g' "src/renderer/src/pages/profiles.tsx"

# Show traffic information
cmd_sed "s/showTraffic = false,/showTraffic = true,/g" "src/renderer/src/components/settings/general-config.tsx"
cmd_sed "s/showTraffic = false,/showTraffic = true,/g" "src/renderer/src/components/sider/conn-card.tsx"

# Collapse other policy groups
cmd_sed '335s/\[...prev\]/Array(prev.length).fill(false)/' "src/renderer/src/pages/proxies.tsx"

# Always collapse policy group interface
cmd_sed '37,41d; 43d' "src/renderer/src/pages/proxies.tsx"
