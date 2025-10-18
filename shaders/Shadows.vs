#include "Shadows.hlsl"

VertexOut main(float3 position : POSITION, float3 normal : NORMAL, float2 uv : TEXCOORD)
{
    VertexOut vs;
    
    float4 pos = mul(float4(position, 1.0f), worldMatrix);

    vs.position = mul(pos, mul(viewMatrix, projectionMatrix));
    
    vs.uv = uv;
	
    return vs;
}