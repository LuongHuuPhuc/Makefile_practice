CC = gcc
CFLAGS = -Wall -Wextra -I.

BUILD_DIR = build

SRC = Hello_gay.c
PRE = $(BUILD_DIR)/Hello_gay.i
ASM = $(BUILD_DIR)/Hello_gay.s
OBJS = $(BUILD_DIR)/Hello_gay.o
TARGET = $(BUILD_DIR)/libHello_gay.a

# Mac dinh (all la ky tu nhap vao se tu dong thuc hien cac lenh o duoi, vd: make all)
all: $(TARGET)

# Buoc 1: Preprocess (.c -> .i)
$(PRE): $(SRC) | $(BUILD_DIR)
	$(CC) $(CFLAGS) -E $< -o $@

# Buoc 2: Compile (.i -> .s)
$(ASM): $(PRE)
	$(CC) $(CFLAGS) -S $< -o $@

# Buoc 3: Assemble (.s -> .o)
$(OBJS): $(ASM)
	$(CC) $(CFLAGS) -c $< -o $@

# Buoc 4: Chuyen thanh file static lib .a
$(TARGET): $(OBJS)
	ar rsc $@ $<

# Tao folder build neu chua co 
$(BUILD_DIR):
	mkdir -p $@

clean:
	rm -rf $(BUILD_DIR)