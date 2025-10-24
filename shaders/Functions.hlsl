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
