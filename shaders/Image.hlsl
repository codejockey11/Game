struct SPixel
{
    float4 position : SV_POSITION;
    float2 uv : TEXCOORD;
};

cbuffer wvps : register(b0)
{
    row_major float4x4 wvpMatrix;
    float4 highlight;
};

Texture2D texture0 : register(t0);
