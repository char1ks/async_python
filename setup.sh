#!/bin/bash

echo "🚀 Установка зависимостей для WebSocket Challenge"

# Проверяем наличие Homebrew на macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &> /dev/null; then
        echo "❌ Homebrew не найден. Установите его с https://brew.sh/"
        exit 1
    fi
    
    echo "📦 Установка утилит через Homebrew..."
    
    # Устанавливаем htop
    if ! command -v htop &> /dev/null; then
        echo "Installing htop..."
        brew install htop
    else
        echo "✅ htop уже установлен"
    fi
    
    # Устанавливаем bmon
    if ! command -v bmon &> /dev/null; then
        echo "Installing bmon..."
        brew install bmon
    else
        echo "✅ bmon уже установлен"
    fi
fi

# Для Linux (Ubuntu/Debian)
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "📦 Установка утилит через apt..."
    
    # Обновляем список пакетов
    sudo apt update
    
    # Устанавливаем htop
    if ! command -v htop &> /dev/null; then
        echo "Installing htop..."
        sudo apt install -y htop
    else
        echo "✅ htop уже установлен"
    fi
    
    # Устанавливаем bmon
    if ! command -v bmon &> /dev/null; then
        echo "Installing bmon..."
        sudo apt install -y bmon
    else
        echo "✅ bmon уже установлен"
    fi
fi

# Проверяем наличие Node.js и npm
if ! command -v node &> /dev/null; then
    echo "❌ Node.js не найден. Установите Node.js с https://nodejs.org/"
    exit 1
else
    echo "✅ Node.js: $(node --version)"
fi

if ! command -v npm &> /dev/null; then
    echo "❌ npm не найден. Установите npm"
    exit 1
else
    echo "✅ npm: $(npm --version)"
fi

# Устанавливаем Artillery
if ! command -v artillery &> /dev/null; then
    echo "📦 Установка Artillery..."
    npm install -g artillery
else
    echo "✅ Artillery уже установлен: $(artillery --version)"
fi

# Устанавливаем Python зависимости
echo "📦 Установка Python зависимостей..."
pip3 install websockets

echo ""
echo "🎉 Все зависимости установлены!"
echo ""
echo "📋 Проверка установки:"
echo "- htop: $(which htop 2>/dev/null || echo 'не найден')"
echo "- bmon: $(which bmon 2>/dev/null || echo 'не найден')"
echo "- artillery: $(which artillery 2>/dev/null || echo 'не найден')"
echo "- python3: $(which python3)"
echo ""
echo "✨ Готово к проведению WebSocket Challenge!" 