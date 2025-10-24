struct VertexOut
{
    float4 position : SV_POSITION;
};

cbuffer wvps : register(b0)
{
    row_major float4x4 worldMatrix;
    row_major float4x4 viewMatrix;
    row_major float4x4 projectionMatrix;
};

Texture2D gShadowMap : register(t0);