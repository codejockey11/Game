struct SPixel
{
    float4 position : SV_POSITION;
    float3 normal : NORMAL;
    float2 uv : TEXCOORD0;
    float4 shadowPos : POSITION0;
    float3 lightPos : TEXCOORD1;
};

cbuffer wvps : register(b0)
{
    row_major float4x4 worldMatrix;
    row_major float4x4 viewMatrix;
    row_major float4x4 projectionMatrix;
    row_major float4x4 l_viewMatrix;
    row_major float4x4 l_projectionMatrix;
    float4 l_position;
    float4 l_direction;
};

cbuffer materials : register(b1)
{
    float4 m_ambient;
    float4 m_diffuse;
    float4 m_emissive;
    float4 m_specular;
    int m_illum;
    float m_opacity;
    float m_opticalDensity;
    float m_specularExponent;
    int hasmap_Kd;
    int hasmap_Ka;
    int hasmap_Ks;
    int hasmap_Ns;
    int hasmap_d;
    int hasmap_bump;
};

Texture2D gShadowMap : register(t0);

Texture2D gTextureMaps[3] : register(t1);
