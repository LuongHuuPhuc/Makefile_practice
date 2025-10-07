CC = gcc
CFLAGS = -I. -Wall -Wextra

SRC_FILES := $(wildcard *.c)

PRE := $(patsubst %.c, %.i, $(SRC_FILES))
ASM := $(SRC_FILES:.c=.s)
OBJS := $(SRC_FILES:.c=.o)

all: $(OBJS)

# Tien xu ly
%.i: %.c
	@echo "Preprocessing $< -> $@"
	$(CC) $(CFLAGS) -E $< -o $@

# Bien dich 
%.s: %.i
	@echo "Compiling (to asm) $< -> $@"
	$(CC) $(CFLAGS) -S $< -o $@

# Hop dich
%.o: %.s
	@echo "Assembling $< -> $@"
	$(CC) $(CFLAGS) -c $< -o $@

# Noi dependency chain
$(ASM): $(PRE)
$(OBJS): $(ASM)

print: 
	@echo "SRCS_FILE = $(SRC_FILES)"
	@echo "PRE = $(PRE)"
	@echo "ASM = $(ASM)"
	@echo "OBJS = $(OBJS)"

clean:
	rm -rf $(OBJS) $(ASM) $(PRE)
