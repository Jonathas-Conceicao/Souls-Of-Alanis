GD=godot
GDEDITOR=-e
GDFLAG=$(SCENE) #-d
GDEXPORT=--export

LINUX_PATH=build/Linux
LINUX_TARGET=SoulsOfAlanis
LINUX_BUILD="Linux_X11"

SCENE+=

.PHONY: testScene editor buildLinux cleanLinux clean

testScene: $(SCENE)
	$(GD) $(SCENE)

editor:
	$(GD) $(GDFLAG) $(GDEDITOR)

buildLinux: $(LINUX_PATH)/$(LINUX_TARGET)

$(LINUX_PATH)/$(LINUX_TARGET):
	$(GD) $(GDEXPORT) $(LINUX_BUILD) $(LINUX_PATH)/$(LINUX_TARGET)

cleanLinux:
	rm -f $(LINUX_PATH)/$(LINUX_TARGET)
	rm -f $(LINUX_PATH)/$(LINUX_TARGET).pck

clean: cleanLinux
