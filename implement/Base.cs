using Godot;
using System;

public class Base : Control
{
    // Member variables here, example:
    // private int a = 2;
    // private string b = "textvar";

    public override void _Ready()
    {
		GD.Print("hi");
		Sprite sprite = new Sprite();
		Texture texture = (Texture)ResourceLoader.Load("res://CraftingTactics_Object_Tilesheet.png");
		//sprite.texture = (Texture)ResourceLoader.Load("res://CraftingTactics_Object_Tilesheet.png");
		AddChild(sprite);
		sprite.SetTexture(texture);
		GD.Print(texture.GetWidth());
        // Called every time the node is added to the scene.
        // Initialization here
        
    }

//    public override void _Process(float delta)
//    {
//        // Called every frame. Delta is time since last frame.
//        // Update game logic here.
//        
//    }
}
