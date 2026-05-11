#!/bin/bash

red='\e[31m'
green='\e[32m'
yellow='\e[33m'
blue='\e[34m'
magneta='\e[35m'
bold='\e[1m'
cyan='\e[36m'
clear='\e[0m'
reset=$(tput sgr0)

ColorRed()     { echo -ne "${red}${1}${clear}"; }
ColorGreen()   { echo -ne "${green}${1}${clear}"; }
ColorYellow()  { echo -ne "${yellow}${1}${clear}"; }
ColorBlue()    { echo -ne "${blue}${1}${clear}"; }
ColorCyan()    { echo -ne "${cyan}${1}${clear}"; }
ColorMagenta() { echo -ne "${magenta}${1}${clear}"; }

apt_install()  { echo -e "\n${cyan}[APT]${clear} Installing ${green}${1}${clear}..."; sudo apt install -y "$1" 2>&1 | tail -3; }
pip_install()  { echo -e "\n${cyan}[PIP]${clear} Installing ${green}${1}${clear}..."; pip install "$1" --break-system-packages 2>&1 | tail -3; }
go_install()   { echo -e "\n${cyan}[GO]${clear}  Installing ${green}${1}${clear}..."; go install "$1" 2>&1 | tail -3; }
apt_update()   { echo -e "\n${yellow}[*] Updating apt...${clear}"; sudo apt update -y; }

press_back() {
    echo ""
    echo -ne "$(ColorBlue '[b] Back  |  Press Enter to continue: ')"
    read -r input
    [[ "$input" == "b" || "$input" == "B" ]] && return 1
    return 0
}

done_msg() { echo -e "\n${green}[✔] Done.${clear}\n"; }



# CATEGORY 1 - Passive & Active Reconnaissance

install_osint_social_media(){
apt update
pip_install sherlock-project
pip_install maigret
pip_install instaloader
pip_install phoneinfoga
pip_install holehe
done_msg
}

install_passive_osint() {
apt_update
apt_install python3 && python3-pip
pip_install theharvester
pip_install spiderfoot
pip_install metagoofil
apt_install exiftool
pip_install sherlock-project
done_msg
}

install_passive_dns_dorking() {
apt_update
apt_install amass
pip_install sublist3r
go_install github.com/tomnomnom/assetfinder@latest
go_install github.com/findomain/findomain@latest
go_install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
pip_install pagodo
go_install github.com/projectdiscovery/chaos-client/cmd/chaos@latest

src="$HOME/go/bin"
dest="/usr/bin/"
for tool in assetfinder findomain subfinder chaos-client; do
if [ ! -f "$src/$tool" ]; then
echo -e "${red}[✘] $tool not found in $src — skipping copy${clear}"
else
sudo cp "$src/$tool" "$dest"
sudo chmod +x "$dest/$tool"
echo -e "${green}[✔] $tool copied to $dest/${clear}"
fi
done
done_msg
}

install_active_network__web_scan() {
apt_update
apt_install nmap && amass && whatweb && wafw00f && masscan && netdiscover && arp-scan && dnsrecon && fierce
go_install github.com/OJ/gobuster/v3@latest
go_install github.com/blechschmidt/massdns@latest
go_install github.com/projectdiscovery/subfinder/v2/cmd
pip_install aiodnsbrute
go_install github.com/jaeles-project/gospider@latest
go_install github.com/hakluke/hakrawler@latest
go_install github.com/projectdiscovery/katana/cmd/katana@latest
pip_install paramspider

src="$HOME/go/bin"
dest="/usr/bin/"
for tool in gobuster massdns subfinder gospider hakrawler katana; do
if [ ! -f "$src/$tool" ]; then
echo -e "${red}[✘] $tool not found in $src — skipping copy${clear}"
else
sudo cp "$src/$tool" "$dest"
sudo chmod +x "$dest/$tool"
echo -e "${green}[✔] $tool copied to $dest/${clear}"
fi
done


done_msg
}

menu_recon_active_passive() {
while true; do
echo -ne "
$(ColorMagenta '─── Passive & Active Recon ───')
$(ColorGreen '1)') OSINT & Info Gathering  
$(ColorGreen '2)') DNS Passive Recon & Dorking    
$(ColorGreen '3)') Install All Passive
$(ColorGreen '4)') Active Network & Web Recon
$(ColorGreen '5)') Social Media Osint
$(ColorGreen '6)') Install All OSINT Tools
$(ColorBlue  'b)') Back
$(ColorBlue  '0)') Exit
$(ColorYellow 'Choose: ')"
read -r a
case $a in
1) install_passive_osint ;;
2) install_passive_dns_dorking ;;
3) install_passive_osint; install_passive_dns_dorking;;
4) install_active_network__web_scan;;
5) install_osint_social_media;;
6) install_passive_osint ; install_passive_dns_dorking ; install_active_network__web_scan ; install_osint_social_media ;;
b|B) return ;;
0) exit 0 ;;
*) echo -e "${red}Invalid option.${clear}";;
esac
done
}

# CATEGORY 2 - Vulnerability Scanning

 
install_vuln_general(){
apt_update
apt_install nikto
apt_install openvas
go_install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
pip_install wapiti3
apt_install lynis

src="$HOME/go/bin"
dest="/usr/bin/"
for tool in nuclei; do
if [ ! -f "$src/$tool" ]; then
echo -e "${red}[✘] $tool not found in $src — skipping copy${clear}"
else
sudo cp "$src/$tool" "$dest"
sudo chmod +x "$dest/$tool"
echo -e "${green}[✔] $tool copied to $dest/${clear}"
fi
done

done_msg
}

install_vuln_web_cms(){
apt_install zaproxy
apt_install w3af
apt_install wpscan
pip_install droopescan
apt_install joomscan
done_msg
}

menu_vuln_scan(){
while true; do
echo -ne "
$(ColorCyan '═══ Vulnerability Scanning ═══')
$(ColorGreen '1)') General Scanners
$(ColorGreen '2)') Web App & CMS Scanners
$(ColorGreen '3)') Install All
$(ColorBlue  'b)') Back
$(ColorBlue  '0)') Exit
$(ColorYellow 'Choose: ')"
read -r a
case $a in
1) install_vuln_general ;;
2) install_vuln_web_cms ;;
3) install_vuln_general; install_vuln_web_cms;;
b|B) return ;;
0) exit 0;;
*) echo -e "${red}Invalid option.${clear}";;
esac
done
}

# CATEGORY 3 -Exploitation & C2 Tools

install_exploit_frameworks(){
apt_update
apt_install metasploit-framework
apt_install searchsploit && exploitdb
apt_install beef-xss
pip_install sqlmap
pip_install veil
done_msg
}

install_c2_frameworks(){
apt_update
pip_install pupy
go_install github.com/BishopFox/sliver/client@latest
go_install github.com/Ne0nd0g/merlin-agent@latest

src="$HOME/go/bin"
dest="/usr/bin/"
for tool in merlin-agent sliver; do
if [ ! -f "$src/$tool" ]; then
echo -e "${red}[✘] $tool not found in $src — skipping copy${clear}"
else
sudo cp "$src/$tool" "$dest"
sudo chmod +x "$dest/$tool"
echo -e "${green}[✔] $tool copied to $dest/${clear}"
fi
done
done_msg
}

menu_exploitation(){
while true; do
echo -ne "
$(ColorCyan '═══ Exploitation & C2 ═══')
$(ColorGreen '1)') Exploitation Frameworks
$(ColorGreen '2)') C2 Frameworks
$(ColorGreen '3)') Install All
$(ColorBlue  'b)') Back
$(ColorBlue  '0)') Exit
$(ColorYellow 'Choose: ')"
read -r a
case $a in
1) install_exploit_frameworks ;;
2) install_c2_frameworks ;;
3) install_exploit_frameworks ; install_c2_frameworks ;;
b|B) return ;;
0) exit 0;;
*) echo -e "${red}Invalid option.${clear}";;
esac
done
}


# CATEGORY 4 - Web Application Security Tools
install_web_fuzz_injection(){
pip_install sqlmap
pip_install xsstrike
pip_install dalfox
pip_install tplmap
pip_install commix
pip_install wfuzz
pip_install dirsearch
apt_install dirb
go_install github.com/epi052/feroxbuster@latest
go_install github.com/ffuf/ffuf/v2@latest
go_install github.com/OJ/gobuster/v3@latest

src="$HOME/go/bin"
dest="/usr/bin/"
for tool in feroxbuster ffuf gobuster; do
if [ ! -f "$src/$tool" ]; then
echo -e "${red}[✘] $tool not found in $src — skipping copy${clear}"
else
sudo cp "$src/$tool" "$dest"
sudo chmod +x "$dest/$tool"
echo -e "${green}[✔] $tool copied to $dest/${clear}"
fi
done


done_msg
}

install_web_auth(){
apt_install hydra
apt_install medusa
apt_install cewl
pip_install patator
done_msg
}

menu_webapp_attacks(){
while true; do
echo -ne "
$(ColorCyan '═══ Web Application Attacks ═══')
$(ColorGreen '1)') Injection & Fuzz Tools
$(ColorGreen '2)') Authentication Attacks
$(ColorGreen '3)') Install All
$(ColorBlue  'b)') Back
$(ColorBlue  '0)') Exit
$(ColorYellow 'Choose: ')"
read -r a
case $a in
1) install_web_fuzz_injection ;;
2) install_web_auth ;;
3) install_web_fuzz_injection; install_web_auth ;;
b|B) return ;;
0) exit 0 ;;
*) echo -e "${red}Invalid option.${clear}" ;;
esac
done
}


# CATEGORY 5 - Network Attacks

install_net_mitm(){
apt_update
apt_install ettercap-text-only
apt_install wireshark
apt_install tcpdump
apt_install responder
apt_install dsniff
apt_install bettercap
pip_install mitmproxy
done_msg
}

install_net_traffic(){
pip_install scapy
apt_install hping3
apt_install netcat
apt_install socat
done_msg
}

menu_network_attacks() {
while true; do
echo -ne "
$(ColorCyan '═══ Network Attacks ═══')
$(ColorGreen '1)') MITM & Sniffing      
$(ColorGreen '2)') Traffic Manipulation     
$(ColorGreen '3)') Install All
$(ColorBlue  'b)') Back
$(ColorBlue  '0)') Exit
$(ColorYellow 'Choose: ')"
read -r a
case $a in
1) install_net_mitm ;;
2) install_net_traffic ;;
3) install_net_mitm; install_net_traffic ;;
b|B) return ;;
0) exit 0 ;;
*) echo -e "${red}Invalid option.${clear}" ;;
esac
done
}

# CATEGORY 6 - POST EXPLOITATION

install_post_pivot_persistence(){
apt_update
pip_install pupy
apt_install sshuttle
go_install github.com/jpillora/chisel@latest
src="$HOME/go/bin"
dest="/usr/bin/"
for tool in chisel; do
if [ ! -f "$src/$tool" ]; then
echo -e "${red}[✘] $tool not found in $src — skipping copy${clear}"
else
sudo cp "$src/$tool" "$dest"
sudo chmod +x "$dest/$tool"
echo -e "${green}[✔] $tool copied to $dest/${clear}"
fi
done

done_msg
}

install_post_privesc_linux(){
pip_install linpeas
apt_install pspy
done_msg
}

install_post_creds(){
pip_install pypykatz
pip_install impacket
pip_install crackmapexec
pip_install lazagne
done_msg
}

menu_post_exploitation() {
    while true; do
        echo -ne "
$(ColorCyan '═══ Post Exploitation ═══')
$(ColorGreen '1)') Pivoting,Tunneling & Persistence 
$(ColorGreen '2)') Linux Privilege Escalation
$(ColorGreen '3)') Credential Dumping        
$(ColorGreen '4)') Install All
$(ColorBlue  'b)') Back
$(ColorBlue  '0)') Exit
$(ColorYellow 'Choose: ')"
read -r a
case $a in
1) install_post_pivot_persistence ;;
2) install_post_privesc_linux ;;
3) install_post_creds ;;
4) install_post_pivot_persistence; install_post_privesc_linux; install_post_creds ;;
b|B) return ;;
0) exit 0 ;;
*) echo -e "${red}Invalid option.${clear}" ;;
esac
done
}

# INSTALL EVERYTHING


install_everything() {
echo -e "
${red}${bold}[!] Oh wow, you clicked Install ALL. Brave. Very brave.${clear}
${yellow}[*] We are now downloading half the internet onto your machine.${clear}
${cyan}[*] Go make a coffee. Actually make a full meal. Maybe take a nap.${clear}
${green}[*] Your RAM has been notified and is already crying.${clear}
${magenta}[*] Tor is routing your guilt through 3 different countries.${clear}
${red}[*] Starting in 3... 2... 1... God help us all.${clear}
"

install_osint_social_media;  install_passive_osint; install_passive_dns_dorking; install_active_network__web_scan; 
install_vuln_general; install_vuln_web_cms; 
install_exploit_frameworks; install_c2_frameworks; 
install_web_fuzz_injection; install_web_auth; 
install_net_mitm; install_net_traffic
install_post_pivot_persistence; install_post_privesc_linux; install_post_creds

echo -e "\n${green}${bold}[✔] All tools installed.${clear}\n"
}

banner() {
    echo -e "${red}${bold}"
    echo '████████╗ ██████╗ ███████╗███████╗'
    echo '╚══██╔══╝██╔═══██╗██╔════╝██╔════╝'
    echo '   ██║   ██║   ██║███████╗███████╗'
    echo '   ██║   ██║   ██║╚════██║╚════██║'
    echo '   ██║   ╚██████╔╝███████║███████║'
    echo '   ╚═╝    ╚═════╝ ╚══════╝╚══════╝'
    echo -e "${clear}"
    echo -e "${yellow}${bold}     Tails On Steroids Script${clear}"
    echo -e "${cyan}     Red Team Installer — Tor Routed${clear}"
    echo -e "${cyan}  ────────────────────────────────────${clear}"
    echo ""
}

#MAIN MENU

main_menu(){
while true; do
banner
echo -ne "

$(ColorCyan '═══════════════════════════════════════')
$(ColorYellow '          SELECT A CATEGORY')
$(ColorCyan '═══════════════════════════════════════')
$(ColorGreen ' 1)') Reconnaissance            $(ColorBlue '[Passive & Active]')
$(ColorGreen ' 2)') Vulnerability Scanning    $(ColorBlue '[apt/go/pip]')
$(ColorGreen ' 3)') Exploitation & C2              $(ColorBlue '[apt/pip]')
$(ColorGreen ' 4)') Web Application Attacks   $(ColorBlue '[go/pip/apt]')
$(ColorGreen ' 5)') Network Attacks           $(ColorBlue '[apt/pip]')
$(ColorGreen ' 6)') Post Exploitation         $(ColorBlue '[go/apt/pip]')
$(ColorRed   ' A)') Install ALL Categories
$(ColorBlue  ' 0)') Exit
$(ColorCyan '═══════════════════════════════════════')
$(ColorYellow 'Choose: ')"
read -r a
case $a in
1) menu_recon_active_passive ;;
2) menu_vuln_scan ;;
3) menu_exploitation ;;
4) menu_webapp_attacks ;;
5) menu_network_attacks ;;
6) menu_post_exploitation ;;
a|A) install_everything ;;
0)  echo -e "\n${green}Goodbye.${clear}\n"; exit 0 ;;
*)  echo -e "${red}Invalid option.${clear}" ;;
esac
done
}

# ── Entry Point ──
main_menu
