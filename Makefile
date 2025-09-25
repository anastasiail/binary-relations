CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -Iinclude
SRC = src/relation.c
TEST = test/test.c
EXEC = test/run

.PHONY: all test clean

all: $(EXEC)

$(EXEC): $(SRC) $(TEST)
	mkdir -p test
	$(CC) $(CFLAGS) -o $(EXEC) $(TEST) $(SRC)

test: $(EXEC)
	./$(EXEC)

clean:
	rm -f $(EXEC)
