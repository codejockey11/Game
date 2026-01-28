#include "common.hlsl"

SPixel main(float3 position : POSITION, float3 normal : NORMAL, float2 uv : TEXCOORD)
{
    SPixel result;
	
    float4 pos = float4(position.xyz, 1.0f);

    result.vPos = mul(pos, m_world);
    
    result.wPos = result.vPos;
    
    result.vPos = mul(result.vPos, m_view);
    result.vPos = mul(result.vPos, m_proj);

    result.normal = normal;
	
    result.uv = uv;

    result.sPos = mul(result.wPos, m_lightView);
    result.sPos = mul(result.sPos, m_lightProj);
    
    return result;

}