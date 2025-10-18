//---------------------------------------------------------------------------------------
// PCF for shadow mapping.
//---------------------------------------------------------------------------------------
float CalcShadowFactor(float4 shadowPosH, Texture2D texture, SamplerComparisonState samp)
{
    // Complete projection by doing division by w.
    shadowPosH.xyz /= shadowPosH.w;

    // Depth in NDC space.
    float depth = shadowPosH.z;

    uint width, height, numMips;
    texture.GetDimensions(0, width, height, numMips);

    // Texel size.
    float dx = 1.0f / (float) width;

    float percentLit = 0.0f;
    const float2 offsets[9] =
    {
        float2(-dx, -dx), float2(0.0f, -dx), float2(dx, -dx),
        float2(-dx, 0.0f), float2(0.0f, 0.0f), float2(dx, 0.0f),
        float2(-dx, +dx), float2(0.0f, +dx), float2(dx, +dx)
    };

    [loop]
    for (int i = 0; i < 9; ++i)
    {
        percentLit += texture.SampleCmpLevelZero(samp,
            shadowPosH.xy + offsets[i], depth).r;
    }
    
    //percentLit = 9.0f;
    return percentLit / 9.0f;
}

float3 Fog(float3 color, float depth)
{
    float fogDensity = 15.0;
    float minFog = 0.0;
    float maxFog = 1.0;
    float fogStart = 2.0;
    float fogEnd = 4096.0;
    float3 fogColor = float3(0.75, 0.75, 0.75);
    
    //float fog = (vs.position.w - fogStart) / (fogEnd - fogStart);
    float fog = (depth - fogStart) / (fogEnd - fogStart);
    fog *= fogDensity;
    fog = clamp(fog, minFog, maxFog);
        
    //final.rgb = lerp(final.rgb, fogColor, fog);
    return lerp(color, fogColor, fog);
}
