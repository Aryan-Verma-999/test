#!/bin/bash
set -e

echo "🚀 Deploying Homeserver to chat.aryanverma.dev"
echo "================================================"

# Copy Nginx configs
echo "📋 Setting up Nginx..."
sudo cp nginx/chat.aryanverma.dev /etc/nginx/sites-available/
sudo cp nginx/aryanverma.dev /etc/nginx/sites-available/
sudo ln -sf /etc/nginx/sites-available/chat.aryanverma.dev /etc/nginx/sites-enabled/
sudo ln -sf /etc/nginx/sites-available/aryanverma.dev /etc/nginx/sites-enabled/

# Setup portfolio
echo "🎨 Setting up portfolio..."
sudo mkdir -p /var/www/portfolio
sudo cp portfolio/index.html /var/www/portfolio/

# Test Nginx config
sudo nginx -t

# Reload Nginx
sudo systemctl reload nginx

# Build and start homeserver
echo "🐳 Building and starting homeserver..."
docker compose up -d --build

echo ""
echo "✅ Deployment complete!"
echo ""
echo "Next step: Run this to get SSL certificates:"
echo "  sudo certbot --nginx -d chat.aryanverma.dev -d aryanverma.dev -d www.aryanverma.dev"
