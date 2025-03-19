<h1 align="center">
  My personal dotfiles
</h1>

| nvim | terminal |
| --- | --- |
| <center><img src = https://github.com/user-attachments/assets/87d7bfbe-e2f9-4939-8ed9-22a6aca6f48d></center>|  <center><img src = https://github.com/user-attachments/assets/879d53a2-ecb5-4b7c-bb48-f4543f611c65></center>|

# Reqs
### Git and GNU stow
- Arch Linux
```sh
pacman -S git stow
```
- Ubuntu/Debian
```sh
sudo apt install git stow
```

### Installation
Clone the repo:
```sh
git clone https://github.com/Jesichiko/dotfiles.git
cd dotfiles
```
Run the `init.sh` to install dependencies:
```sh
./init.sh
```
Then run GNU stow:
```
stow .
```
