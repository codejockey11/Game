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

cbuffer terrains : register(b2)
{
    int index0;
    int scaleX0;
    int scaleY0;

    int index1;
    int scaleX1;
    int scaleY1;

    int index2;
    int scaleX2;
    int scaleY2;

    int index3;
    int scaleX3;
    int scaleY3;

    int index4;
    int scaleX4;
    int scaleY4;

    int index5;
    int scaleX5;
    int scaleY5;

    int index6;
    int scaleX6;
    int scaleY6;

    int index7;
    int scaleX7;
    int scaleY7;
}

Texture2D gShadowMap : register(t0);

Texture2D gTextureMaps[6] : register(t1);
