Record data:
./flightdata.sh

Run just the cameras:
./flightdata.sh cameras


TMUX hax
- Initiate actions: Ctrl + b = C-b
- Create a new window: C-b c
- Split window horizontally: C-b " (shift ')
- Split vertically: C-b % (shift 5)
- Navigate between windows: C-b n / C-b p / C-b <number> 
- Navigate between panes (split window): C-b <arrow>
- Close pane: C-d
- Detach session: C-b d
- List backgrounded session: tmux ls
- Attach session: tmux attach -t 0 / tmux attach -t recording
- Naming sussions: tmux new -s recording / tmux rename-session -t 0 recording
- Make pane full screen (and back from full screen): C-b z
- Resize pane: C-b C-<arrow>
- Rename current window: C-b ,
- Quality of life configs
	- Modify ~/.tmux.conf
		set -g mode-mouse on
		set -g default-terminal "xterm-256color"

NMCLI things
- Funky things with the hotspot:
	- sudo nmcli con delete hare_hotspot
	- sudo nmcli dev wifi connect hare_hotspot password "hare-field"
