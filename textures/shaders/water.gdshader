shader_type canvas_item;

uniform float speed = 0.6;
uniform float scale = 6.0;
uniform float intensity = 0.6;
uniform vec4 water_color : source_color = vec4(0.1, 0.6, 0.7, 0.5);

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);

    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
           (c - a) * u.y * (1.0 - u.x) +
           (d - b) * u.x * u.y;
}

float fbm(vec2 p) {
    float v = 0.0;
    float a = 0.5;
    for (int i = 0; i < 4; i++) {
        v += a * noise(p);
        p *= 2.0;
        a *= 0.5;
    }
    return v;
}

void fragment() {
    vec2 uv = UV * scale;

    float t = TIME * speed;

    // Два слоя для интерференции (как на референсе)
    float n1 = fbm(uv + vec2(t, t));
    float n2 = fbm(uv - vec2(t * 0.7, t * 1.3));

    float caustics = abs(n1 - n2);

    // Усиливаем "линии"
    caustics = pow(caustics, 3.0);

    vec3 light = vec3(caustics) * intensity;

    vec3 final_color = water_color.rgb + light;

    COLOR = vec4(final_color, water_color.a);
}    