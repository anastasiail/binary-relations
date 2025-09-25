# Компилятор и флаги
CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -Iinclude
DEBUG_FLAGS = -g -O0
RELEASE_FLAGS = -O2

# Директории
SRC_DIR = src
TEST_DIR = test
INCLUDE_DIR = include
BIN_DIR = $(TEST_DIR)

# Файлы
SRC_FILE = $(SRC_DIR)/relation.c
TEST_FILE = $(TEST_DIR)/test.c
TEST_EXEC = $(BIN_DIR)/run

# Цели по умолчанию
.DEFAULT_GOAL := build

# Debug сборка
debug: CFLAGS += $(DEBUG_FLAGS)
debug: build

# Release сборка  
release: CFLAGS += $(RELEASE_FLAGS)
release: build

# Основная сборка
build: $(TEST_EXEC)
	@echo "✅ Сборка завершена"

# Создание исполняемого файла
$(TEST_EXEC): $(SRC_FILE) $(TEST_FILE) | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $(TEST_FILE) $(SRC_FILE)

# Создание директории для бинарников
$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# Запуск тестов
test: build
	@echo "🚀 Запуск тестов..."
	@./$(TEST_EXEC)

# Очистка
clean:
	rm -rf $(TEST_EXEC) *.o
	@echo "✅ Очистка завершена"

# Показ помощи
help:
	@echo "Доступные команды:"
	@echo "  make       - собрать проект"
	@echo "  make test  - собрать и запустить тесты"
	@echo "  make clean - очистить собранные файлы"
	@echo "  make debug - собрать debug версию"
	@echo "  make release - собрать release версию"

# Псевдоцели
.PHONY: all build debug release clean test help
