## MAKEFILE là gì ? ##
Makefile là một tập tin cấu hình dùng bởi công cụ make để tự động hóa quá trình biên dịch chương trình, đặc biệt là chương trình lớn có nhiều mã nguồn (`.c`, `.cpp`, `,h`,...)
Thay vì gõ nhiều lệnh, bạn chỉ cần gõ: 
```bash
make
```
## RULE trong MAKEFILE ##
Một rule (quy tắc) trong Makefile định nghĩa cách tạo ra 1 file (thường là file.o hoặc file chương trình) từ các file nguồn <br>

### **Cấu trúc 1 rule** ###
```bash
target: prerequisites
  recipe: (command)
```
* target: Tập tin đích bạn muốn tạo ra (vd: `main.o`, `app`, `output.exe`)
* prerequisites (phụ thuộc): Các tập tin cần có để tạo ra `target` (vd: `main.o`, `main.h`)
* recipe: Các lệnh để tạo `target` từ `prerequisites`, thường là lệnh `gcc` hoặc `g++`<br>
> Lưu ý dòng lệnh phải luôn cách 1 tab, không phải khoảng trắng

### **Ví dụ đơn giản** ###
```makefile
main: main.o utils.o
  gcc -o main main.o utils.o

main.o: main.c utils.h
  gcc -c main.c

utils.o: utils.c utils.h
  gcc -c utils.c

clean: 
  rm -f *.o main
```
## CÁC KÝ HIỆU PHỔ BIẾN TRONG MAKEFILE ##
- Ký hiệu `$` trong Makefile được dùng để tham chiếu đến các biến (macros) bao gồm các biến tự định nghĩa, biến môi trường và biến tự động. 
- Cách sử dụng phổ biến nhất là đặt tên biến sau `$` và bao nó trong ngoặc đơn `()` hoặc dấu ngoặc nhọn `{}`.
  - Ví dụ: $(FOO) hoặc ${FOO} sẽ thay thế giá trị của biến FOO

- Ngoài ra, `$` còn đi kèm với các ký tự đặc biệt (ví dụ `$@`, `$^`, `$<`) để biểu thị tên biến tự động(automatic variables) mà `make` cung cấp cho mỗi *rule*. Chúng giúp ta không cân phải gõ lại tên file nhiều lần

  - `$@`: Biểu thị tên của mục tiêu (Target) - tệp kết quả cần tạo
  - Ví dụ:
```makefile
TARGET = main.o 
$(TARGET): main.cpp
  gcc -c main.cpp -o $@ # Ở đây $@ = main.o (TARGET)
``` 

  - `$<`: Tên của dependency đầu tiên (file đầu tiên sau dấu `:`)
  - Ví dụ: 
```makefile
main.o: main.cpp
  gcc -c $< -o $@ # Ở đây $@ = main.o, $< = main.cpp
```

  - `$^`: Danh sách tất cả các dependency (file sau dấu `:`), bỏ trùng lặp
  - Ví dụ:
```makefile
program: main.o utils.o 
  g++ $^ -o $@ #$^ = main.o utils.o
```

## CÁC TOÁN TỬ GÁN PHỔ BIẾN ##
* `=` (Gán đệ quy): Giống như một công thức. Make sẽ tính toán giá trị mỗi khi biến đó được tham chiếu. Điều này cho phép bạn định nghĩa các biến theo thứ tự không phụ thuộc vào nhau, nhưng tiềm ẩn nguy cơ về hiệu suất và lỗi 
```makefile
A = $(B)
B = Hello World
# Khi dùng: $(A) sẽ là "Hello World"
```

* `:=` (Gán đơn giản): Giống như một giá trị cố định. Make tính toán giá trị một lần duy nhất tại thời điểm định nghĩa. Đây là lựa chọn tốt nhất cho hầu hết các biến để đảm bảo tính rõ ràng và hiệu suất.
```makefile
B := Hello World
A := $(B)
B := Goodbye World
# Khi dùng: $(A) vẫn là "Hello World"
```

* `?=` (Gán có điều kiện): Gán giá trị chỉ khi biến đó chưa được định nghĩa (chưa có giá trị). Nếu biến đó đã có giá trị, toán tử này sẽ bị bỏ qua

* `+=` (Thêm vào): Thêm giá trị mới vào cuối giá trị hiện tại của biến, cách nhau bởi 1 khoảng trắng. Nó luôn đùng kiểu gán đệ quy (=), ngay cả khi biến ban đầu được gán bằng `:=`
```makefile
CFLAGS += -Wall
```

* `!=` (Gán từ kết quả lệnh shell): Gán giá trị của biến là kết quả đầu ra (stdout) của lệnh shell được thực thi
```makefile
NOW := $(shell date +%Y%m%d)
```
## CÁC HÀM BUILT-IN FUNCTIONS (HÀM TÍCH HỢP SẴN) THƯỜNG GẶP ##
- Dùng để xử lý chuỗi, đường dẫn, danh sách file

* `addprefix prefix, names...` -> Thêm tiền tố vào trước mỗi từ
```makefile
SRCS = a.c b.c
OBJS = $(addprefix build/, $(SRCS:.c=.o))
# -> build/a.o build/b.o
```

* `addsuffix suffix,names` -> Thêm hậu tố vào sau mỗi từ 
```makefile
FILES = main util
SRC = $(addsuffix .c, $(FILES))
# => main.c util.c
```

* `abspath names...` -> Chuyển thành đường dẫn tuyệt đối
```makefile
$(abspath ..src/hello.c)
# -> /full/path/to/src/hello.c
```

* `realpath names…` → giống abspath nhưng resolve cả symlink/..
```makefile
$(realpath ../src/../src/hello.c)
# -> /full/path/to/src/hello.c (đã canonical)
```

* `notdir names...` -> Bỏ phần thư mục, chỉ lấy tên file
```makefile
$(notdir src/main.c) # -> main.c
```

* `dir names...` -> Chỉ lấy phần thư mục 
```makefile
$(dir src/main.c) # /src
```

* `basename names...` -> Bỏ phần hậu tố (đuôi file)
```makefile
$(basename main.c) # -> main
```

* `suffix names...` -> Lấy phần hậu tố (đuôi file)
```makefile
$(suffix main.c) # -> .c
```

* `wildcard pattern...` -> Dò tìm các file match theo pattern
  - Nó quét các file như trong shell bash để tìm các file, nên phải dùng `*`
  -  Nó chỉ trả về các file đã tồn tại trong hệ thống, nêu không có => Trả về là rỗng
```makefile 
SRC = $(wildcard src/*.c)
```

  - Thay vào đó, để hiển thị ra các file chưa tồn tại trong hệ thống, ta dùng **cơ chế thay thế chuỗi** trong Make
```makefile
$(var: SUFFIX1=SUFFIX2) # Chi la phep xu ly chuoi, khong lien quan den viec file co ton tai hay khong
```
- Ví dụ:
```makefile
SRCS = main.c foo.c
OBJS = $(SRCS:.c=.o) # Don gian la thay cac file .c trong SRCS => .o
```

* `patsubst pattern (mẫu tìm), replacement (mẫu thay), list (danh sách)` -> Thay thế pattern
  + `pattern (mẫu tìm)`: mẫu để tìm trong danh sách -  thường có ký tự `%` để đại diện cho phần giữ nguyên
  + `replacement (mẫu thay)`: mẫu kết quả - có thể dùng lại `%` để thay thế phần được match
  + `list (danh sách)`: Chuỗi (hoặc danh sách file) mà ta muốn chuyển (danh sách gốc)

```makefile
OBJS = $(patsubst %.c,%.o,$(SRCS))
```
  + Một số ví dụ:

| Câu lệnh | Kết quả | ý nghĩa |
|----------|---------|---------|
|`$(patsubst %.c, %.o, main.c test.c)`|`main.o`,`test.o`| Đổi đuôi `.c` thành `.o`|
|`$(patsubst src/%, build/%, src/file1.c src/file2.c)`|`build/file1.c`, `build/file2.c`| Đổi thư mục gốc từ `src` sang `build` với `%` danh sách tên file giữ nguyên |
|`$(patsubst %.cpp, %.o, $(wildcard *.cpp))`| Danh sách `.o`| Đổi tất cả các file `.cpp` thành `.o` trong cùngg thư mục chứa `.cpp`| 


* `subst from,to text` -> Thay chuỗi trực tiếp 
```makefile
STR = $(subst foo,bar,foo.c) # foo.c -> bar.c
```

* `filter pattern…,text / filter-out pattern…,text` → lọc list
```makefile
$(filter %.c, file1.c file2.o file3.c)      # -> file1.c file3.c
$(filter-out %.c, file1.c file2.o file3.c)  # -> file3.o
```

### CHÚ Ý
- Trong quá trình viết makefile, thường gặp 2 ký hiệu *.c, *.o,...và %.c, %.o,...
- Đây là 2 khái niệm hoàn toàn khác nhau, tuy giống nhau ở hình thức:

  * `*.c`, `*,o`,...
    - Đây là wildcard (ký tự đại diện) của shell (bash)
    - Dùng để liệt kê các tệp tên thật trong thư mục hiện tại khớp với mẫu đó. 
    - Ví dụ:
```makefile
SRC_FILES = *.c
```

Khi Make thực thi, shell sẽ mở rộng thành:
``` ini
SRC_FILES = main.c utils.c sensor.c
# Ví dụ trường hợp này sẽ liệt kê toàn bộ file .c
```
- Thường dùng trong khai báo biến (biến danh sách file)

  * `%.c`, `%.o`, ...
    - Là pattern (mẫu) được Make dùng trong Rule
    - `%` là phần thay thế cho tên gốc của file - phần chung giữa file nguồn và file đích
    - Ví dụ: 
```makefile
build/%.o: src/%.c
  $(CC) -c $< -o $@
```
- Nghĩa là: Để tạo ra `build/xxx.o` hãy biên dịch từ `src/xxx.c`
- Thường dùng trong pattern rule để định nghĩa cách build tự động cho nhiều file
