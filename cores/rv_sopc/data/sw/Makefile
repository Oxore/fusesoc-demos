Q=@
CROSSDEV:=riscv32-unknown-elf-
CC:=$(CROSSDEV)gcc
LD:=$(CROSSDEV)ld
OBJCOPY:=$(CROSSDEV)objcopy
OBJDUMP:=$(CROSSDEV)objdump

SOURCES+=main.c
SOURCES+=irq.c
SOURCES+=start.S
OBJECTS:=$(patsubst %,%.o,$(SOURCES))
OBJDEPS:=$(patsubst %.o,%.d,$(OBJECTS))

LDFLAGS+=-Tmain.ld

CFLAGS+=-g
CFLAGS+=-Os
CFLAGS+=-MD

MAIN=main

MEM=mem.hex

.PHONY: all
all: $(MAIN).elf
all: $(MAIN).bin
all: mem.hex

$(MEM): $(MAIN).bin
	@echo -e "  HEXDUMP $@"
	@hexdump -v -e '4/1 "%02x "' -e '"\n"' $< | awk '{print $$4$$3$$2$$1}' >$@

$(MAIN).elf: $(OBJECTS)
	@echo -e "  LD      $@"
	$(Q) $(LD) $^ -o $@ $(LDFLAGS)

$(MAIN).bin: $(MAIN).elf
	@echo -e "  OBJCOPY $@"
	$(Q) $(OBJCOPY) -O binary $< $@

%.s.o: %.s
	@echo -e "  CC      $@"
	$(Q) $(CC) -c $< -o $@ $(CFLAGS)

%.S.o: %.S
	@echo -e "  CC      $@"
	$(Q) $(CC) -c $< -o $@ $(CFLAGS)

%.c.o: %.c
	@echo -e "  CC      $@"
	$(Q) $(CC) -c $< -o $@ $(CFLAGS)

.PHONY: clean
clean:
	@rm -rfv \
		$(OBJECTS) \
		$(OBJDEPS) \
		$(MAIN).elf \
		$(MAIN).bin \
		$(MEM)

-include $(OBJDEPS)
