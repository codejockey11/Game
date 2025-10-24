#include "Shadows.hlsl"

VertexOut main(float3 position : POSITION)
{
    VertexOut vs;
    
    float4 pos = mul(float4(position, 1.0f), worldMatrix);

    vs.position = mul(pos, mul(viewMatrix, projectionMatrix));
	
    return vs;
}