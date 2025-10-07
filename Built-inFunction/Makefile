# Compiler 
CC := gcc
CFLAGS := -I. -Wall -Wextra

# Folder/file path
BUILD_DIR := build
SRC_DIR := src
MAIN_FILE := main.c

# Dung wildcard de tim tat cac file trong /src 
ALL_SRC_FILES := $(wildcard $(SRC_DIR)/*)

# Cac thanh phan cua file main sau khi bien dich bang <co che thay the chuoi>
MAIN_OBJS := $(BUILD_DIR)/$(MAIN_FILE:.c=.o) # main.o
MAIN_ASM := $(BUILD_DIR)/$(MAIN_FILE:.c=.s) # main.s
MAIN_PRE := $(BUILD_DIR)/$(MAIN_FILE:.c=.i) # main.i

# Loc list cac file co ben trong /src bang ham filter
SRC_C := $(filter %.c, $(ALL_SRC_FILES)) #.c
SRC_PRE := $(filter %.i, $(ALL_SRC_FILES)) # .i
SRC_ASM := $(filter %.s, $(ALL_SRC_FILES)) # .s
SRC_OBJS := $(wildcard $(SRC_DIR)/*.o) # bar.o foo.o

# Dung notdir de lay ten file, bo ten thu muc
C_NAMES := $(notdir $(SRC_C))
I_NAMES := $(notdir $(SRC_PRE))
S_NAMES := $(notdir $(SRC_ASM))

# File dau ra (.exe)
TARGET = $(BUILD_DIR)/main

# Default Rule
all: $(TARGET)

# Rule build cuoi (default goal) - Link toan bo object lai voi nhau
$(TARGET): $(MAIN_OBJS) $(SRC_OBJS) | $(BUILD_DIR)
	@echo "Linking all object files -> $@"
	$(CC) $(CFLAGS) $^ -o $@

# Rule build object file cho main.c
$(MAIN_OBJS): $(MAIN_ASM) | $(BUILD_DIR)
	@echo "Assembling $< -> $@"
	$(CC) $(CFLAGS) -c $< -o $@

$(MAIN_ASM): $(MAIN_PRE) | $(BUILD_DIR)
	@echo "Compling $< -> $@"
	$(CC) $(CFLAGS) -S $< -o $@

$(MAIN_PRE): $(MAIN_FILE) | $(BUILD_DIR)
	@echo "Preprocessing $< -> $@"
	$(CC) $(CFLAGS) -E $< -o $@

# Rule tao thu muc build neu chua co 
$(BUILD_DIR): 
	mkdir -p $(BUILD_DIR)

# Rule tien ich 
print:
	@echo "TARGET = $(TARGET)"
	@echo "MAIN_FILE = $(MAIN_FILE)"
	@echo "MAIN_OBJS = $(MAIN_OBJS)"
	@echo "MAIN_PRE = $(MAIN_PRE)"
	@echo "MAIN_ASM = $(MAIN_ASM)"
	@echo "SRC_OBJS = $(SRC_OBJS)"
	@echo "C_NAMES = $(C_NAMES)"
	@echo "I_NAMES = $(I_NAMES)"
	@echo "S_NAMES = $(S_NAMES)"

clean:
	rm -rf build $(TARGET) $(MAIN_ASM) $(MAIN_OBJS) $(MAIN_PRE)