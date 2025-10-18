#include "Collectable.hlsl"

SPixel main(float3 position : POSITION, float3 normal : NORMAL, float2 uv : TEXCOORD)
{
    SPixel result;

    float4 pos = float4(position.xyz, 1.0f);

    result.position = mul(pos, worldMatrix);
    result.position = mul(result.position, viewMatrix);
    result.position = mul(result.position, projectionMatrix);

    result.normal = normal;

    result.uv = uv;

    result.ShadowPosH = mul(pos, worldMatrix);
    result.ShadowPosH = mul(result.ShadowPosH, l_viewMatrix);
    result.ShadowPosH = mul(result.ShadowPosH, l_projectionMatrix);
    
    return result;
}