#include "Image.hlsl"

SPixel main(float3 position : POSITION, float2 uv : TEXCOORD)
{
	SPixel result;

	float4 pos = float4(position.xyz, 1.0f);

    result.position = mul(pos, wvpMatrix);

	result.uv = uv;

	return result;
}