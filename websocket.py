# TODO: Реализовать WebSocket сервер
# 
# Задача:
# 1. Создать асинхронный WebSocket сервер на порту 8765
# 2. Подсчитывать количество активных соединений
# 3. Подсчитывать общее количество сообщений
# 4. Отслеживать RPS (запросы в секунду)
# 5. Отправлять эхо ответы на все входящие сообщения
# 6. Добавить мониторинг, который каждую секунду выводит статистику
#
# Необходимые импорты:
import asyncio
import websockets
import datetime
import time
from collections import deque

# Глобальные переменные для статистики
connections = 0
total_messages = 0
message_timestamps = deque()

# Мониторинг RPS
async def monitor():
    global message_timestamps, total_messages, connections
    while True:
        now = time.time()
        # Очищаем устаревшие метки времени старше 1 секунды
        while message_timestamps and message_timestamps[0] < now - 1:
            message_timestamps.popleft()

        print(f"[{datetime.datetime.now()}] RPS: {len(message_timestamps)} | Total connections: {connections} | Total messages: {total_messages}")
        await asyncio.sleep(1)

# TODO: Реализовать обработчик соединений
async def handle(websocket):
    global connections, total_messages, message_timestamps
    connections += 1
    print(f"[{datetime.datetime.now()}] New connection. Total connections: {connections}")

    try:
        async for message in websocket:
            total_messages += 1
            message_timestamps.append(time.time())
            await websocket.send(f"Echo: {message}")
    except Exception as e:
        print(f"[{datetime.datetime.now()}] Error: {e}")
    finally:
        connections -= 1
        print(f"[{datetime.datetime.now()}] Connection closed. Total connections: {connections}")

# Основной запуск сервера
async def main():
    async with websockets.serve(handle, "0.0.0.0", 8765):
        print(f"[{datetime.datetime.now()}] WebSocket server started at ws://0.0.0.0:8765")
        await asyncio.gather(monitor())

if __name__ == "__main__":
    print("Запуск базового WebSocket сервера...")
    print("Сервер запущен, но функционал нужно доработать!")
    asyncio.run(main()) 