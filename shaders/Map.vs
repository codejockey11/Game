#include "Map.hlsl"

SPixel main(float3 position : POSITION, float3 normal : NORMAL, float2 uv : TEXCOORD)
{
    SPixel result;
	
	float4 pos = float4(position.xyz, 1.0f);

    result.position = mul(pos, worldMatrix);
	result.position = mul(result.position, viewMatrix);
	result.position = mul(result.position, projectionMatrix);

	result.normal = normal;
	
    result.uv = uv;

    result.shadowPos = mul(pos, worldMatrix);
    result.shadowPos = mul(result.shadowPos, l_viewMatrix);
    result.shadowPos = mul(result.shadowPos, l_projectionMatrix);
    
    float4 worldPosition = mul(pos, worldMatrix);

    result.lightPos = l_position.xyz - worldPosition.xyz;

    result.lightPos = normalize(result.lightPos);
	
	return result;
}