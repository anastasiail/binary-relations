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
all: debug

# Debug сборка
debug: CFLAGS += $(DEBUG_FLAGS)
debug: $(TEST_EXEC)

# Release сборка
release: CFLAGS += $(RELEASE_FLAGS)
release: $(TEST_EXEC)

# Создание тестового исполняемого файла
$(TEST_EXEC): $(SRC_FILE) $(TEST_FILE) | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $(TEST_FILE) $(SRC_FILE)
	@echo "✅ Сборка завершена. Исполняемый файл: $(TEST_EXEC)"

# Создание необходимых директорий
$(BIN_DIR):
	@mkdir -p $(BIN_DIR)

# Очистка
clean:
	rm -rf $(TEST_EXEC) *.o
	@echo "✅ Очистка завершена"

# Запуск тестов
test: $(TEST_EXEC)
	@echo "🚀 Запуск тестов..."
	@$(TEST_EXEC)

# Показ помощи
help:
	@echo "Доступные команды:"
	@echo "  make       - собрать проект (debug версия)"
	@echo "  make debug - собрать debug версию"
	@echo "  make release - собрать release версию"
	@echo "  make test  - собрать и запустить тесты"
	@echo "  make clean - очистить собранные файлы"

# Псевдоцели
.PHONY: all debug release clean test help
