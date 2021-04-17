//Godot ASCII Character Post Processing Shader.
//Written by Samuel Jennings and released under the MIT license.
shader_type canvas_item;

//The width and height, in pixels, of our character textures
uniform float char_width = 10.0;
uniform float char_height = 15.0;

//The textures used to render the text. They should all be equal size. Sorted from least to most brightest (i.e. Which ones have the most colored pixels).
//Supports 9 textures, plus absolute black and white included implicitly. You can change the number of textures to suit your needs.
//A texture array is not used here to support GLES2, however, you can easily rework the shader to use one if you are exclusively working with GLES3.
uniform sampler2D b1 : hint_albedo;
uniform sampler2D b2 : hint_albedo;
uniform sampler2D b3 : hint_albedo;
uniform sampler2D b4 : hint_albedo;
uniform sampler2D b5 : hint_albedo;
uniform sampler2D b6 : hint_albedo;
uniform sampler2D b7 : hint_albedo;
uniform sampler2D b8 : hint_albedo;
uniform sampler2D b9 : hint_albedo;

//Takes a greyscale color in character texture space and returns the appropriate output color (either an absolute color, or by sampling a texture).
float get_char_pixel(float grey, vec2 local_uv){
	float val = 0.0;
	vec4 col;
	
	//A long list of if/else statements comparing the greyscale value.
	//Not the most elegant or performant solution, but I find it's easy to read and expand for more characters.
	if(grey <= 0.0){
		col = vec4(0.0);
	}
	else if(grey <= 0.1){
		col = texture(b1, local_uv);
	}
	else if(grey <= 0.2){
		col = texture(b2, local_uv);
	}
	else if(grey <= 0.3){
		col = texture(b3, local_uv);
	}
	else if(grey <= 0.4){
		col = texture(b4, local_uv);
	}
	else if(grey <= 0.5){
		col = texture(b5, local_uv);
	}
	else if(grey <= 0.6){
		col = texture(b6, local_uv);
	}
	else if(grey <= 0.7){
		col = texture(b7, local_uv);
	}
	else if(grey <= 0.8){
		col = texture(b8, local_uv);
	}
	else if(grey <= 0.9){
		col = texture(b9, local_uv);
	}
	else{
		col = vec4(1.0);
	}
	
	//Return the greyscale value of the sampled color multiplied by its alpha (since we aren't working with transparency, it should just be black if the alpha is 0)
	return col.r * col.a;
}

void fragment(){
	//Get the UV as pixel coordinates. The shader essentially pixelates the screen, with the size of the pixel being determined by the character dimensions.
	float px = UV.x / TEXTURE_PIXEL_SIZE.x;
	float py = UV.y / TEXTURE_PIXEL_SIZE.y;
	
	//Clamp x and y to the nearest "pixel", i.e. some multiple of our character dimensions.
	float x = char_width * floor(px / char_width);
	float y = char_height * floor(py / char_height);
	
	//Go back from pixel to UV space
	vec2 new_uv = vec2(x * TEXTURE_PIXEL_SIZE.x, y * TEXTURE_PIXEL_SIZE.y);
	
	//Assumes the screen texture is greyscale.
	//If you're rendering a color scene, use a color to greyscale conversion instead.
	float g = texture(TEXTURE, new_uv).r;

	//The character-space UV, so we can render the character itself local to the "pixel"
	vec2 local_uv = vec2(px - x, py - y) / vec2(char_width, char_height);
	COLOR.rgb = vec3(get_char_pixel(g, local_uv));
}