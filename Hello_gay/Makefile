# Makefile can thiet se bao gom nhieu rule (quy tac) de build chuong trinh 

############ MACRO ################
# Dung `$` de goi ra cac macro

CC = gcc
CFLAGS = -I. -Wall

# Macro DEPS la tap hop cac tep.h ma cac tep.c phu thuoc vao
DEPS = Hello_gay.h # Header file phu thuoc

BUILD_DIR = build # Thu muc build 

TARGET = $(BUILD_DIR)/Hello_gay # Ten file dau ra

SRCS = Hello_gay.c Hello_main.c
OBJS = $(patsubst %.c,$(BUILD_DIR)/%.o,$(SRCS))


############# RULE ###########
# Rule mac dinh 
all: $(TARGET)

# tep.o phu thuoc vao phien ban.c cua tep va cac tep.h co trong macro DEPS
# Sau do Rule nay noi rang tep.o, make can bien dich tep.c bang trinh bien dich duoc dinh nghia trong macro CC 
# Flag (co) -c noi rang tao tep doi tuong
# -o $@ noi rang dat dau ra cua bien dich vao tep co ten o phia ben trai cua : 
# $< la muc dau tien trong danh sach phu thuoc va macro CFLAGS duoc dinh nghia nhu tren 

# Rule build thu muc dau ra va file thuc thi
$(TARGET): $(OBJS)
	@mkdir -p $(BUILD_DIR)
	$(CC) -o $@ $^

# Rule build tung file.o vao thu muc build 
$(BUILD_DIR)/%.o: %.c $(DEPS)
	@mkdir -p $(BUILD_DIR)
	$(CC) -c -o $@ $< $(CFLAGS)

clean: 
	rm -rf $(BUILD_DIR)