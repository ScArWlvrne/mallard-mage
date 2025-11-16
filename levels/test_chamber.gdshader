shader_type canvas_item;

// Declare the screen texture manually
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    // Sample the screen behind this shader
    vec4 screen_pixel = texture(SCREEN_TEXTURE, SCREEN_UV);
    
    // Calculate grayscale value
    float gray = dot(screen_pixel.rgb, vec3(0.3, 0.59, 0.11));

    // Output grayscale color with original alpha
    COLOR = vec4(vec3(gray), screen_pixel.a);
}