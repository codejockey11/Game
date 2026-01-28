struct SPixel
{
    float4 position : SV_POSITION;
    float2 uv : TEXCOORD;
};

// 16 * 4 = 64
cbuffer wvps : register(b0)
{
    row_major float4x4 wvpMatrix;
};

// 16 * 4 + (4 * 10) = 104
cbuffer material : register(b1)
{
    float4 m_ambient;
    float4 m_diffuse;
    float4 m_emissive;
    float4 m_specular;
    uint m_illum;
    float m_opacity;
    float m_opticalDensity;
    float m_specularExponent;
    uint hasmap_Kd;
    uint hasmap_Ka;
    uint hasmap_Ks;
    uint hasmap_Ns;
    uint hasmap_d;
    uint hasmap_bump;
};

Texture2D texture0 : register(t0);
