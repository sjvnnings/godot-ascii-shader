# Godot ASCII Post Processing Shader
A post processing shader that renders the scene as ASCII characters in the Godot game engine. Supports GLES2 and GLES3.

![Spinning Sphere Rendered Using the Post Processing Effect](https://github.com/sjvnnings/godot-ascii-shader/blob/main/renders/ascii_render.gif?raw=true)

Simply throw the shader on a Shader Material and use as a post processing effect as outlined in the [Godot documentation](https://docs.godotengine.org/en/stable/tutorials/viewports/custom_postprocessing.html).

Since the shader uses a sequence of textures to render the characters, the font can be changed by rasterizing select characters from your chosen font and swapping them with the current textures. Please ensure all character textures are of equal dimensions.

The include character textures are rasterizations of the Courier Prime Bold Italic font, available on [Google Fonts](https://fonts.google.com/specimen/Courier+Prime#about) and licensed under the [Open Font License](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL).
