# Компилятор и флаги
CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -Iinclude
DEBUG_FLAGS = -g -O0
RELEASE_FLAGS = -O2

# Директории
SRC_DIR = src
TEST_DIR = test
INCLUDE_DIR = include
LIB_DIR = lib
BIN_DIR = $(TEST_DIR)

# Файлы
SRC_FILES = $(SRC_DIR)/relation.c
OBJ_FILES = $(SRC_FILES:$(SRC_DIR)/%.c=%.o)
TEST_SRC = $(TEST_DIR)/test.c
LIB_NAME = $(LIB_DIR)/librelation.a
TEST_EXEC = $(BIN_DIR)/run

# Цели по умолчанию
all: debug

# Debug сборка
debug: CFLAGS += $(DEBUG_FLAGS)
debug: $(TEST_EXEC)

# Release сборка
release: CFLAGS += $(RELEASE_FLAGS)
release: $(TEST_EXEC)

# Создание библиотеки
$(LIB_NAME): $(OBJ_FILES) | $(LIB_DIR)
	ar rcs $@ $(OBJ_FILES)

# Компиляция объектных файлов
%.o: $(SRC_DIR)/%.c | $(INCLUDE_DIR)
	$(CC) $(CFLAGS) -c -o $@ $<

# Создание тестового исполняемого файла
$(TEST_EXEC): $(TEST_SRC) $(LIB_NAME) | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $(TEST_SRC) -L$(LIB_DIR) -lrelation

# Создание необходимых директорий
$(LIB_DIR):
	mkdir -p $(LIB_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# Очистка
clean:
	rm -rf $(LIB_DIR) $(BIN_DIR) *.o

# Запуск тестов
test: $(TEST_EXEC)
	./$(TEST_EXEC)

# Псевдоцели
.PHONY: all debug release clean test

