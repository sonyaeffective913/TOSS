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
pip install sherlock-project
pip install maigret
pip install instaloader
pip install phoneinfoga
pip install holehe
done_msg
}

install_passive_osint() {
apt update
apt install python3 && python3-pip
pip install theharvester
pip install spiderfoot
pip install metagoofil
apt install exiftool
pip install sherlock-project
done_msg
}

install_passive_dns_dorking() {
apt update
apt install amass
pip install sublist3r
go install github.com/tomnomnom/assetfinder@latest
go install github.com/findomain/findomain@latest
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
pip install pagodo
go install github.com/projectdiscovery/chaos-client/cmd/chaos@latest

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
apt update
apt install nmap && amass && whatweb && wafw00f && masscan && netdiscover && arp-scan && dnsrecon && fierce
go install github.com/OJ/gobuster/v3@latest
go install github.com/blechschmidt/massdns@latest
go install github.com/projectdiscovery/subfinder/v2/cmd
pip install aiodnsbrute
go install github.com/jaeles-project/gospider@latest
go install github.com/hakluke/hakrawler@latest
go install github.com/projectdiscovery/katana/cmd/katana@latest
pip install paramspider

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
apt update
apt install nikto
apt install openvas
go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
pip install wapiti3
apt install lynis

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
apt install zaproxy
apt install w3af
apt install wpscan
pip install droopescan
apt install joomscan
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
apt update
apt install metasploit-framework
apt install searchsploit && exploitdb
apt install beef-xss
pip install sqlmap
pip install veil
done_msg
}

install_c2_frameworks(){
apt update
pip install pupy
go install github.com/BishopFox/sliver/client@latest
go install github.com/Ne0nd0g/merlin-agent@latest

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
pip install sqlmap
pip install xsstrike
pip install dalfox
pip install tplmap
pip install commix
pip install wfuzz
pip install dirsearch
apt install dirb
go install github.com/epi052/feroxbuster@latest
go install github.com/ffuf/ffuf/v2@latest
go install github.com/OJ/gobuster/v3@latest

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
apt install hydra
apt install medusa
apt install cewl
pip install patator
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
apt update
apt install ettercap-text-only
apt install wireshark
apt install tcpdump
apt install responder
apt install dsniff
apt install bettercap
pip install mitmproxy
done_msg
}

install_net_traffic(){
pip install scapy
apt install hping3
apt install netcat
apt install socat
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
apt update
pip install pupy
apt install sshuttle
go install github.com/jpillora/chisel@latest
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
pip install linpeas
apt install pspy
done_msg
}

install_post_creds(){
pip install pypykatz
pip install impacket
pip install crackmapexec
pip install lazagne
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
