TARGET = thumbv7em-none-eabihf
PROGRAM_NAME = stm32f446-rs-template
BUILD_MODE = debug
OBJDUMP = arm-none-eabi-objdump
OBJCOPY = arm-none-eabi-objcopy
SIZE = arm-none-eabi-size

# 目标文件
ELF_FILE = target/$(TARGET)/$(BUILD_MODE)/$(PROGRAM_NAME)
BIN_FILE = target/$(TARGET)/$(BUILD_MODE)/$(PROGRAM_NAME).bin
HEX_FILE = target/$(TARGET)/$(BUILD_MODE)/$(PROGRAM_NAME).hex
ASM_FILE = target/$(TARGET)/$(BUILD_MODE)/$(PROGRAM_NAME).asm

.PHONY: all build disassemble bin hex size clean disasm-text disasm-rodata disasm-all

# 更新 'all' 目标以包含新的反汇编目标
all: build disasm-text disasm-rodata disasm-all bin hex size

build:
	cargo build

disassemble: build
	$(OBJDUMP) -d $(ELF_FILE) > $(ASM_FILE)

bin: build
	$(OBJCOPY) -O binary $(ELF_FILE) $(BIN_FILE)

hex: build
	$(OBJCOPY) -O ihex $(ELF_FILE) $(HEX_FILE)

size: build
	$(SIZE) $(ELF_FILE)

clean:
	cargo clean
	rm -f $(ASM_FILE) $(BIN_FILE) $(HEX_FILE)

disasm-text: build
	$(OBJDUMP) -D -j .text -j .vector_table $(ELF_FILE) > target/$(TARGET)/$(BUILD_MODE)/$(PROGRAM_NAME)_text.asm

disasm-rodata: build
	$(OBJDUMP) -D -j .rodata $(ELF_FILE) > target/$(TARGET)/$(BUILD_MODE)/$(PROGRAM_NAME)_rodata.asm

disasm-all: build
	$(OBJDUMP) -D $(ELF_FILE) > target/$(TARGET)/$(BUILD_MODE)/$(PROGRAM_NAME)_full.asm