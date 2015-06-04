// GLSL vertex program for rendering entities

attribute vec3 position;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;

uniform mat4 modelViewProjection;
uniform mat4 modelView;

varying vec4 varying_color;
varying vec2 varying_texCoord;
varying vec3 varying_normal;
varying vec3 varying_position;

void main()
{
    // Copy attributes to varyings
    varying_texCoord = texCoord;
    varying_color = color;
    
    // Transform model-space position, used for lighting by
    // fragment shader
    vec4 pos = modelView * vec4(position, 1);
    varying_position = pos.xyz / pos.w;
    
    // Transform normal; assuming only standard transforms
    // (Otherwise we'd need to have a special normal matrix)
    varying_normal = (modelView * vec4(normal, 0)).xyz;
    
    // Need projected position for transform
    gl_Position = modelViewProjection * vec4(position, 1);
}