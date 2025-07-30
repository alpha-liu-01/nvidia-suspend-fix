#!/bin/bash
set -e

echo "[+] Enabling NVIDIA systemd services..."
sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service

echo "[+] Creating NVIDIA power management config..."
sudo mkdir -p /etc/modprobe.d
echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" | sudo tee /etc/modprobe.d/nvidia-power-management.conf

echo "[+] Updating initramfs..."
sudo update-initramfs -u

echo "[+] Setup complete. It is recommended to reboot now to apply all changes."
read -p "Reboot now? (y/N): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    sudo reboot
else
    echo "Reboot manually to apply changes."
fi
