GD=godot
GD_EDITOR=-e
GD_FLAG=$(SCENE) #-d
GD_EXPORT=--export
GD_COLISION_FLAG=--debug-collisions

LINUX_PATH=build/Linux
LINUX_TARGET=SoulsOfAlanis
LINUX_BUILD="Linux_X11"

SCENE+=

.PHONY: testScene debugConlision editor buildLinux cleanLinux clean

testScene: $(SCENE)
	$(GD) $(GD_FLAG)

debugConlision: GD_FLAG += --debug-collisions
debugConlision: testScene

updateImports: GD_FLAG += --quit
updateImports: editor

editor:
	$(GD) $(GD_FLAG) $(GD_EDITOR)

buildLinux: $(LINUX_PATH)/$(LINUX_TARGET)

$(LINUX_PATH)/$(LINUX_TARGET):
	$(GD) $(GD_EXPORT) $(LINUX_BUILD) $(LINUX_PATH)/$(LINUX_TARGET)

cleanLinux:
	rm -f $(LINUX_PATH)/$(LINUX_TARGET)
	rm -f $(LINUX_PATH)/$(LINUX_TARGET).pck

clean: cleanLinux
