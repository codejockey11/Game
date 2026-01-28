struct SPixel
{
    float4 vPos : SV_POSITION;
    float3 normal : NORMAL;
    float2 uv : TEXCOORD0;
    float4 wPos : TEXCOORD1;
    float4 sPos : POSITION0;
};

// 64 * 5 + (16 * 4) = 384
cbuffer wvps : register(b0)
{
    row_major float4x4 m_world;
    row_major float4x4 m_view;
    row_major float4x4 m_proj;
    row_major float4x4 m_lightView;
    row_major float4x4 m_lightProj;
    float4 m_camPosition;
    float4 m_camDirection;
    float4 m_lightPosition;
    float4 m_lightDirection;
};

// 16 * 4 + (4 * 10) = 104
cbuffer materials : register(b1)
{
    float4 m_ambient;
    float4 m_diffuse;
    float4 m_emissive;
    float4 m_specular;
    uint m_illum;
    float m_opacity;
    float m_opticalDensity;
    float m_specularExponent;
    uint hasmap_Kd;
    uint hasmap_Ka;
    uint hasmap_Ks;
    uint hasmap_Ns;
    uint hasmap_d;
    uint hasmap_bump;
};

#define MAX_LIGHTS 8

// 48
struct s_light
{
    float4 m_position;
    float4 m_direction;
    float3 m_color;
    float m_radius;
};

// 16 + (48 * 24) = 1168
cbuffer lights : register(b2)
{
    uint4 m_lightCount;

    s_light m_linears[MAX_LIGHTS];
    s_light m_points[MAX_LIGHTS];
    s_light m_directionals[MAX_LIGHTS];
}

#define MAX_BLENDS 8

// 16
struct s_blend
{
    uint m_index;
    uint m_scaleX;
    uint m_scaleY;
    uint m_filler;
};

// 16 * 8 = 128
cbuffer blends : register(b3)
{
    s_blend m_blends[MAX_BLENDS];
}

Texture2D gShadowMap : register(t0);

#define MAX_TEXTURES 10

Texture2D gTextureMaps[MAX_TEXTURES] : register(t1);

float3 Shadows(float3 color, float3 normal, float4 light, float4 pixel, Texture2D shadowMap, SamplerComparisonState samplerComparisonState)
{
    float2 shadowTexCoords;
    
    shadowTexCoords.x = 0.5f + (light.x / light.w * 0.5f);
    shadowTexCoords.y = 0.5f - (light.y / light.w * 0.5f);
    
    float pixelDepth = pixel.z / pixel.w;
    
    float margin = acos(saturate(dot(normal, light.xyz)));
    
    float epsilon = 0.0005 / margin;
    
    float lighting = shadowMap.SampleCmpLevelZero(samplerComparisonState, shadowTexCoords, pixelDepth + epsilon).r;

    color = float3(1.0, 1.0, 1.0);
    
    if (lighting < pixelDepth)
    {
        color = float3(1.0, 0.0, 0.0);
    }
    
    return color;
}

float3 Fog(float3 pixelColor, float depth, float density, float start, float end, float3 color, float min, float max)
{
    float fog = (depth - start) / (end - start);

    fog *= density;

    fog = clamp(fog, min, max);
        
    return lerp(pixelColor, color, fog);
}

float3 AllLights(float3 lightPosition, float radius, float3 color, float3 worldPosition, float3 normal, float3 view, float3 position)
{
    float3 lightVector = lightPosition - worldPosition;
    float dist = length(lightVector);
    lightVector = normalize(lightVector);
    
    float attenuation = saturate(1.0f - (dist / radius));
    
    float diffuseIntensity = saturate(dot(normal, lightVector));

    float specularStrength = 0.5;
    float3 viewDir = normalize(view - worldPosition);
    float3 reflectDir = reflect(-lightVector, normal);
    float spec = pow(max(dot(reflectDir, viewDir), 0.0), 32);
    
    float3 finalLight = saturate(color * diffuseIntensity * attenuation);
    
    return finalLight;
}

float3 Lighting(uint count, s_light lights[MAX_LIGHTS], float3 ambient, float3 wPos, float3 normal, float3 view, float3 position)
{
    float3 allLights = ambient;
    
    if (count >= MAX_LIGHTS)
    {
        count = MAX_LIGHTS;
    }

    [loop]
    for (uint i = 0; i < count; i++)
    {
        if (length(lights[i].m_position.xyz - wPos.xyz) <= lights[i].m_radius)
        {
            allLights += AllLights(lights[i].m_position.xyz, lights[i].m_radius, lights[i].m_color, wPos.xyz, normal, view, position);
        }
    }
    
    return saturate(allLights);
}
