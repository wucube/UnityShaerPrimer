Shader "Book Reimplementations/Chapter_6.4/Diffuse Pixel-Level_HalfLambert"
{
    Properties
    {
        _Diffuse("Diffuse",Color) = (1,1,1,1)
    }
    
    SubShader
    {
        Pass
        {
            Tags {"LightMode" = "ForwardBase"}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Lighting.cginc"

            fixed4 _Diffuse;

            struct a2v
            {
                float4 vertex :POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos :SV_POSITION;
                float3 world_normal :TEXCOORD0;
            };

            v2f vert(a2v v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.world_normal = mul(v.normal,(float3x3)unity_WorldToObject);
                return o;
            }

            fixed4 frag(v2f i):SV_Target
            {
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;
                float3 world_light =  normalize(_WorldSpaceLightPos0.xyz);
                float3 world_normal = normalize(i.world_normal);
                
                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * (dot(world_light,world_normal) * 0.5 + 0.5);

                fixed3 color = diffuse+ambient;
                
                return fixed4(color,1.0);
            }
            
            ENDCG
        }
    }

    Fallback "Diffuse"
}
