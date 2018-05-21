tool
extends EditorPlugin

func _enter_tree():
    # Initialization of the plugin goes here
    # Add the new type with a name, a parent type, a script and an icon
    add_custom_type("MyButton", "Button", preload("res://addons/my_custom_node/src/CustomButton.gd"), preload("res://addons/my_custom_node/art/bt_icon.png"))

func _exit_tree():
    # Clean-up of the plugin goes here
    # Always remember to remove it from the engine when deactivated
    remove_custom_type("MyButtom")
