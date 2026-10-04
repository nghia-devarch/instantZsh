#!/bin/bash

# Kiểm tra quyền sudo ngay từ đầu tiên
if ! sudo -v; then
    echo "Lỗi: Xác thực sudo thất bại (sai mật khẩu hoặc không có quyền). Kịch bản đã bị hủy!"
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

echo "4. Kích hoạt Zsh..."
sudo chsh -s $(which zsh) $(whoami)
echo "=== HOÀN TẤT! Hãy tắt Terminal và mở lại. ==="