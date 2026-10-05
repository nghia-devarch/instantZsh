#!/bin/bash

# Kiểm tra quyền sudo ngay từ đầu tiên
if ! sudo -v; then
    echo "Lỗi: Xác thực sudo thất bại. Kịch bản đã bị hủy!"
    exit 1
fi

echo "1. Cài đặt công cụ nền tảng..."
sudo apt update && sudo apt install -y zsh git curl build-essential

echo "2. Cài đặt Oh My Zsh và Plugins..."
rm -rf ~/.oh-my-zsh
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "3. Tải cấu hình từ kho nghia-devarch/instantZsh..."
curl -o ~/.zshrc https://raw.githubusercontent.com/nghia-devarch/instantZsh/main/.zshrc
curl -o ~/.p10k.zsh https://raw.githubusercontent.com/nghia-devarch/instantZsh/main/.p10k.zsh

echo "4. Tải Font MesloLGS NF ra Desktop Windows..."
# Dùng cmd.exe để lấy chính xác tên User Windows hiện tại
WIN_USER=$(cmd.exe /c echo %USERNAME% | tr -d '\r')
FONT_DIR="/mnt/c/Users/$WIN_USER/Desktop/P10k_Fonts"

mkdir -p "$FONT_DIR"
curl -sL -o "$FONT_DIR/MesloLGS NF Regular.ttf" "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
curl -sL -o "$FONT_DIR/MesloLGS NF Bold.ttf" "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
curl -sL -o "$FONT_DIR/MesloLGS NF Italic.ttf" "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
curl -sL -o "$FONT_DIR/MesloLGS NF Bold Italic.ttf" "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"

echo "5. Kích hoạt Zsh..."
sudo chsh -s $(which zsh) $(whoami)

echo "=== HOÀN TẤT! ==="
echo "Thư mục Font trên Windows đang được mở..."
# Tự động gọi File Explorer của Windows mở thư mục chứa font
explorer.exe "$FONT_DIR"
