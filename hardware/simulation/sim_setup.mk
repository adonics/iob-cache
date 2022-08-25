#
# SIMULATION HARDWARE
#

# copy simulation wrapper
SRC+=$(BUILD_SIM_DIR)/iob_cache_wrapper.v
$(BUILD_SIM_DIR)/iob_cache_wrapper.v: $(CORE_SIM_DIR)/iob_cache_wrapper.v
	cp $< $@

# copy external memory for iob interface
include hardware/ram/iob_ram_sp_be/hardware.mk

# copy external memory for axi interface
include hardware/axiram/hardware.mk

# generate and copy AXI4 wires to connect cache to axi memory
SRC+=$(BUILD_SIM_DIR)/iob_cache_axi_wire.vh
$(BUILD_SIM_DIR)/iob_cache_axi_wire.vh:
	./software/python/axi_gen.py axi_wire iob_cache_
	mv $(subst $(BUILD_SIM_DIR)/, , $@) $(BUILD_SIM_DIR)

# copy python script
SRC+=$(BUILD_SW_PYTHON_DIR)/hw_defines.py
$(BUILD_SW_PYTHON_DIR)/hw_defines.py: ./software/python/hw_defines.py
	cp $< $@