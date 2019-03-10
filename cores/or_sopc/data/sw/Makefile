Q=@
CROSSDEV:=or1k-elf-
CC:=$(CROSSDEV)gcc
LD:=$(CROSSDEV)ld
OBJCOPY:=$(CROSSDEV)objcopy
OBJDUMP:=$(CROSSDEV)objdump

SOURCES+=main.c
#SOURCES+=startup.s
OBJECTS:=$(patsubst %.c,%.c.o,$(SOURCES))
OBJECTS:=$(patsubst %.s,%.s.o,$(OBJECTS))

LDFLAGS+=-Tmain.ld

CFLAGS+=-g

MAIN=main

all:$(MAIN).elf
all:$(MAIN).bin

$(MAIN).elf: $(OBJECTS)
	@echo "  LD      $@"
	$(Q) $(LD) $^ -o $@ $(LDFLAGS)

$(MAIN).bin: $(MAIN).elf
	@echo "  OBJCOPY $@"
	$(Q) $(OBJCOPY) -O binary $< $@

%.s.o: %.s
	@echo "  CC      $@"
	$(Q) $(CC) -c $< -o $@ $(CFLAGS)

%.c.o: %.c
	@echo "  CC      $@"
	$(Q) $(CC) -c $< -o $@ $(CFLAGS)

clean:
	@rm -rfv $(OBJECTS) $(MAIN).elf $(MAIN).bin

.PHONY: clean
